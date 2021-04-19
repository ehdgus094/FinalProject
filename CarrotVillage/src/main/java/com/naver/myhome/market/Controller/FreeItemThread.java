package com.naver.myhome.market.Controller;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naver.myhome.market.Service.CandidateService;
import com.naver.myhome.market.Service.UsedItemService;
import com.naver.myhome.market.domain.Candidate;

@Component
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
			Thread.sleep(milliSecond);
			List<Candidate> list = candidateService.selectList(num);
			if(!list.isEmpty()) {
				Random random = new Random();
				int n = random.nextInt(list.size());
				String winner = list.get(n).getId();
				usedItemService.setWinner(winner, num);
				candidateService.delete(num);
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
}
