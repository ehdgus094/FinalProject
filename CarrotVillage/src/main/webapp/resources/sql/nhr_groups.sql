
drop table groups CASCADE CONSTRAINTS;
create table groups (
	num					number         PRIMARY KEY,
	name 				varchar2(15),
	subject				varchar2(100)  NOT NULL,
	content				varchar2(1500) NOT NULL,
	img_file			varchar2(100),
	img_file_ori		varchar2(100),
	regi_date			date 		   default sysdate,
	location 			varchar2(90),
	joined_member		number(5),
	like_count			number(5),
	view_count			number(5),
	price				varchar2(10),
	groups_member_num	number(5) CONSTRAINT FK_GROUPSMEMBERNUM_GROUPS REFERENCES groups_member 				
);

drop sequence groups_seq;
create sequence groups_seq;


select * from groups;

-- 공지사항(notice // con_notice) 추가? 
-- 	name 			varchar2(15)   CONSTRAINT FK_NAME_GROUPS REFERENCES member,
