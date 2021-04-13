drop table useditem
create table useditem (
	num number primary key,
	id varchar2(20),
	subject varchar2(150),
	content varchar2(3000),
	register_date date,
	price number,
	location varchar2(90),
	sold varchar2(1) default 'n' check(sold in ('y', 'n')),
	imagefolder varchar2(100),
	thumbnail varchar2(30),
	viewcount number,
	latitude number,
	longitude number
)
/*
 * id 외래키로 바꾸기
 */
drop sequence useditem_seq
create sequence useditem_seq
select * from useditem

delete from useditem