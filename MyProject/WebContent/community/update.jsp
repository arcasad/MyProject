<%@page import="board.model.MemberVO"%>
<%@page import="board.model.BoardDAOImpl"%>
<%@page import="board.model.BoardVO"%>
<%@page import="board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
<%
	MemberVO userInfo = (MemberVO)session.getAttribute("userInfo");

	if((userInfo == null) || (!userInfo.getUser_id().equals("admin"))){%>
   		alert('관리자 권한이 아닙니다.');
   		location.href='javascript:history.back();';
<%}%>
</script>
</head>
<body>
<%
		long no = Long.parseLong(request.getParameter("no"));

		BoardDAO boardDAO = BoardDAOImpl.getInstance();
		BoardVO boardVO = boardDAO.getArticle(no);
%>

	<form action="update_action.jsp" method="post">

		<table border="1" width="1000px">
			<caption>게시물 수정하기</caption>		
			<tr>
				<th>글 번호</th>
				<td><%=boardVO.getNo()%><input type="hidden" name="no" value="<%=boardVO.getNo()%>"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="<%=boardVO.getTitle()%>"/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="name" value="admin" readonly="readonly"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" cols="30" rows="5"><%=boardVO.getContent()%></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="수정 완료"></td>
			</tr>
		</table>
	</form>
</body>
</html>