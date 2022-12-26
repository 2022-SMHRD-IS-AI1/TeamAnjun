package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PostDAO {

	// DB 연결용 객체 생성
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	int cnt = 0;

	// DB 연결용 getConn()
	public void getConn() {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
			String dbid = "cgi_4_1220_3";
			String dbpw = "smhrd3";
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// DB 연결용 객체 반환 close()
	public void close() {
		try {
			if(rs != null) {
				rs.close();
			}
			if(psmt != null) {
				psmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 글쓰기용 post()
	public int post(PostDTO dto) {
		getConn();
		// 게시물 순번(post_seq)는 시퀀스 사용
		// 게시물 작성일자(post_dt)는 CURRENT_DATE로 현재시각 입력
		// 게시물 추천수(post_likes), 게시물 비추천수(post_dislikes)는 기본값 0을 부여
		try {
			String sql = "INSERT INTO anjun_post VALUES (ANJUN_POST_SEQ.NEXTVAL, ?, CURRENT_DATE, ?, 0, 0, ?, ?, ?)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getPost_content());
			psmt.setString(2, dto.getUser_id());
			psmt.setString(3, dto.getPost_hashtag());
			psmt.setDouble(4, dto.getPost_lat());
			psmt.setDouble(5, dto.getPost_lng());
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}
	public ArrayList<PostDTO> getBoardSearch(String keyWord, String searchWord) {
		ArrayList<PostDTO> boards = new ArrayList<PostDTO>();
		PostDTO board = null;
		System.out.println(keyWord + "/" + searchWord);
		try {
			getConn();
			String sql = "select * from anjun_post where " +keyWord+ " like ?"; 
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, "\'%"+searchWord+"%\'");
			System.out.println(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int seq = rs.getInt("post_seq");
				String content = rs.getString("post_cntent");
				String date = rs.getString("post_dt");
				String id = rs.getString("user_id");
				int likes = rs.getInt("post_likes");
				int dislikes = rs.getInt("post_dislikes");
				String hashtag = rs.getString("post_hashtag");
				int lat = rs.getInt("post_lat");
				int lng = rs.getInt("post_lng");
				
				board = new PostDTO(seq, content, date, id, likes, dislikes, hashtag, lat, lng);
				boards.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return boards;
	}
	public int getCount(String keyWord, String searchWord) {
		int count = 0;
		
		try {
			getConn();
			String sql = "select post_seq as count from anjun_post where " + keyWord + " like ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, "%" + searchWord + "%");
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return count;
	}

	// 글삭제용 delete_post()
	public int delete_post(PostDTO dto) {
		getConn();
		// 게시물 순번(post_seq)로 anjun_post테이블 조회 후 데이터 삭제
		try {
			String sql = "DELETE FROM anjun_post WHERE post_seq=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, dto.getPost_seq());
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}

	// 글추천용 like_post()
	public int like_post(PostDTO dto) {
		getConn();
		// 기본 생성자에서 setter를 이용해 post_seq, post_likes를 가져오기
		try {
			String sql = "UPDATE anjun_post SET post_likes=? WHERE post_seq=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, dto.getPost_likes()+1);
			psmt.setInt(2, dto.getPost_seq());
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}
	
	// 글비추천용 dislike_post()
	public int dislike_post(PostDTO dto) {
		getConn();
		// 기본 생성자에서 setter를 이용해 post_seq, post_dislikes를 가져오기
		try {
			String sql = "UPDATE anjun_post SET post_dislikes=? WHERE post_seq=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, dto.getPost_dislikes()+1);
			psmt.setInt(2, dto.getPost_seq());
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}
}
