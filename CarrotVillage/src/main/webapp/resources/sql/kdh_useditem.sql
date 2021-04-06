drop table useditem
create table useditem (
	num number primary key,
	id varchar2(20),
	subject varchar2(90),
	content varchar2(900),
	register_date date,
	price number,
	location varchar2(90),
	sold varchar2(1) default 'n' check(sold in ('y', 'n')),
	image varchar2(100)
)
/*
 * id 외래키로 바꾸기
 */
create sequence useditem_seq
select * from useditem

delete from useditem