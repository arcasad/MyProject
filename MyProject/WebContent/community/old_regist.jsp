<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String address = request.getParameter("area");
%>        

<!DOCTYPE html>
<html lang= ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>회원 가입 페이지</title>
<style type="text/css">
@import url(../css/pc.css);
</style>
<script type="text/javascript" src="../js/xhr.js"></script>
<script type="text/javascript">

var idCheck_count = -1;
// -1 : 아이디 중복체크하지 않은 경우
// 0 : 아이디 사용가능한 경우
// 1 : 중복 아이디-사용 불가능한 경우


function check() {
	var f = document.regist;
	if(f.user_id.value === '') {
		alert('먼저 id를 입력하세요');
		f.user_id.focus();
		return;
	} else if(idCheck_count === -1) {
		alert('ID중복체크를 수행하세요');
		f.id_check.focus();
		return;
	} else if (idCheck_count === 1) {
		alert('사용가능한 아이디를 조회하세요');
		f.user_id.focus();
		return;
	}
	/* f.method = 'GET';
	f.action = 'regist_test.jsp'; */
	f.submit();
}

/* function idCheck(url) {
	var id = document.getElementById('id').value;
	if(id.trim() == )
	
	
}  */

function check_id() {
	var user_id = document.getElementById("id").value;
	
	if(user_id.trim() === '') {
		alert('아이디를 입력하세요');
		document.getElementById("id").focus();
		return;
	}
	sendRequest('idCheck.jsp', 'user_id=' + user_id, callback, 'Post')
} 

function change_id() {
	idCheck_count = -1;
	 document.getElementById('checkid').innerHTML = 
	      '아이디 중복확인을 체크하세요.';
}


function callback() {         
	if(xhr.readyState == 4) {
		if(xhr.status == 200) {
			idCheck_count = parseInt(xhr.responseText.trim());
			if(idCheck_count === 1) {
				document.getElementById("checkid").innerHTML = '이미 사용중인 아이디입니다';
				document.getElementById("id").focus();
				return;		 
			
			} else if (idCheck_count === 0) {
				document.getElementById("checkid").innerHTML = '가입가능 아이디입니다';
				document.getElementById("name").focus();
				return;
			} else {
				alert('시스템 오류입니다.');
			}
		}
	}
}	
function check2(url) {
	var password = document.getElementById('pw').value;
	var password2 = document.getElementById('pw2').value;
	
	var params = 'password='+ password + '&password2='+ password2
	sendRequest(url, params, callback2, 'GET');
} 

function callback2() {         
	if(xhr.readyState == 4) {
		if(xhr.status == 200) {
			document.getElementById('pwCheck').innerHTML = xhr.responseText;
		}
	}
}
 
</script>

</head>
<body>
<form name="regist" method="post" action="regist_action.jsp">
<table>
<tr>
	<td><img src="../images/sub_regist.jpg"></td>
</tr>
</table>
<hr/>
아이디 <input type="text" name="user_id" id="id" onkeyup="change_id();"/> 
		<input type="button" value="중복확인" name="id_check"
		onclick="check_id();"/><br/>
		<div id="checkid"></div><br/>
이　름 <input type="text" name="user_name" id="name"/><br/>
비　번 <input type="password" name="user_pw"  id="pw"/><br/> 
비번 2 <input type="password" name="user_pw2" id="pw2" onkeyup="check2('pwCheck.jsp');"/><br/>
		<div id="pwCheck"></div><br/>
폰　번 <input type="text" name="phone1" maxlength="3" size="3" 
		value="010" readonly="readonly"/>
		- <input type="text" name="phone2" maxlength="4" size="4"/>
		- <input type="text" name="phone3" maxlength="4" size="4"/>
<br/>

	
</form>
</body>
</html>