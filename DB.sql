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
    `name` CHAR(100) NOT NULL,
    `nickname` CHAR(20) NOT NULL,
    `cellphoneNum` CHAR(20) NOT NULL,
    `email` CHAR(20) NOT NULL
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
    `name` = '관리자',
    `nickname` = '관리자_닉네임',
    `cellphoneNum` = '010-123-4567',
    `email` = 'admin@gmail.com';
    
INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'test1',
    `loginPw` = 'test1',
    `name` = 'test1',
    `nickname` = '회원1_닉네임',
    `cellphoneNum` = '010-111-1111',
    `email` = 'test1@gmail.com';

INSERT INTO `member`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'test2',
    `loginPw` = 'test2',
    `name` = 'test2',
    `nickname` = '회원2_닉네임',
    `cellphoneNum` = '010-222-2222',
    `email` = 'test2@gmail.com';
    
SELECT * FROM `article`;
SELECT * FROM `member`;

ALTER TABLE `article` ADD COLUMN `memberId` INT NOT NULL AFTER `updateDate`;

UPDATE `article`
SET `memberId` = 1
WHERE `id` IN (1,2);

UPDATE `article`
SET `memberId` = 2
WHERE `id` = 3;

###############################################
# 게시글 데이터 대량 생성
INSERT INTO `article`
SET `regDate` = NOW(),
    `updateDate` = NOW(),
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
    
    