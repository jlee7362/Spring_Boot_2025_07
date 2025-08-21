package com.example.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReactionPointRepository {

	public int getSumReactionPoint(int loginedMemberId, String relTypeCode, int relId);

	public int increaseReactionPoint(int loginedMemberId, String relTypeCode, int relId);

}
