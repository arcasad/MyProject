<%@page import="board.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<script type="text/javascript">
<%
	MemberVO userInfo = (MemberVO)session.getAttribute("userInfo");
	if((userInfo == null)||(!userInfo.getUser_id().equals("admin"))){%>
   		alert('관리자 권한이 아닙니다.');
   		location.href='../community/list.jsp';
<%}%>
function validate() {
	var f = document.regist;

	f.method = 'POST';
	f.action = 'insert_action.jsp';
	f.submit();
}

</script>
	<form name="regist" method="post">
					<table>
						<caption>게시물 글쓰기</caption>
						<tr>
							<th>글 제 목</th>
							<td><input type="text" name="title" /></td>
						</tr>
						<tr>
							<th>글 내 용</th>
							<td><textarea name="content" cols="100" rows="30"></textarea></td>
						</tr>
					</table>
			</td>
					
					<table>
					<td>
						<tr>
							<td align="right"><a href="javascript:validate();">
							<img src="../images/btn_insert.gif" border="0"></a></td>
							<td align="left"><a href="notice.jsp">
							<img src="../images/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
			</td>
					
			</tr>
		</table>
	</form>
</body>
</html>