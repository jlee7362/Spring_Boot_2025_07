package com.example.demo.vo;

import lombok.Getter;

@Getter
public class ResultData<DT> {
	
	private String resultCode;
	private String msg;
	private DT data1;
	private String data1Name;
	
	public static <DT>ResultData<DT> from(String resultCode, String msg) {
		return from(resultCode,msg,null,null);
	}
	
	public static <DT>ResultData<DT> from(String resultCode, String msg, DT data, String data1Name) {
		ResultData<DT> rd = new ResultData<DT>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1 = data;
		rd.data1Name = data1Name;
		
		return rd;
	}
	
	public boolean isSuccess() {
		return resultCode.startsWith("S-");
	}
	public boolean isFail() {
		return isSuccess()==false;
	}
	
	public static <DT>ResultData<DT> newData(ResultData rd, DT newData, String dataName) {
		return from(rd.getResultCode(),rd.getMsg(), newData, dataName);
	}
	

}
