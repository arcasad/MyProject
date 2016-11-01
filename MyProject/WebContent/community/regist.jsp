<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean idCheck_result=false;
%>
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style type="text/css">
@IMPORT url(../css/regist.css);
</style>
<script type="text/javascript" src="../js/xhr.js">
</script>

<script type="text/javascript">
var idChk=0;

function validate(){
	var f = document.regist;
	if(f.user_id.value===''){
		alert('먼저 id를 입력하세요.');
		f.user_id.focus();
		return;
	}
	f.method='GET';
	f.action = 'regist_test.jsp';
	f.submit();
}

//비번 체크
function checkPwd(){
	  var f1 = document.forms[0];
	  var pw1 = f1.user_pw.value;
	  var pw2 = f1.user_pw2.value;
	  if(pw1!=pw2){
	   document.getElementById('checkPwd').style.color = "red";
	   document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요."; 
	  }else{
	   document.getElementById('checkPwd').style.color = "blue";
	   document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다."; 
	  }	  
}

//아이디 체크
function usermsg(){
	alert("먼저 ID 중복 검사를 하세요.");
}

function checkId() {
	
	//이런 식으로 접근 가능
	idChk=1;
	document.getElementById("save").type="submit";
	document.getElementById("save").onclick=null;
	
	
	var f1 = document.forms[0];
	var id = f1.user_id.value;
	console.log(id);//그냥 확인하려고
	if(id == ''){
		alert('아이디를 먼저 입력하세요');
	}
	else if(id != ''){
		var params = "user_id="+encodeURIComponent(id);
		sendRequest("checkSameID.jsp", params, displayResult, 'POST');
	} else{
		document.getElementById('check_id_result').innerHTML = "아이디를 입력하세요.";
	}
}

function displayResult() {
	if (xhr.readyState == 4) {
 		if (xhr.status == 200) {
    		var resultText =xhr.responseText;
    		//checkSameID에서 값 받아오는 곳
    		
    		var listView = document.getElementById('check_id_result');
    		
    		if(resultText==0){
     			listView.innerHTML = "사용 할 수 있는 ID 입니다";
     			listView.style.color = "blue";
     			console.log(resultText);//그냥 확인하려고
     			
    		}else{
     			listView.innerHTML = "이미 등록된 ID 입니다";
     			listView.style.color = "red";
     			console.log(resultText);//그냥 확인하려고
    		}
   		} else {
    		alert("에러 발생: "+httpRequest.status);
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
</hr>
<table border="1">
	<caption>회원 가입</caption>
<tr>
    <th>아이디</th>
	<td><input type="text" name="user_id" id="user_id" />
		<input type="button" name="idChkcnt" value="id중복검사" onclick="checkId();"/>
		<div id="check_id_result">아이디를 입력하세요.<br/></div>
	</td>
</tr>
<tr>
	<th>이름</th>
	<td><input type="text" name="user_name" id="user_name" />
		<div id="check_name_result"></div>
	</td>
</tr>
<tr>
	<th>비밀번호</th>
     <td><input type="password" name="user_pw" /><br/>
		 <input type="password" name="user_pw2" onkeyup="checkPwd()"/>
	        <div id="checkPwd">동일한 암호를 입력하세요.</div>
	</td>
</tr>
<tr>
	<th>전화</th>
	<td><input type="text" name="user_phone" id="user_phone" /></td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="button" value="가입하기" id="save" onclick="usermsg()"/>
	</td>
</tr>
</table>
</form>
</body>
</html>