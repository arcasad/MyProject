<%@page import="board.model.MemberVO"%>
<%@page import="board.model.BoardDAOImpl"%>
<%@page import="board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardVO" class="board.model.BoardVO"/>
<jsp:setProperty property="*" name="boardVO"/>
<%
	MemberVO userInfo = (MemberVO)session.getAttribute("userInfo");
	boardVO.setMemberVO(userInfo);
 	BoardDAO boardDAO = BoardDAOImpl.getInstance();
 	boolean result = boardDAO.deleteArticle(boardVO);
%>    
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body>
<script type="text/javascript">
<%
	if((userInfo == null)||(!userInfo.getUser_id().equals("admin"))){%>
   		alert('관리자 권한이 아닙니다.');
   		location.href='javascript:history.back();';
<%}%>

<% if(result) {  %>
	alert("글 삭제 성공");
	location.href="list.jsp";
<%} %>

</script>

</body>
</html>