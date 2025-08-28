package com.example.demo.vo;

import lombok.Data;

@Data
public class Reply {
    private int id;
    private String regDate;
    private String updateDate;
    private int memberId;
    private String relTypeCode;
    private int relId;
    private String body;
	private String goodReactionPoint;
	private String badReactionPoint;

    private String extra__writer;
}