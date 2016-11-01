<%@page import="board.model.BoardDAOImpl"%>
<%@page import="board.model.BoardDAO"%>
<%@page import="board.model.BoardVO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	long no=Integer.parseInt(request.getParameter("no"));
	BoardDAO boardDAO = BoardDAOImpl.getInstance();
	boardDAO.updateReadcount(no);
	BoardVO boardVO = boardDAO.getArticleDetail(no);
%>

<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>

<script type="text/javascript">
function confirm_delete() {
   var yn = confirm("정말로 삭제하시겠습니까?");
   
   if(yn) {
	  location.href='delete_action.jsp?no=<%=no%>';
   } 
}
</script>

</head>
<body>


<table border="1" width="1000px">
	<caption>게시물 상세보기</caption>
<tr>
	<th>No</th>
	<td><%=boardVO.getNo()%></td>
</tr>
<tr>
	<th>Title</th>
	<td><%=boardVO.getTitle()%></td>
</tr>
<tr>
	<th>User_id</th>
	<td>admin</td>
</tr>
<tr>
	<th>Regdate</th>
	<td><%=boardVO.getRegdate() %></td>
</tr><tr>
	<th>Readcount</th>
	<td><%=boardVO.getReadcount() %></td>
</tr>
<tr>
	<th>Content</th>
	<td><%=boardVO.getContent()%></td>
</tr>

</table><br/>

<input type="button" value=리스트보기 onclick="location.href='list.jsp'"/>
<input type="button" value=수정하기 onclick="location.href='update.jsp?no=<%=no%>'"/>
<input type="button" value="삭제하기" onclick="confirm_delete()"/>

</body>
</html>