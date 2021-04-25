package com.naver.myhome.main.Service;

import java.util.List;

import com.naver.myhome.main.domain.Board;
import com.naver.myhome.main.domain.BoardComment;
import com.naver.myhome.main.domain.BoardReply;

public interface BoardService {
        
	public int insert(Board board);
	public int getListCount(String search);
	public List<Board> getList(int page, int limit, String search, String orderBy);
	public Board getDetail(int num);
	public int readCount(int num);
	public int commentInsert(BoardComment boardComment);
	public int getCommentListCount(int boardNum);
	public List<BoardComment> getCommentList(int boardNum, int page, int limit, String sort);
	public int commentDelete(int num);
	public int replyInsert(BoardReply boardReply);
	public int getReplyListCount(int commentNum);
	public List<BoardReply> getReplyList(int commentNum);
	public int delete(int num);
	public int replyDelete(int num);
	public int existBoardLike(String id, int num, String tableName);
	public int deleteBoardLike(String id, int num, String tableName);
	public int insertBoardLike(String id, int num, String tableName);
	public int updateLike(String tableName, String field, String operator, int num);
	public int getLike(String tableName, String field, int num);
}
