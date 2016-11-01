<%@page import="board.model.BoardDAOImpl"%>
<%@page import="board.model.BoardDAO"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String imsi = request.getParameter("user_id");
   int re=0;
   
   BoardDAO boardDAO = null;

   if (imsi != null) {
      boardDAO = BoardDAOImpl.getInstance();
      re = boardDAO.checkID(imsi);
   }
%>
 
<%=re%>