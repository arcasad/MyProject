package board.model;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class BoardDAOImpl implements BoardDAO {

	private static BoardDAO boardDAO = null;

	private String url = null;
	private String username = null;
	private String password = null;

	public static BoardDAO getInstance() {
		if (boardDAO == null) {
			boardDAO = new BoardDAOImpl();
		}
		return boardDAO;
	}

	private BoardDAOImpl() {
		Properties pr = new Properties();
		String propertiesURI = this.getClass().getResource("").getPath().replace("%20", "") + "database.properties";
		try {
			InputStream is = new FileInputStream(propertiesURI);
			pr.load(is);

			Class.forName(pr.getProperty("driver"));
			url = pr.getProperty("url");
			username = pr.getProperty("username");
			password = pr.getProperty("password");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean registUser(MemberVO memberVO) {
		boolean result = false;
		
		Connection conn = null;
		PreparedStatement ps = null;
		
		StringBuffer sb = new StringBuffer();
		sb.append(" INSERT INTO job_member(user_id, user_name, user_pw, user_phone)");
		sb.append(" VALUES(?, ?, ?, ?)");
		
		try{
		conn = getConnection();
		ps = conn.prepareStatement(sb.toString());
		
		ps.setString(1, memberVO.getUser_id());
		ps.setString(2, memberVO.getUser_name());
		ps.setString(3, memberVO.getUser_pw());
		ps.setString(4, memberVO.getUser_phone());

		ps.executeUpdate();
		result = true;			
	
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		dbClose(ps, conn);
	} 
		return result;		
	}
	
	//ID중복검사
	   @Override
	   public int checkID(String usrid) {
	      
	      int re = 0;
	      
	      StringBuffer sql = new StringBuffer();
	      sql.append(" SELECT user_id FROM job_member");
	      sql.append(" WHERE user_id=?");

	      Connection conn = null;
	      PreparedStatement ps = null;
	      ResultSet rs=null;
	         
	      boolean result = false;
	      try{
	         conn=getConnection();
	         ps=conn.prepareStatement(sql.toString());
	         ps.setString(1, usrid);
	         rs = ps.executeQuery();
	         
	         if(rs.next()){
	            re = 1;//같은 아이디 존재
	         } else{
	                  throw new RuntimeException();
	                  //out.println("게시물은 없습니다.");
	         }
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally{
	         dbClose(ps, conn);
	      }
	      return re;
	   }
	
	
	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection(url, username, password);
	}

	private void dbClose(PreparedStatement ps, Connection conn) {
		if (ps != null)
			try {
				ps.close();
			} catch (Exception e) {}
		if (conn != null)
			try {
				conn.close();
			} catch (Exception e) {}
	}

	private void dbClose(ResultSet rs, PreparedStatement ps, Connection conn) {
		if (rs != null)
			try {
				rs.close();
			} catch (Exception e) {}
		if (ps != null)
			try {
				ps.close();
			} catch (Exception e) {}
		if (conn != null)
			try {
				conn.close();
			} catch (Exception e) {}
	}

	@Override
	public int getCountUserID(String user_id) {
		int result = -1;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) AS cnt FROM job_member");
		sql.append(" WHERE user_id = ? ");
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, user_id);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(rs, ps, conn);
		}
		return result;
	}
	
	@Override
	public List<BoardVO> getBoardList() {
	      return null;
	}

	
	@Override
	public MemberVO getUser(MemberVO memberVO) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT user_id, user_name ");
		sql.append(" FROM job_member ");
		sql.append(" WHERE user_id=? AND user_pw=? ");

		MemberVO userInfo = null;

		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, memberVO.getUser_id());
			ps.setString(2, memberVO.getUser_pw());
			rs = ps.executeQuery();

			if (rs.next()) {
				userInfo = new MemberVO();
				userInfo.setUser_id(rs.getString("user_id"));
				userInfo.setUser_name(rs.getString("user_name"));
			} else {}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null)
				try {
					ps.close();
				} catch (Exception e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {}
		}
		return userInfo;
	}
	
	@Override
	public List<BoardVO> getBoardList(long startNum, long endNum) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		List<BoardVO> list = new ArrayList<BoardVO>();

		StringBuffer sql = new StringBuffer();

		sql.append("SELECT B.*");
		sql.append(" FROM(SELECT rownum AS rnum, A.*");
		sql.append(" FROM (select b.no, b.title, b.user_id, m.user_name, ");
		sql.append(" DECODE(to_char(SYSDATE,'YYYY-MM-DD'), to_char(b.regdate,'YYYY-MM-DD'), to_char(b.regdate,'YYYY-MM-DD')");
		sql.append(" , to_char(b.regdate,'YYYY-MM-DD HH24:MI:SS')) as regdate, b.readcount");
		sql.append(" from job_board b, job_member m");
		sql.append(" where b.user_id = m.user_id");
		sql.append(" order by no desc) A ");
		sql.append(" ) B");
		sql.append(" WHERE rnum between ? and ?");

		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql.toString());
			ps.setLong(1, startNum);
			ps.setLong(2, endNum);
			rs = ps.executeQuery();
			while (rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setNo(rs.getLong("no"));
				boardVO.setTitle(rs.getString("title"));

				MemberVO memberVO = new MemberVO();
				memberVO.setUser_id(rs.getString("user_id"));
				memberVO.setUser_name(rs.getString("user_name"));

				boardVO.setMemberVO(memberVO);
				boardVO.setRegdate(rs.getString("regdate"));
				boardVO.setReadcount(rs.getInt("readcount"));
				list.add(boardVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(rs, ps, conn);
		}

		return list;
	}

	@Override
	public BoardVO getArticle(long no) {
		BoardVO boardVO = null;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" select b.no, b.title, b.user_id, m.user_name, b.content, ");
		sql.append(
				" DECODE(to_char(SYSDATE,'YYYY-MM-DD'), to_char(b.regdate,'YYYY-MM-DD'), to_char(b.regdate,'HH24:MI:SS') ");
		sql.append("       ,to_char(b.regdate,'YYYY-MM-DD HH24:MI:SS')) as regdate, b.readcount ");
		sql.append(" from job_board b, job_member m ");
		sql.append(" where b.user_id = m.user_id AND b.no=? ");

		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql.toString());
			ps.setLong(1, no);
			rs = ps.executeQuery();

			if (rs.next()) {
				boardVO = new BoardVO();
				boardVO.setNo(rs.getLong("no"));
				boardVO.setTitle(rs.getString("title"));
				boardVO.setContent(rs.getString("content"));

				MemberVO memberVO = new MemberVO();
				memberVO.setUser_id(rs.getString("user_id"));
				memberVO.setUser_name(rs.getString("user_name"));

				boardVO.setMemberVO(memberVO);
				boardVO.setRegdate(rs.getString("regdate"));
				boardVO.setReadcount(rs.getInt("readcount"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(rs, ps, conn);
		}
		return boardVO;
	}

	@Override
	public boolean insertBoard(BoardVO boardVO) {
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO job_board(no, title, content, user_id)");
		sql.append(" VALUES(seq_board.nextval, ?,?,?)");

		Connection conn = null;
		PreparedStatement ps = null;

		boolean result = false;

		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, boardVO.getTitle());
			ps.setString(2, boardVO.getContent());
			ps.setString(3, boardVO.getMemberVO().getUser_id());
			ps.executeUpdate();

			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(ps, conn);
		}
		return result;
	}

	@Override
	public long getArticleCount() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		long result = -1;

		String sql = "SELECT count(*) AS cnt from job_board";

		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			if (rs.next()) {
				result = rs.getLong("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(rs, ps, conn);
		}
		return result;
	}

	@Override
	public boolean deleteArticle(BoardVO boardVO) {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from job_board ");
		sql.append(" where no=? AND user_id=?");

		Connection conn = null;
		PreparedStatement ps = null;

		boolean result = false;

		System.out.println(boardVO);

		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@70.12.110.68:1521:xe", "jobteam", "jobteam");
			ps = conn.prepareStatement(sql.toString());
			ps.setLong(1, boardVO.getNo());
			ps.setString(2, boardVO.getMemberVO().getUser_id());

			if (ps.executeUpdate() == 1) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null)
				try {
					ps.close();
				} catch (Exception e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
		}
		return result;
	}

	@Override
	public boolean updateArticle(BoardVO boardVO) {
		System.out.print(boardVO);
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE job_board SET ");
		sql.append(" title=?, content=? ");
		sql.append(" WHERE no=? AND user_id=?");

		Connection conn = null;
		PreparedStatement ps = null;

		boolean result = false;
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@70.12.110.68:1521:xe", "jobteam", "jobteam");
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, boardVO.getTitle());
			ps.setString(2, boardVO.getContent());
			ps.setLong(3, boardVO.getNo());
			ps.setString(4, boardVO.getMemberVO().getUser_id());
			if (ps.executeUpdate() == 1) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null)
				try {
					ps.close();
				} catch (Exception e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
		}
		return result;
	}

	@Override
	public boolean updateReadcount(long no) {
		Connection conn = null;
		PreparedStatement ps = null;

		boolean result = false;

		StringBuffer sql = new StringBuffer();
		sql.append("Update job_board SET ");
		sql.append(" readcount = readcount +1 ");
		sql.append(" WHERE no=?");

		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql.toString());
			ps.setLong(1, no);

			if (ps.executeUpdate() == 1) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(ps, conn);
		}
		return result;
	}

	public BoardVO getArticleDetail(long no){
		BoardVO detail = null;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select no, title, user_id, readcount, content, regdate");	
		sql.append(" from job_board");
		sql.append(" where no=?");
		
		try{
			conn = getConnection();
			ps = conn.prepareStatement(sql.toString());
			ps.setLong(1, no);
			rs = ps.executeQuery();

			if(rs.next()){
				detail = new BoardVO();
				detail.setNo(rs.getLong("no"));
				detail.setTitle(rs.getString("title"));
				detail.setContent(rs.getString("content"));
				detail.setRegdate(rs.getString("regdate"));
				detail.setReadcount(rs.getInt("readcount"));
				} else{
						throw new RuntimeException();	
				}
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			dbClose(rs, ps, conn);
		}
		return detail;
	}

}
