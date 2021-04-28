
drop table groups_join CASCADE CONSTRAINTS;
create table groups_join(
	num				  number(5)         PRIMARY KEY,
	groups_join_num	  number(5) references groups(num) on delete cascade,
	id 			  	  varchar2(15)   NOT NULL,
	birth		      varchar2(20),
	gender			  varchar2(5)		check (gender in ('m', 'f', 'x')),
	phone_num		  varchar2(20)
);

drop sequence groups_join_seq;
create sequence groups_join_seq;

insert into GROUPS_JOIN values (
	1, 15, '룰루', '20200101', 'x', '01012341234'
)

select * from groups_join;

select * from groups_join where id = 'jointest1' and groups_join_num =15;

delete groups_join;

select * from groups_join
where groups_join_num = 15;


-- 	mem_name 	varchar2(15)   CONSTRAINT FK_NAME_GROUPSMEMBER REFERENCES member,
--  name이 pk나 unique여야 fk로 참조가능..
