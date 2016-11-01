<%@page import="board.model.ReserveVO"%>
<%@page import="board.model.ReserveDAO"%>
<%@page import="board.model.ReserveDAOImpl"%>
<%@page import="board.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cost = request.getParameter("cost");
	String room = request.getParameter("room");
	String date = request.getParameter("date");
	
	MemberVO userInfo = (MemberVO)session.getAttribute("userInfo");	
%>
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
<%
	if(userInfo == null) {%>
		alert('로그인 해주세요.');
		location.href='../community/login.jsp';
<% 	} else { %>
	<%
		ReserveVO reserveVO = new ReserveVO();
		reserveVO.setUser_id(userInfo.getUser_id());
		reserveVO.setUser_name(userInfo.getUser_name());
		reserveVO.setUser_phone(userInfo.getUser_phone());	
		reserveVO.setRe_year(Integer.parseInt(date.substring(0, 4)));
		reserveVO.setRe_month(Integer.parseInt(date.substring(5, 7)));
		reserveVO.setRe_day(Integer.parseInt(date.substring(8, 10)));
		reserveVO.setRe_room(Integer.parseInt(room));
		reserveVO.setRe_cost(Integer.parseInt(cost));
		
		ReserveDAO reserveDAO = ReserveDAOImpl.getInstance();
		boolean result = reserveDAO.reserveUser(reserveVO);
		
		if(result) { %>
			alert('<%=userInfo.getUser_name() %>님\n' + '<%=cost %>' +  '원\n' + '<%=room %>' + '인실\n' + '<%=date %>' + ' 예약이 완료되었습니다.\n예약화면으로 되돌아갑니다.');
			location.href='calendar.jsp?nowMonth='+<%=reserveVO.getRe_month() - 1%>;			
	<%	} else { %>
			alert('예약에 실패하였습니다.');
			location.href='javascript:history.back();';
	<%	}%>
<% } %>
</script>
</body>
</html>