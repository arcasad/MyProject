package board.model;

import java.util.List;

public interface BoardDAO {
	public boolean registUser(MemberVO memberVO); //회원가입
	public int checkID(String usrid);//id중복검사
	
	public int getCountUserID(String user_id);
	public MemberVO getUser(MemberVO memberVO);
	public List<BoardVO> getBoardList();
	public List<BoardVO> getBoardList(long startNum, long endNum);
	public BoardVO getArticle(long no);
	public boolean insertBoard(BoardVO boardVO);
	public long getArticleCount();
	public boolean deleteArticle(BoardVO boardVO);
	public boolean updateArticle(BoardVO boardVO);
	public boolean updateReadcount(long no);
	
	public BoardVO getArticleDetail(long no);
}
