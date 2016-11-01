<%@page import="board.model.MemberVO"%>
<%@page import="board.model.BoardDAO"%>
<%@page import="board.model.BoardDAOImpl"%>
<%@page import="board.model.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardVO" class="board.model.BoardVO"/>
<jsp:setProperty property="*" name="boardVO"/>
 <%
    MemberVO userInfo = (MemberVO)session.getAttribute("userInfo");
    boardVO.setMemberVO(userInfo);
 	BoardDAO boardDAO = BoardDAOImpl.getInstance();
 	boolean result = boardDAO.updateArticle(boardVO);
 %>

    
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<script type="text/javascript">
<% if(result) { %>
	alert("글 수정 성공");
	location.href="article.jsp?no=<%=boardVO.getNo()%>";
<%}%>
</script>
</body>
</html>