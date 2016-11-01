package board.model;

import java.io.Serializable;

public class BoardVO implements Serializable {
	private long no;
	private String title;
	private String regdate;
	private String content;
	private int readcount;
	private MemberVO memberVO;
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	@Override
	public String toString() {
		return "BoardVO [no=" + no + ", title=" + title + ", regdate=" + regdate + ", content=" + content
				+ ", readcount=" + readcount + ", memberVO=" + memberVO + "]";
	}
	
	
}
