package board.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReserveDAOImpl implements ReserveDAO {
   private static ReserveDAO reserveDAO = null;
   
   private ReserveDAOImpl(){};
   
   public static ReserveDAO getInstance() {
      if(reserveDAO == null) {
         reserveDAO = new ReserveDAOImpl();
      }
      return reserveDAO;
   }
   
   @Override
   public List<ReserveVO> getReserveList() {
      Connection conn = null;
      PreparedStatement ps = null;
      ResultSet rs = null;
      
      StringBuffer sql = new StringBuffer();
      sql.append(" select *");
      sql.append(" FROM job_reserve ");
      
      List<ReserveVO> list = new ArrayList<ReserveVO>();
      ReserveVO reserveVO = null;
      
      try {
         Class.forName("oracle.jdbc.OracleDriver");
         conn = DriverManager.getConnection("jdbc:oracle:thin:@70.12.110.68:1521:xe","jobteam","jobteam");
         ps = conn.prepareStatement(sql.toString());
         rs = ps.executeQuery();
         
         while(rs.next()) {
            reserveVO = new ReserveVO();
            reserveVO.setNo(rs.getInt("no"));
            reserveVO.setRe_day(rs.getInt("re_day"));
            reserveVO.setRe_month(rs.getInt("re_month"));
            reserveVO.setRe_year(rs.getInt("re_year"));
            reserveVO.setRe_room(rs.getInt("re_room"));
            reserveVO.setUser_id(rs.getString("user_id"));
            reserveVO.setUser_name(rs.getString("user_name"));
            reserveVO.setUser_phone(rs.getString("user_phone"));            
            reserveVO.setRe_cost(rs.getInt("Re_cost"));            
            list.add(reserveVO);
         }      
         
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         if(rs != null) try{rs.close();} catch(Exception e){}
         if(ps != null) try{ps.close();} catch(Exception e){}
         if(conn != null) try{conn.close();} catch(Exception e){}      
      }
      
      return list;
   }

@Override
public MemberVO getUser(MemberVO memberVO) {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	MemberVO userInfo = null;
	StringBuffer sql = new StringBuffer();
	sql.append(" SELECT user_id, user_name, user_phone, user_pw ");
	sql.append(" FROM JOB_member ");
	sql.append(" WHERE user_id=? AND user_pw=? ");
	
	
	try {
        Class.forName("oracle.jdbc.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@70.12.110.68:1521:xe","jobteam","jobteam");
		ps = conn.prepareStatement(sql.toString());
		ps.setString(1, memberVO.getUser_id());
		ps.setString(2, memberVO.getUser_pw());
		rs = ps.executeQuery();

		if(rs.next()){
			userInfo = new MemberVO();
			userInfo.setUser_id(rs.getString("user_id"));
			userInfo.setUser_name(rs.getString("user_name"));
			userInfo.setUser_phone(rs.getString("user_phone"));
			userInfo.setUser_pw(rs.getString("user_pw"));
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
        if(rs != null) try{rs.close();} catch(Exception e){}
        if(ps != null) try{ps.close();} catch(Exception e){}
        if(conn != null) try{conn.close();} catch(Exception e){}  
	}
	return userInfo;
}

@Override
public boolean reserveUser(ReserveVO reserveVO) {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	MemberVO userInfo = null;
	StringBuffer sql = new StringBuffer();
	sql.append(" INSERT INTO job_reserve ");
	sql.append(" VALUES(seq_reserve.nextval,?,?,?,?,?,?,?,?) ");
	System.out.println(reserveVO);
	boolean result = false;
	
	try {
        Class.forName("oracle.jdbc.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@70.12.110.68:1521:xe","jobteam","jobteam");
		ps = conn.prepareStatement(sql.toString());
		ps.setString(1, reserveVO.getUser_id());
		ps.setString(2, reserveVO.getUser_name());
		ps.setString(3, reserveVO.getUser_phone());
		ps.setInt(4, reserveVO.getRe_year());
		ps.setInt(5, reserveVO.getRe_month());
		ps.setInt(6, reserveVO.getRe_day());
		ps.setInt(7, reserveVO.getRe_room());
		ps.setInt(8, reserveVO.getRe_cost());
		ps.executeUpdate();
		result = true;
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
        if(rs != null) try{rs.close();} catch(Exception e){}
        if(ps != null) try{ps.close();} catch(Exception e){}
        if(conn != null) try{conn.close();} catch(Exception e){}  
	}
	return result;
}

	@Override
	public List<ReserveVO> getReserveUserList(MemberVO memberVO) {
	     Connection conn = null;
	      PreparedStatement ps = null;
	      ResultSet rs = null;
	      
	      StringBuffer sql = new StringBuffer();
	      if(memberVO.getUser_id().equals("admin")){
	    	  sql.append(" select no, user_id, user_name, user_phone, re_year, re_month, re_day, re_year||DECODE(length(re_month),1,'0'||re_month,re_month)||DECODE(length(re_day),1,'0'||re_day,re_day) as re_date, re_room, re_cost ");
	    	  sql.append(" FROM job_reserve ");
	    	  sql.append(" ORDER BY re_date ");	 
	      } else {
	    	  sql.append(" select no, user_id, user_name, user_phone, re_year, re_month, re_day, re_year||DECODE(length(re_month),1,'0'||re_month,re_month)||DECODE(length(re_day),1,'0'||re_day,re_day) as re_date, re_room, re_cost ");
	    	  sql.append(" FROM job_reserve ");
	    	  sql.append(" WHERE user_id=? AND user_name=? AND user_phone=? ");
	    	  sql.append(" ORDER BY re_date ");	    	  
	      }
	      
	      List<ReserveVO> list = new ArrayList<ReserveVO>();
	      ReserveVO reserveVO = null;
	      
	      try {
	         Class.forName("oracle.jdbc.OracleDriver");
	         conn = DriverManager.getConnection("jdbc:oracle:thin:@70.12.110.68:1521:xe","jobteam","jobteam");
	         ps = conn.prepareStatement(sql.toString());
		     if(memberVO.getUser_id().equals("admin")){
		    	 rs = ps.executeQuery();
		     } else {
		    	 ps.setString(1, memberVO.getUser_id());
		         ps.setString(2, memberVO.getUser_name());
		         ps.setString(3, memberVO.getUser_phone());
		         rs = ps.executeQuery();	    	  
		     }	         
	         
	         while(rs.next()) {
	            reserveVO = new ReserveVO();
	            reserveVO.setNo(rs.getInt("no"));
	            reserveVO.setRe_day(rs.getInt("re_day"));
	            reserveVO.setRe_month(rs.getInt("re_month"));
	            reserveVO.setRe_year(rs.getInt("re_year"));
	            reserveVO.setRe_room(rs.getInt("re_room"));
	            reserveVO.setUser_id(rs.getString("user_id"));
	            reserveVO.setUser_name(rs.getString("user_name"));
	            reserveVO.setUser_phone(rs.getString("user_phone"));            
	            reserveVO.setRe_cost(rs.getInt("Re_cost"));            
	            list.add(reserveVO);
	            System.out.println(reserveVO.toString());
	         }      
	         
	      } catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         if(rs != null) try{rs.close();} catch(Exception e){}
	         if(ps != null) try{ps.close();} catch(Exception e){}
	         if(conn != null) try{conn.close();} catch(Exception e){}      
	      }	      
	      return list;
	}   
}