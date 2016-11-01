package board.model;

import java.util.List;

public interface ReserveDAO {
   public List<ReserveVO> getReserveList();
   public MemberVO getUser(MemberVO memberVO);
   public boolean reserveUser(ReserveVO reserveVO);
   public List<ReserveVO> getReserveUserList(MemberVO memberVO);
}