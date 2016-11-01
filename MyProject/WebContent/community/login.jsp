<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
</script>
</head>
<body>
<form action="login_action.jsp" method="post">
<table>
<tr>
	<td><img src="../images/sub_login.jpg"></td>
</tr>
</table>
<hr/>
	<th>아이디</th>
	<td><input type="text" name="user_id" required="required"/>	
</tr><br/>
<tr>
	<th>비밀번호</th>
	<td><input type="password" name="user_pw" required="required"/></td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="확인" />
		<input type="button" value="회원가입" onclick="location.href='regist.jsp'"/>
	</td>
</tr>
</table>
</form>
</body>
</html>