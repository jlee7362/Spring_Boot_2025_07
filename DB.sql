DROP DATABASE `spring_2025_08`;
CREATE DATABASE `spring_2025_08`;
USE `spring_2025_08`;

# 게시글 테이블 생성
CREATE TABLE `article` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `regDate` DATETIME NOT NULL,
    `updateDate` DATETIME NOT NULL,
    `title` CHAR(100) NOT NULL,
    `body` CHAR(100) NOT NULL
);




# 회원 테이블 생성
CREATE TABLE `member` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `regDate` DATETIME NOT NULL,
    `updateDate` DATETIME NOT NULL,
    `loginId` CHAR(100) NOT NULL,
    `loginPw` CHAR(100) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반, 7=관리자)',
    `name` CHAR(100) NOT NULL,
    `nickname` CHAR(20) NOT NULL,
    `cellphoneNum` CHAR(20) NOT NULL,
    `email` CHAR(20) NOT NULL,
    `delStatus` TINYINT(1) UNSIGNED DEFAULT 0 COMMENT '탈퇴 여부(0=탈퇴 전, 1=탈퇴 후)',
    `delDate` DATETIME COMMENT '탈퇴 날짜'
);

# 게시판 테이블 생성
CREATE TABLE `board`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `regDate` DATETIME NOT NULL,
    `updateDate` DATETIME NOT NULL,
    `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항) free(자유) QnA(질의응답)',
    `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
    `delStatus` TINYINT(1) UNSIGNED DEFAULT 0 COMMENT '탈퇴 여부(0=탈퇴 전, 1=탈퇴 후)',
    `delDate` DATETIME COMMENT '탈퇴 날짜'
);



INSERT INTO `board`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `code` = 'notice',
    `name` = '게시판';
INSERT INTO `board`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `code` = 'free',
    `name` = '자유';
INSERT INTO `board`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `code` = 'QnA',
    `name` = '질의응답';

INSERT INTO `article`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `title` = '제목1',
    `body` = '내용1';
INSERT INTO `article`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `title` = '제목2',
    `body` = '내용2'; 
INSERT INTO `article`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `title` = '제목3',
    `body` = '내용3';    
INSERT INTO `article`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `title` = '제목4',
    `body` = '내용4'; 
INSERT INTO `article`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `title` = '제목5',
    `body` = '내용5'; 

INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'admin',
    `loginPw` = 'admin',
    `authLevel` = 7,
    `name` = '관리자',
    `nickname` = '관리자_닉네임',
    `cellphoneNum` = '01045644565',
    `email` = 'admin@gmail.com'; 
INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'test1',
    `loginPw` = 'test1',
    `authLevel` = 3,
    `name` = '회원1',
    `nickname` = '회원1_닉네임',
    `cellphoneNum` = '01066914545',
    `email` = '회원1@gmail.com'; 
INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'test2',
    `loginPw` = 'test2',
    `authLevel` = 3,
    `name` = '회원2',
    `nickname` = '회원2_닉네임',
    `cellphoneNum` = '01098765432',
    `email` = '회원2@gmail.com'; 

ALTER TABLE `article` ADD COLUMN `memberId` INT UNSIGNED NOT NULL AFTER `updateDate`;
UPDATE `article` 
SET `memberId` = 2
WHERE `id` IN (1,2);
UPDATE `article` 
SET `memberId` = 1
WHERE `id` IN (3);
UPDATE `article` 
SET `memberId` = 3
WHERE `id` IN (4,5);


ALTER TABLE `article` ADD COLUMN `boardId` INT UNSIGNED NOT NULL AFTER `memberId`;
UPDATE `article` 
SET `boardId` = 1
WHERE `id` IN (1,2);
UPDATE `article` 
SET `boardId` = 2
WHERE `id` IN (3,4);
UPDATE `article` 
SET `boardId` = 3
WHERE `id` IN (5);

ALTER TABLE `article` ADD COLUMN `hitCount` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `body`;

UPDATE `article`
SET `hitCount` = `hitCount`+1
WHERE `id` = 3;

SELECT *
FROM `article`;
SELECT *
FROM `member`;
SELECT *
FROM `board`;


SELECT a.*, m.nickname
FROM `article` a
INNER JOIN `member` m
ON a.memberId = m.id
WHERE a.`id` = 1
	
		
SELECT *
FROM `board`
WHERE `id` = 1;


SELECT a.*, m.nickname AS extra__writer
		FROM `article` a
		INNER JOIN `member` m
		ON a.memberId = m.id
		INNER JOIN `board` b
		ON a.boardId = b.id
		WHERE boardId = 1
		ORDER BY a.id DESC;

SELECT COUNT(*) AS cnt
		FROM `article`
		WHERE `title` LIKE CONCAT('%','777','%')
		
################################################################
#좋아요 테이블 생성, 데이터 5개 입력
CREATE TABLE `reactionPoint` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`regDate` DATETIME NOT NULL,
	`updateDate` DATETIME NOT NULL,
	`memberId` INT NOT NULL,
	`relTypeCode` CHAR(50) NOT NULL COMMENT '관련 데이터 타입코드',
	`relId` INT NOT NULL COMMENT '관련 데이터 번호',
	`point` INT NOT NULL
);

