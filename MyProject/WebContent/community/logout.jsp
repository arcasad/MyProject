<%@page import="board.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberVO userInfo = (MemberVO)session.getAttribute("userInfo");
%>    
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
<tr>
	<td><img src="../images/sub_logout.jpg"></td>
</tr>
</table>
<script type="text/javascript">
<%if(userInfo==null) {%>
	alert('로그인 정보가 없습니다.');
	location.href="login.jsp";
<% } %>
</script>

<hr/>
${sessionScope.userInfo.user_name }
(${sessionScope.userInfo.user_id})님이 로그아웃 하였습니다.
<%
   session.invalidate();
%>
<a href="login.jsp">로그인</a>
</body>
</html>