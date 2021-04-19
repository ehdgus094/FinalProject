drop table candidate;
create table candidate(
	num number primary key,
	id varchar2(20),
	item_num number
)

drop sequence candidate_seq
create sequence candidate_seq

insert into candidate
values(candidate_seq.nextval, 'test1', 11);

select * from candidate

delete candidate