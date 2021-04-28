package com.naver.myhome.main.Controller;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.myhome.main.Service.BoardService;
import com.naver.myhome.main.domain.Board;
import com.naver.myhome.main.domain.BoardComment;
import com.naver.myhome.main.domain.BoardReply;
import com.naver.myhome.market.Service.UsedItemService;

@Controller
@RequestMapping(value="board")
public class BoardController {
	
	@Autowired
    BoardService boardService;
	
	@Autowired
	UsedItemService usedItemService;
	
	//private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value="/list")
	public ModelAndView list(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
							 @RequestParam(value = "search", defaultValue = "", required = false) String search,
							 @RequestParam(value = "order_by", defaultValue = "board_date", required = false) String orderBy,
					   		 ModelAndView mv) {
		
		int limit = 20;
		int listcount = boardService.getListCount(search);
		int maxpage = (listcount + limit - 1) / limit;
		int startpage = ((page - 1) / 10) * 10 + 1;
		int endpage = startpage + 10 - 1;

		if (endpage > maxpage) {
			endpage = maxpage;
		}

		List<Board> list = boardService.getList(page, limit, search, orderBy);
		for (int i = 0; i < list.size(); i++) {
			String date = getListDate(list.get(i).getBoard_date());
			list.get(i).setBoard_date(date);
			list.get(i).setCommentListCount(boardService.getCommentListCount(list.get(i).getNum()));
		}
		
		mv.setViewName("board/list");
		mv.addObject("page", page);
		mv.addObject("maxPage", maxpage);
		mv.addObject("startPage", startpage);
		mv.addObject("endPage", endpage);
		mv.addObject("listCount", listcount);
		mv.addObject("list", list);
		mv.addObject("limit", limit);
		mv.addObject("order_by", orderBy);
		mv.addObject("search", search);
		
		return mv;
	}
	
	@RequestMapping(value="/write")
	public String write() {
		return "board/write";
	}
	
