<%@page import="board.model.MemberVO"%>
<%@page import="board.model.BoardVO"%>
<%@page import="board.model.BoardDAOImpl"%>
<%@page import="board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- BoardVO boardVO = new BoardVO(); 와 같은 역할. --> 
<jsp:useBean id="boardVO" class="board.model.BoardVO"/>
<jsp:setProperty property="*" name="boardVO"/>
<%   
   MemberVO userInfo = (MemberVO)session.getAttribute("userInfo");
   boardVO.setMemberVO(userInfo);
   System.out.println(boardVO);
   BoardDAO boardDAO = BoardDAOImpl.getInstance();
   boolean result = boardDAO.insertBoard(boardVO);
%>
<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
<%   if(result) { %>
      alert('글이 등록되었습니다.');
      location.href='list.jsp';
<%    } else {   %>
      alert("글 등록 실패");
      location.href='javascript:history.back();';
<%   }%>
</script>
</body>
</html>