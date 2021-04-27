
drop table groups CASCADE CONSTRAINTS;
create table groups (
	num					number         PRIMARY KEY,
	name 				varchar2(15),
	subject				varchar2(100)  NOT NULL,
	content				varchar2(1500) NOT NULL,
	notice				varchar2(800),
	img_file			varchar2(100),
	img_file_ori		varchar2(100), 				--원래 파일명
	start_date			varchar2(16),
	end_date			varchar2(16),
	regi_date			date 		   default sysdate,
	location 			varchar2(90),
	latitude			number,
	longitude 			number,
	joined_member		number(5),
	like_count			number(5),
	view_count			number(5),
	price				varchar2(10)
);

drop sequence groups_seq;
create sequence groups_seq;


select * from groups;

update GROUPS
set latitude = 37.6380664 , longitude = 126.83267629999999
where subject = 'ㄴㄴ';

delete groups;

delete from GROUPS where name = '회원이름';

insert into GROUPS 
values (groups_seq.nextval, '회원이름' , '제목입니다.' , '내용입니다.' , '공지사항입니다.', null , null, '2021-04-13 15:30',
		'2021-04-14 14:40' , sysdate, '서울 종로구 봉익동', 37.57299080000001 , 126.99233249999999 , 5 , 10, 15, '무료');
			
-- 공지사항(notice // con_notice) 추가? 
-- 	name 			varchar2(15)   CONSTRAINT FK_NAME_GROUPS REFERENCES member,
--  time				varchar2(50), 어떻게 추가? hour min 나눠서? 아님 time으로?
--  groups_member_num	number(5) CONSTRAINT FK_GROUPSMEMBERNUM_GROUPS REFERENCES groups_member 권한은 후에 추가

