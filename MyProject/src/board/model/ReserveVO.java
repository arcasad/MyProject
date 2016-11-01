package board.model;

public class ReserveVO {
   private int no;
   private String user_id;
   private String user_name;
   private String user_phone;
   private int re_year;
   private int re_month;
   private int re_day;
   private int re_room;
   private int re_cost;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public int getRe_year() {
		return re_year;
	}
	public void setRe_year(int re_year) {
		this.re_year = re_year;
	}
	public int getRe_month() {
		return re_month;
	}
	public void setRe_month(int re_month) {
		this.re_month = re_month;
	}
	public int getRe_day() {
		return re_day;
	}
	public void setRe_day(int re_day) {
		this.re_day = re_day;
	}
	public int getRe_room() {
		return re_room;
	}
	public void setRe_room(int re_room) {
		this.re_room = re_room;
	}
	public int getRe_cost() {
		return re_cost;
	}
	public void setRe_cost(int re_cost) {
		this.re_cost = re_cost;
	}
	@Override
	public String toString() {
		return "ReserveVO [no=" + no + ", " + (user_id != null ? "user_id=" + user_id + ", " : "")
				+ (user_name != null ? "user_name=" + user_name + ", " : "")
				+ (user_phone != null ? "user_phone=" + user_phone + ", " : "") + "re_year=" + re_year + ", re_month="
				+ re_month + ", re_day=" + re_day + ", re_room=" + re_room + ", re_cost=" + re_cost + "]";
	}
	   
}