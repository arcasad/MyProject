<%@page import="board.model.ReserveDAO"%>
<%@page import="board.model.ReserveDAOImpl"%>
<%@page import="board.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberVO memberVO = new MemberVO();
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	memberVO.setUser_id(user_id);
	memberVO.setUser_pw(user_pw);
	
	ReserveDAO reserveDAO = ReserveDAOImpl.getInstance();
	MemberVO userInfo = reserveDAO.getUser(memberVO);
%>
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
<% if(userInfo != null) { 
		session.setAttribute("userInfo", userInfo);%>
		alert('<%=userInfo.getUser_name()%>님이 접속하셨습니다.');
		location.href='../calendar/calendar.jsp';
<% } else {%>
		alert('로그인 실패!!');
		location.href='login.jsp';
<% } %>

</script>
</body>
</html>