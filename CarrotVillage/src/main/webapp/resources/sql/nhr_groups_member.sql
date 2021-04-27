
drop table groups_member CASCADE CONSTRAINTS;
create table groups_join(
	num				number         PRIMARY KEY,
	mem_name 		varchar2(15) ,
	role_name 		varchar2(10)   NOT NULL,
    role_number 	number(3) 	   NOT NULL					
);

select * from groups_member;


-- 	mem_name 	varchar2(15)   CONSTRAINT FK_NAME_GROUPSMEMBER REFERENCES member,
--  name이 pk나 unique여야 fk로 참조가능..
