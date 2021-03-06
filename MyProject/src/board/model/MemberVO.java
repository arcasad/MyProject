package board.model;

public class MemberVO {
	private String user_id;
	private String user_pw;
	private String user_phone;
	private String user_name;
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	@Override
	public String toString() {
		return "MemberVO [user_name=" + user_name + ", user_id=" + user_id + ", user_phone=" + user_phone + ", user_pw="
				+ user_pw + "]";
	}
}
