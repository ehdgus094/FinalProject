drop table candidate cascade constraints;
create table candidate(
	num number primary key,
	id varchar2(20) references member(id) on delete cascade,
	item_num number references useditem(num) on delete cascade
)

drop sequence candidate_seq
create sequence candidate_seq

insert into candidate
values(candidate_seq.nextval, 'test1', 11);

select * from candidate

delete candidate