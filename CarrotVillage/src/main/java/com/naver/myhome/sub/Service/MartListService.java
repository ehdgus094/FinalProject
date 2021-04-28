package com.naver.myhome.sub.Service;

import java.util.List;

import com.naver.myhome.sub.domain.MartDetail;
import com.naver.myhome.sub.domain.MartList;

public interface MartListService {
	
	public int addmart(MartList m);

	public List<MartList> listup(String martloc, String si , String gu);

	public int listupcount(String martloc, String si, String gu);

	public void insertsub(MartDetail md);

	public List<MartList> listview(int num);

	public List<MartDetail> listDeta(int num);

	public List<MartList> listup2();

	public int listupcount2();

	public List<MartDetail> detailview(int num);

	public int listDetaco(int num);

	public List<MartDetail> prinfo(int num);

	public int del(int num);

	

}
