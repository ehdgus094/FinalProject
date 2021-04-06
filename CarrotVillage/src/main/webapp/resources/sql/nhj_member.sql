drop table member;
create table member (
	num				number			primary key,
	name			varchar2(15)	not null,
	password		varchar2(60),
	email			varchar2(50) 	not null,
	regi_date		date			default sysdate,
	profile_img		varchar2(200)	default 'default.png',
	profile_img_ori	varchar2(200)	default 'default.png',
	auth 			varchar2(50) 	default 'role_member' not null
);

drop sequence member_seq;
create sequence member_seq;

select * from member;

delete from member;