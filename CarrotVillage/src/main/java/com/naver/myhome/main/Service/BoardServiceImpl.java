package com.naver.myhome.main.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.myhome.main.dao.BoardDAO;
import com.naver.myhome.main.domain.Board;
import com.naver.myhome.main.domain.BoardComment;
import com.naver.myhome.main.domain.BoardLike;
import com.naver.myhome.main.domain.BoardReply;
 
@Service
public class BoardServiceImpl implements BoardService {
    
	@Autowired
    BoardDAO dao;
    
	@Override
	public int insert(Board board) {
		return dao.insert(board);
	}

	@Override
	public int getListCount(String search) {
		return dao.getListCount(search);
	}

	@Override
	public List<Board> getList(int page, int limit, String search, String orderBy) {
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("search", search);
		map.put("orderBy", orderBy);
		return dao.getList(map);
	}

	@Override
	public Board getDetail(int num) {
		return dao.getDetail(num);
	}

	@Override
	public int readCount(int num) {
		return dao.readCount(num);
	}
	
	@Override
	public int delete(int num) {
		return dao.delete(num);
	}

	@Override
	public int commentInsert(BoardComment boardComment) {
		return dao.commentInsert(boardComment);
	}
	
	@Override
	public int getCommentListCount(int boardNum) {
		return dao.getCommentListCount(boardNum);
	}
	
	@Override
	public List<BoardComment> getCommentList(int boardNum, int page, int limit, String sort) {
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("boardNum", boardNum);
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("sort", sort);
		return dao.getCommentList(map);
	}
	
	@Override
	public int commentDelete(int num) {
		return dao.commentDelete(num);
	}
	
	@Override
	public int replyInsert(BoardReply boardReply) {
		return dao.replyInsert(boardReply);
	}
	
	@Override
	public int getReplyListCount(int commentNum) {
		return dao.getReplyListCount(commentNum);
	}
	
	@Override
	public List<BoardReply> getReplyList(int commentNum) {
		return dao.getReplyList(commentNum);
	}
	
	@Override
	public int replyDelete(int num) {
		return dao.replyDelete(num);
	}

	@Override
	public int existBoardLike(String id, int num, String tableName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("num", num);
		map.put("tableName", tableName);
		BoardLike boardLike = dao.getBoardLike(map);
		
		if (boardLike != null) {
			return 1;
		} else {
			return 0;
		}
	}

	@Override
	public int deleteBoardLike(String id, int num, String tableName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("num", num);
		map.put("tableName", tableName);
		return dao.deleteBoardLike(map);
	}

	@Override
	public int insertBoardLike(String id, int num, String tableName) {
		BoardLike boardLike = new BoardLike();
		boardLike.setMember_id(id);
		boardLike.setNum(num);
		boardLike.setTable_name(tableName);
		return dao.insertBoardLike(boardLike);
	}

	@Override
	public int updateLike(String tableName, String field, String operator, int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("field", field);
		map.put("operator", operator);
		map.put("num", num);
		return dao.updateLike(map);
	}

	@Override
	public int getLike(String tableName, String field, int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("field", field);
		map.put("num", num);
		return dao.getLike(map);
	}

}