	@RequestMapping(value="/writeProcess")
	public String writeProcess(Board board, RedirectAttributes rattr) {
		SimpleDateFormat tz = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //타임존 세팅용
		tz.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
		Date today = new Date();
		board.setBoard_date(tz.format(today));
		/*
		Map<String, Object> m = new HashMap<String, Object>();
		Map<String, Object> m2 = new HashMap<String, Object>();
		m2.put("subject", "제목");
		m2.put("content", board.getSubject());
		usedItemService.test1(m2);
		m.put("subject", "today");
		m.put("content", tz.format(today));
		usedItemService.test1(m);
		*/
		int result = boardService.insert(board);
		if (result == 1) {
			rattr.addFlashAttribute("write_result", "게시물 작성 완료.");
		}
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/view")
	public ModelAndView view(@RequestParam(value = "num") int num,
							 @RequestParam(value = "id") String id,
							 ModelAndView mv) {
		
		Board board = boardService.getDetail(num);
		int existLike = boardService.existBoardLike(id, num, "board");
		
		mv.setViewName("board/view");
		mv.addObject("board", board);
		mv.addObject("existLike", existLike);
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="readCount")
	public void readCount(@RequestParam(value = "num") int num) {
		boardService.readCount(num);
	}
	
	@RequestMapping(value="/delete")
	public String boardDelete(@RequestParam(value = "num") int num, RedirectAttributes rattr) {
		int result = boardService.delete(num);
		if (result == 1) {
			rattr.addFlashAttribute("delete_result", "게시물 삭제 완료.");
		}
		return "redirect:/board/list";
	}
	
	@ResponseBody
	@RequestMapping(value="commentInsert")
	public void commentInsert(@RequestParam(value = "id") String id,
							  @RequestParam(value = "board_num") int board_num,
							  @RequestParam(value = "content") String content) {
		
		SimpleDateFormat tz = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //타임존 세팅용
		tz.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
		Date today = new Date();
		
		BoardComment boardComment = new BoardComment();
		boardComment.setMember_id(id);
		boardComment.setBoard_num(board_num);
		boardComment.setContent(content);
		boardComment.setComment_date(tz.format(today));
		
		boardService.commentInsert(boardComment);
	}
	
	@ResponseBody
	@RequestMapping(value="commentList")
	public Map<String, Object> commentList(@RequestParam(value = "board_num") int boardNum,
										   @RequestParam(value = "id") String id,
										   @RequestParam(value = "page", defaultValue = "1", required = false) int page,
										   @RequestParam(value = "sort", defaultValue = "comment_date desc", required = false) String sort) {
		int limit = 5;
		int listcount = boardService.getCommentListCount(boardNum);
		int maxpage = (listcount + limit - 1) / limit;
		int startpage = ((page - 1) / 10) * 10 + 1;
		int endpage = startpage + 10 - 1;

		if (endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<BoardComment> boardCommentList = boardService.getCommentList(boardNum, page, limit, sort);
		for (int i = 0; i < boardCommentList.size(); i++) {
			
			boardCommentList.get(i).setReplyListCount(boardService.getReplyListCount(boardCommentList.get(i).getNum()));
			
			int existLike = boardService.existBoardLike(id, boardCommentList.get(i).getNum(), "board_comment");
			if (existLike == 1) {
				boardCommentList.get(i).setLikeOnOff("on");
			} else {
				boardCommentList.get(i).setLikeOnOff("off");
			}
			
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("maxPage", maxpage);
		map.put("startPage", startpage);
		map.put("endPage", endpage);
		map.put("listCount", listcount);
		map.put("board_comment_list", boardCommentList);
		map.put("limit", limit);
		map.put("sort", sort);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="commentDelete")
	public void commentDelete(@RequestParam(value = "num") int num) {
		boardService.commentDelete(num);
	}
	
	@ResponseBody
	@RequestMapping(value="replyInsert")
	public void replyInsert(@RequestParam(value = "id") String id,
							@RequestParam(value = "comment_num") int comment_num,
							@RequestParam(value = "content") String content) {
		
		SimpleDateFormat tz = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //타임존 세팅용
		tz.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
		Date today = new Date();
		
		BoardReply boardReply = new BoardReply();
		boardReply.setMember_id(id);
		boardReply.setComment_num(comment_num);
		boardReply.setContent(content);
		boardReply.setReply_date(tz.format(today));
		
		boardService.replyInsert(boardReply);
	}

	@ResponseBody
	@RequestMapping(value="replyList")
	public Map<String, Object> replyList(@RequestParam(value = "comment_num") int commentNum,
										 @RequestParam(value = "id") String id) {
		
		int listcount = boardService.getReplyListCount(commentNum);
		
		List<BoardReply> boardReplyList = boardService.getReplyList(commentNum);
		for (int i = 0; i < boardReplyList.size(); i++) {
			
			int existLike = boardService.existBoardLike(id, boardReplyList.get(i).getNum(), "board_reply");
			if (existLike == 1) {
				boardReplyList.get(i).setLikeOnOff("on");
			} else {
				boardReplyList.get(i).setLikeOnOff("off");
			}
			
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listCount", listcount);
		map.put("board_reply_list", boardReplyList);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="replyDelete")
	public void replyDelete(@RequestParam(value = "num") int num) {
		boardService.replyDelete(num);
	}
	
	@ResponseBody
	@RequestMapping(value="like")
	public Map<String, Object> like(@RequestParam(value = "id") String id,
					 				@RequestParam(value = "num") int num,
					 				@RequestParam(value = "table_name") String tableName) {
		
		String field = "";
		String onOff = "";
		
		switch (tableName) {
		case "board":
			field = "board_like";
			break;
		case "board_comment":
			field = "comment_like";
			break;
		case "board_reply":
			field = "reply_like";
			break;
		}
		
		int result = boardService.existBoardLike(id, num, tableName);
		
		if (result == 1) {
			boardService.deleteBoardLike(id, num, tableName);
			boardService.updateLike(tableName, field, "-", num);
			onOff = "off";
		} else {
			boardService.insertBoardLike(id, num, tableName);
			boardService.updateLike(tableName, field, "+", num);
			onOff = "on";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("like", boardService.getLike(tableName, field, num));
		map.put("onOff", onOff);
		return map;
	}
	
	
	private String getListDate(String date) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH) + 1;
		String month = "";
		
		if (m < 10) {
			month = "0" + m;
		} else {
			month = "" + m;
		}
		
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		String[] board_date_arr = date.substring(0, date.lastIndexOf(":")).split(" ");
		
		if (board_date_arr[0].equals(year + "-" + month + "-" + day)) {
			int hour = Integer.parseInt(board_date_arr[1].substring(0, board_date_arr[1].indexOf(":")));
			String minute = board_date_arr[1].substring(board_date_arr[1].indexOf(":"));
			if (hour > 12) {
				return "오후 " + (hour - 12) + minute;
			} else {
				return "오전 " + hour + minute;
			}
			
		} else {
			return board_date_arr[0];
		}
	}
}
