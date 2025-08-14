DROP DATABASE IF EXISTS`spring_2025_08`;
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
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 여부(3=회원, 7=관리자)',
    `name` CHAR(100) NOT NULL,
    `nickname` CHAR(20) NOT NULL,
    `cellphoneNum` CHAR(20) NOT NULL,
    `email` CHAR(20) NOT NULL,
    `delStatus` TINYINT(1) UNSIGNED DEFAULT 0 COMMENT '탈퇴 여부(0=탈퇴 전, 1=탈퇴 후)',
    `delDate` DATETIME COMMENT '탈퇴 날짜'
);


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


INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'admin',
    `loginPw` = 'admin',
    `authLevel` = 7,
    `name` = '관리자',
    `nickname` = '관리자_닉네임',
    `cellphoneNum` = '010-123-4567',
    `email` = 'admin@gmail.com';
    
INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'test1',
    `loginPw` = 'test1',
    `authLevel` = 3,
    `name` = 'test1',
    `nickname` = '회원1_닉네임',
    `cellphoneNum` = '010-111-1111',
    `email` = 'test1@gmail.com';

INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'test2',
    `loginPw` = 'test2',
    `authLevel` = 3,
    `name` = 'test2',
    `nickname` = '회원2_닉네임',
    `cellphoneNum` = '010-222-2222',
    `email` = 'test2@gmail.com';
    
    
ALTER TABLE `article`ADD COLUMN `memberId` INT UNSIGNED NOT NULL AFTER `updateDate`;
ALTER TABLE `article`ADD COLUMN `boardId` INT UNSIGNED NOT NULL AFTER `memberId`;


UPDATE `article`
SET `memberId` = 2
WHERE `id` IN (1,2);

UPDATE `article`
SET `memberId` = 1
WHERE `id` IN (3);

UPDATE `article`
SET `boardId` = 2
WHERE `id` IN (1,2);

UPDATE `article`
SET `boardId` = 1
WHERE `id` IN (3);

SELECT * FROM `article`;
SELECT * FROM `member`;
DELETE FROM `member` WHERE `id` >3;

SELECT *
FROM `member`
WHERE `name` = 'test1' AND `email` = 'test1@gmail.com';

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


# 회원 데이터 대량 생성
INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = CONCAT('id', SUBSTRING(RAND() * 1000 FROM 1 FOR 3)),
    `loginPw` = CONCAT('pw', SUBSTRING(RAND() * 1000 FROM 1 FOR 3)),
    `name` = CONCAT('이름', SUBSTRING(RAND() * 1000 FROM 1 FOR 2));
    `nickname` = '회원2_닉네임';
    `cellphoneNum` = '010-222-2222';
    `email` = 'test2@gmail.com';
    
    
SELECT * FROM `article`;
SELECT * FROM `member`;
    