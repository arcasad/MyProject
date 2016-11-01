<%@page import="board.model.ReserveVO"%>
<%@page import="java.util.List"%>
<%@page import="board.model.ReserveDAO"%>
<%@page import="board.model.ReserveDAOImpl"%>
<%@page import="board.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(../css/calendar.css);
</style>
<script type="text/javascript">
</script>
</head>
<body>
<img src="../images/sub_reservationConfirm.jpg">
<div id="text"></div>
<script type="text/javascript">
var str = '';
<%
	MemberVO userInfo = (MemberVO)session.getAttribute("userInfo");
	if(userInfo == null){%>
		alert('먼저 로그인을 해주세요.');
		location.href='../community/login.jsp';
<%	} else { 
		ReserveDAO reserveDAO = ReserveDAOImpl.getInstance();
		List<ReserveVO> list = reserveDAO.getReserveUserList(userInfo);	%>
		str += '<table border="1">';
		str += '<tr>';
		str += '<td>아이디</td>';
		str += '<td>이름</td>';
		str += '<td>전화번호</td>';
		str += '<td>년</td>';
		str += '<td>월</td>';
		str += '<td>일</td>';
		str += '<td>인실</td>';
		str += '<td>가격</td>';
		str += '</tr>';
		
<%		for(ReserveVO vo : list) { %>
			str += '<tr>';
			str += '<td>'+'<%=vo.getUser_id()%>'+'</td>';
			str += '<td>'+'<%=vo.getUser_name()%>'+'</td>';
			str += '<td>'+'<%=vo.getUser_phone()%>'+'</td>';
			str += '<td>'+'<%=vo.getRe_year()%>'+'</td>';
			str += '<td>'+'<%=vo.getRe_month()%>'+'</td>';
			str += '<td>'+'<%=vo.getRe_day()%>'+'</td>';
			str += '<td>'+'<%=vo.getRe_room()%>'+'</td>';
			str += '<td>'+'<%=vo.getRe_cost()%>'+'</td>';
			str += '</tr>';
<%		} %>
			str += '</table>';
			document.getElementById("text").innerHTML = str;
<%	}	%>
</script>
</body>
</html>