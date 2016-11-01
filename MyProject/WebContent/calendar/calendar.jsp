
<%@page import="board.model.ReserveVO"%>
<%@page import="java.util.List"%>
<%@page import="board.model.ReserveDAOImpl"%>
<%@page import="board.model.ReserveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	int nowMonth = 0;
	if(request.getParameter("nowMonth") != null){
		nowMonth = Integer.parseInt(request.getParameter("nowMonth"));		
	} 	
%>
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(./css/calendar.css);
</style>
<script type="text/javascript">
var msg = null;
var date = null;
var currentYear = null;		//현재 년
var currentMonth = null;	//현재 월
var currentDate = null;		//현재 일

var currentDay = null;		//이번달 1일의 요일(0~6)

var lastDate = null;		//12개월 마지막 날짜들

var currentLastDate = null;	//현재 날짜

var memoryMonth = null;		//현재 월 저장

var nowMonth = <%=nowMonth %>;

var str = '';
function calendar(plus){	
	if(date == null) {	
		date = new Date();
		memoryMonth = date.getMonth();
		memoryYear = date.getFullYear();
		memoryDate = date.getDate();
		if(nowMonth == 0){
			date = new Date(memoryYear, memoryMonth, memoryDate);			
		} else {
			date = new Date(memoryYear, nowMonth, memoryDate);	
		}
	} else {
		currentMonth = date.getMonth() + plus;			
		date = new Date(currentYear, currentMonth, currentDate);		
	}
	currentYear = date.getFullYear();		//현재 년
	currentMonth = date.getMonth();			//현재 월 (0~11)
	currentDate = date.getDate();			//현재 일
	date.setDate(1);
	currentDay = date.getDay();				//이번달 1일의 요일(0~6)
	
	if((currentMonth + 1) >= 10) {
		msg = currentYear + '-' + (currentMonth + 1);		
	} else {
		msg = currentYear + '-0' + (currentMonth + 1);	
	}
	
	lastDate = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	
	if(currentYear % 4 === 0) {
		lastDate[1] = 29;	//윤달
	}		
	
	currentLastDate = lastDate[currentMonth];	//현재 달의 마지막 날짜
	
	var dayclass = new Array('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat');
	
// 	console.log(currentYear);
// 	console.log(currentMonth);
// 	console.log(currentDate);
// 	console.log(currentDay);
// 	console.log(lastDate);
// 	console.log(currentLastDate);
	str += '<form name="reserve">'
	str += '<table border="1">';
	str += '<tr align="center"><td colspan="14"><input type="button" value="<<" onclick="calendar(-1);"/>';
	str += '' + currentYear +"년" + (currentMonth + 1) + "월";
	str += '<input type="button" value=">>" onclick="calendar(1);"/></td></tr>';
	str += '<tr align="center">';
	str += '<td class="sun" colspan="2">일</td>';
	str += '<td colspan="2">월</td>';
	str += '<td colspan="2">화</td>';
	str += '<td colspan="2">수</td>';
	str += '<td colspan="2">목</td>';
	str += '<td colspan="2">금</td>';
	str += '<td colspan="2" class="sat">토</td>';
	str += '</tr><tr align="center">';
	for(var sp = 1; sp < currentDay + 1; sp++) {
		str += '<td colspan="2"></td>';
	}
	for(var d = 1, w = currentDay + 1, day = currentDay ; d <= currentLastDate ; d++, w++,day++ ) {
		str += '<td align="center" class="' + dayclass[day] + '">' + d+'</td>';

		if(((d < memoryDate) && (currentYear == memoryYear) && (currentMonth == memoryMonth))
			|| ((currentMonth < memoryMonth) && (currentYear == memoryYear))
			|| (currentYear < memoryYear)) {
			str += '<td><input type="button" id="room_2_'+ d +'" value="2인실" disabled="disabled"/><br/>';	
			str += '<input type="button" id="room_4_'+ d +'" value="4인실" disabled="disabled" /></td>';	
		} else {
			str += '<td><input type="button" id="room_2_'+ d +'" value="2인실" onclick="set(25000,2,msg,'+d+')";/><br/>';			
			str += '<input type="button" id="room_4_'+ d +'" value="4인실" onclick="set(50000,4,msg,'+d+')";/></td>';			
		}
		
		if(w % 7 == 0){
			str += '</tr><tr align="center">';
			day = -1;
		} 			

	}
	str += '</tr><tr><td colspan="14">';
	str += '<input type="text" name="cost" value="" id="cost" readonly="readonly" />요금정보';
	str += '<input type="text" name="double" value="" id="double" readonly="readonly"/><br/>';
	str += '<input type="text" name="room" value="" id="room" readonly="readonly"/>인실<br/>';
	str += '<input type="text" name="date" value="" id="date" readonly="readonly"/>선택날짜<br/>';
	str += '<input type="button" value="예약하기" onclick="validate();"/></td></tr>';
	str += '</table>';
	str += '</form>';
// 	console.log(str);
	document.getElementById("text").innerHTML = str;
	str = '';	//초기화
<%
	ReserveDAO reserveDAO = ReserveDAOImpl.getInstance();
	List<ReserveVO> list = reserveDAO.getReserveList();
%>
<%	for(ReserveVO vo : list){ %>
		if((currentYear == <%=vo.getRe_year()%>) && (currentMonth == <%=vo.getRe_month() - 1%>)){
			document.getElementById("room_"+<%=vo.getRe_room()%>+"_"+<%=vo.getRe_day()%>).value="예약불가";
			document.getElementById("room_"+<%=vo.getRe_room()%>+"_"+<%=vo.getRe_day()%>).disabled="disabled";
			if((memoryDate > <%=vo.getRe_day()%>)&&(memoryMonth == <%=vo.getRe_month() - 1%>)&&(memoryYear == <%=vo.getRe_year()%>)){
				document.getElementById("room_"+<%=vo.getRe_room()%>+"_"+<%=vo.getRe_day()%>).value="<%=vo.getRe_room()%>인실";
			}
		}
<%	} %>	
}

function set(cost, room, msg, date){
	if(msg.substring(5,7) === '07' || msg.substring(5,7) === '08') {
		document.getElementById("cost").value = cost * 2;		
		document.getElementById("double").value = '성수기';		
	} else {
		document.getElementById("cost").value = cost;
		document.getElementById("double").value = '비성수기';
	}
	document.getElementById("room").value = room;
	if(date >= 10) {
		document.getElementById("date").value = msg + '-' + date;		
	} else {
		document.getElementById("date").value = msg + '-0' + date;	
	}
}

function validate(){
	var f=document.reserve;	
	f.method = 'GET';
	f.action = 'reserve_action.jsp';
	f.submit();
}
</script>
</head>
<body>
<div id="text"></div>
<script type="text/javascript">
window.onload = function(){
	calendar();
}
</script>

</body>
</html>