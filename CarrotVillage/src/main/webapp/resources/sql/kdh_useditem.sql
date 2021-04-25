drop table useditem cascade constraints;
create table useditem (
	num number primary key,
	id varchar2(20) references member(id) on delete cascade,
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
	longitude number,
	deadline varchar2(19),
	winner varchar2(20)
)

drop sequence useditem_seq
create sequence useditem_seq
select * from useditem

delete from useditem
	 
select rownum rnum, a.* from
							(select * from (select * from useditem
										    where location like '%일산서구%'
										   )
							where subject like '%' || '' || '%'
							or content like '%' || '' || '%'
							order by sold asc, decode(location, '경기 고양시 일산서구 가좌동', 1)
							) a