# 1번 회원이 3번글이 좋아요.
INSERT INTO `reactionPoint` 
SET`regDate`= NOW(),
	`updateDate`= NOW(),
	`memberId`= 1,
	`relTypeCode`= 'article',
	`relId`= 3,
	`point`= 1;
	
# 1번 회원이 4번글이 싫어요.
INSERT INTO `reactionPoint` 
SET`regDate`= NOW(),
	`updateDate`= NOW(),
	`memberId`= 1,
	`relTypeCode`= 'article',
	`relId`= 4,
	`point`= -1;
	
# 2번 회원이 3번글이 싫어요.
INSERT INTO `reactionPoint` 
SET`regDate`= NOW(),
	`updateDate`= NOW(),
	`memberId`= 2,
	`relTypeCode`= 'article',
	`relId`= 3,
	`point`= -1;

# 2번 회원이 4번글이 좋아요.
INSERT INTO `reactionPoint` 
SET`regDate`= NOW(),
	`updateDate`= NOW(),
	`memberId`= 2,
	`relTypeCode`= 'article',
	`relId`= 4,
	`point`= 1;

# 3번 회원이 3번글이 좋아요.
INSERT INTO `reactionPoint` 
SET`regDate`= NOW(),
	`updateDate`= NOW(),
	`memberId`= 3,
	`relTypeCode`= 'article',
	`relId`= 3,
	`point`= 1;
	
# 3번 회원이 4번글이 좋아요.
INSERT INTO `reactionPoint` 
SET`regDate`= NOW(),
	`updateDate`= NOW(),
	`memberId`= 3,
	`relTypeCode`= 'article',
	`relId`= 4,
	`point`= 1;
################################################################

SELECT *
FROM `article` a
INNER JOIN `member` m
ON a.`memberId` = m.id
JOIN `reactionPoint` rp
ON a.id = rp.relId AND rp.relTypeCode = 'article';

#서브쿼리
SELECT a.*, IFNULL(SUM(rp.point), 0) AS 'extra__sumReactionPoint', 
IFNULL(SUM(IF(rp.point > 0, rp.point,0)),0) AS 'extra__goodReactionPoint',
IFNULL(SUM(IF(rp.point<0, rp.point,0)),0) AS 'extra__badReactionPoint'
FROM(SELECT a.*, m.nickname AS extra__writer
	FROM `article` a
	INNER JOIN `member` m
	ON a.memberId = m.id) AS a
LEFT JOIN `reactionPoint` AS rp
ON a.id = rp.relId AND rp.relTypeCode='article'
GROUP BY a.id;

# 조인쿼리
SELECT a.*, IFNULL(SUM(rp.point), 0) AS 'extra__sumReactionPoint', 
IFNULL(SUM(IF(rp.point > 0, rp.point,0)),0) AS 'extra__goodReactionPoint',
IFNULL(SUM(IF(rp.point<0, rp.point,0)),0) AS 'extra__badReactionPoint'
FROM `article` a
INNER JOIN `member` m
ON a.memberId = m.id
LEFT JOIN `reactionPoint` AS rp
ON a.id = rp.relId AND rp.relTypeCode='article'
GROUP BY a.id
HAVING a.id = 3;

############################################
#<좋아요, 싫어요> ->게시글 저장
# update join -> 기존 게시글에 '좋아요' '싫어요' article table에 수정.
ALTER TABLE `article` ADD COLUMN `goodReactionPoint` INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `article` ADD COLUMN `badReactionPoint` INT UNSIGNED NOT NULL DEFAULT 0;

SELECT *
FROM `article`a
INNER JOIN `reactionPoint` rp
ON a.id = rp.relId;


#######################################
#article테이블에 RP 칼럼 추가, update join
UPDATE `article` AS a
INNER JOIN (
	SELECT rp.relTypeCode, rp.relId, 
	SUM(IF(rp.point >0, rp.point,0)) AS goodReactionPoint,
	SUM(IF(rp.point <0, rp.point * -1,0)) AS badReactionPoint
	FROM `reactionPoint` rp
	GROUP BY rp.relTypeCode, rp.relId	
) AS rp_sum
ON a.id = rp_sum.relId
SET a.goodReactionPoint = rp_sum.goodReactionPoint,
	a.badReactionPoint = rp_sum.badReactionPoint;

###############################################
# 게시글 데이터 대량 생성1 (2배수로 올라감)
INSERT INTO `article` (`regDate`, `updateDate`, `memberId`, `boardId`, `title`, `body`)
SELECT NOW(), NOW(), FLOOR(RAND() *2) + 2, FLOOR(RAND()*3)+1, CONCAT('제목__', RAND()), CONCAT('내용__',RAND())
FROM `article`;


# 게시글 데이터 대량 생성2

INSERT INTO `article`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `memberId` =  CEIL(RAND() * 3),
    `boardId` =  CEIL(RAND() * 3),
    `title` = CONCAT('제목', SUBSTRING(RAND() * 1000 FROM 1 FOR 2)),
    `body` = CONCAT('내용', SUBSTRING(RAND() * 1000 FROM 1 FOR 2));
    
    
    
    