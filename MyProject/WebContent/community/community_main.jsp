<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Jeju Home</title>
</head>
<body>
<frameset framespacing="0" border="0" rows="150,*">
   <frame src="../main/upperBar.jsp" name="upper" scrolling="no" noresize/>
   <frameset cols="200,*">
      <frame src="../community/sideBar_community.jsp" name="side" scrolling="no" noresize/>
      <frame src="../community/list.jsp" name="center" scrolling="yes" noresize/>
   </frameset>
</frameset>
</body>
</html>