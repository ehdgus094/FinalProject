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
	viewcount number
)
/*
 * id 외래키로 바꾸기
 */
drop sequence useditem_seq
create sequence useditem_seq
select * from useditem

delete from useditem

/*테스트용*/
insert into useditem
values(useditem_seq.nextval, '아이디', '제목', '내용', sysdate, 10000, '지역', 'n', null, null, 0);