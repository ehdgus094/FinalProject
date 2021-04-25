package com.naver.myhome.main.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.main.domain.Board;
import com.naver.myhome.main.domain.BoardComment;
import com.naver.myhome.main.domain.BoardLike;
import com.naver.myhome.main.domain.BoardReply;


@Repository
public class BoardDAO {
	 
	@Autowired
	private SqlSessionTemplate sqlSession;
	
    public int insert(Board board) {
    	return sqlSession.insert("board.insert", board);
    }

	public int getListCount(String search) {
		return sqlSession.selectOne("board.getListCount", search);
	}

	public List<Board> getList(Map<String, Object> map) {
		return sqlSession.selectList("board.getList", map);
	}

	public Board getDetail(int num) {
		return sqlSession.selectOne("board.getDetail", num);
	}

	public int readCount(int num) {
		return sqlSession.update("board.readCount", num);
	}
	
	public int delete(int num) {
		return sqlSession.delete("board.delete", num);
	}

	public int commentInsert(BoardComment boardComment) {
		return sqlSession.insert("board.commentInsert", boardComment);
	}
	
	public int getCommentListCount(int boardNum) {
		return sqlSession.selectOne("board.getCommentListCount", boardNum);
	}

	public List<BoardComment> getCommentList(Map<String, Object> map) {
		return sqlSession.selectList("board.getCommentList", map);
	}
	
	public int commentDelete(int num) {
		return sqlSession.delete("board.commentDelete", num);
	}
	
	public int replyInsert(BoardReply boardReply) {
		return sqlSession.insert("board.replyInsert", boardReply);
	}
	
	public int getReplyListCount(int commentNum) {
		return sqlSession.selectOne("board.getReplyListCount", commentNum);
	}

	public List<BoardReply> getReplyList(int commentNum) {
		return sqlSession.selectList("board.getReplyList", commentNum);
	}
	
	public int replyDelete(int num) {
		return sqlSession.delete("board.replyDelete", num);
	}

	public BoardLike getBoardLike(Map<String, Object> map) {
		return sqlSession.selectOne("board.getBoardLike", map);
	}

	public int deleteBoardLike(Map<String, Object> map) {
		return sqlSession.delete("board.deleteBoardLike", map);
	}

	public int insertBoardLike(BoardLike boardLike) {
		return sqlSession.insert("board.insertBoardLike", boardLike);
	}

	public int updateLike(Map<String, Object> map) {
		return sqlSession.update("board.updateLike", map);
	}
	
	public int getLike(Map<String, Object> map) {
		return sqlSession.selectOne("board.getLike", map);
	}
}
