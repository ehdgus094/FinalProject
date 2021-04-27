package com.naver.myhome.market.Controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.context.annotation.ScopedProxyMode;

import com.naver.myhome.market.Service.CandidateService;
import com.naver.myhome.market.Service.UsedItemService;
import com.naver.myhome.market.domain.Candidate;
import com.naver.myhome.market.domain.UsedItem;

@Component
@Scope(scopeName = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class FreeItemThread extends Thread {
	private long milliSecond;
	private int num;
	
	@Autowired
	private CandidateService candidateService;
	
	@Autowired
	private UsedItemService usedItemService;
	
	@Override
	public void run() {
		try {
			Thread.sleep(milliSecond + 1000);
			UsedItem item = usedItemService.detail(num);
			if(item == null) {
				this.interrupt();
			}
			if(item.getWinner() == null && compareDate(item.getDeadline())) {
				List<Candidate> list = candidateService.selectList(num);
				if(!list.isEmpty()) {
					Random random = new Random();
					int n = random.nextInt(list.size());
					String winner = list.get(n).getId();
					usedItemService.setWinner(winner, num);
					candidateService.delete(num);
				}
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	public long getMilliSecond() {
		return milliSecond;
	}

	public void setMilliSecond(long milliSecond) {
		this.milliSecond = milliSecond;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	private boolean compareDate(String date) {
		if(date == null) {
			return false;
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //일반 변환용
		SimpleDateFormat tz = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //타임존 세팅용
		tz.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
		boolean resp = false;
		try {
			Date d = format.parse(date);
			Date today = new Date();
			today = format.parse(tz.format(today));
			if(d.getTime() <= today.getTime()) {
				resp = true;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return resp;
	}
	
}
