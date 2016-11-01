<%@page import="board.model.MemberVO"%>
<%@page import="board.model.BoardDAOImpl"%>
<%@page import="board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<jsp:useBean id="memberVO" class="board.model.MemberVO"/>
<jsp:setProperty property="*" name="memberVO"/>
<%
	BoardDAO boardDAO = BoardDAOImpl.getInstance();
	boolean result = boardDAO.registUser(memberVO);
	
	String idChkcnt=null;
	idChkcnt=request.getParameter("idChkcnt");
%>

<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>DB의 job_member에 insert</title>
</head>
<body>
<% if(result){%>
회원가입 되었습니다.

<a href="login.jsp">로그인</a>

<%	} else {
	out.println("<script>");
	out.println("alert('회원가입에 실패했습니다.');");
	out.println("location.href='javascript:history.back();';");
	out.println("</script>");
	
} %>

</body>
</html>