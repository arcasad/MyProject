<%@page import="board.model.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="board.model.BoardDAOImpl"%>
<%@page import="board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	long pg = 1;
	try {
		pg = Long.parseLong(request.getParameter("pg"));
	} catch(NumberFormatException e) {}
	
	int pageSize = 10; //한 페이지에 출력할 게시물 수 
	long startNum = (pg - 1) * pageSize + 1;
	long endNum = pg * pageSize;
%>    

<!DOCTYPE html>
<html lang="ko" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(../css/list.css);
</style>
</head>
<body>
<%
   //싱글톤이라 new 연산자 사용 불가
   BoardDAO boardDAO = BoardDAOImpl.getInstance();
   List<BoardVO> list = boardDAO.getBoardList(startNum,endNum);
   long articleCount = boardDAO.getArticleCount(); //게시물 총 개수
   
   long pageCount = articleCount / pageSize; 	   //페이지 총 개수
   if(articleCount % pageSize != 0) {
	   pageCount++;
   }
   int blockSize = 10; //한번에 보여줄 페이지 수 
   long startPage = ( pg - 1 ) / blockSize * blockSize + 1;
   long endPage = ( pg - 1 ) / blockSize * blockSize + blockSize;
   if(endPage > pageCount) {
	   endPage = pageCount;
   }
%>
<img src="../images/sub_notice.jpg">

<table border="1">
<tr>
   <td align="center">번호</td>
   <td>제목</td>
   <td>작성자</td>
   <td>등록날짜</td>
   <td>조회수</td>
</tr>
<% for(BoardVO boardVO : list) { %>
<tr>
   <td><%=boardVO.getNo() %></td>   <!-- no : 글번호 -->
   <td><a href="article.jsp?no=<%=boardVO.getNo() %>"><%=boardVO.getTitle() %></a></td>
   <td><%=boardVO.getMemberVO().getUser_name() %>(<%=boardVO.getMemberVO().getUser_id() %>)</td>
   <td><%=boardVO.getRegdate() %></td>
   <td><%=boardVO.getReadcount() %></td>
</tr>
<%      } %>


<tr>
	<td colspan="5">
<% if(startPage==1) { %>
[◀◀]
<% } else {%>
	<a href="list.jsp?pg=<%=startPage -1%>">	[◀◀] </a>
<% } %>
	<%for(long p=startPage; p <= endPage; p++) { %>
	
	<%if (p==pg) { %>
	<%=p %>
	<% } else { %>
	<a href = "list.jsp?pg=<%=p%>"><%=p %></a>
	<% }%>
	<% } %>
	
	<% if(endPage == pageCount) { %>
	[▶▶]
	<% } else { %>
<a href="list.jsp?pg=<%=endPage +1 %>">	[▶▶]</a>
<% } %>
	</td>
</tr>

</table>

[<a href="insert.jsp">글쓰기</a>]
</body>
</html>
