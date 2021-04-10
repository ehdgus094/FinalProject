
drop table groups_member CASCADE CONSTRAINTS;
create table groups_member(
	num				number         PRIMARY KEY,
	name 			varchar2(15),
	role_name 		varchar2(10)   NOT NULL,
    role_number 	number(3) 	   NOT NULL					
);

select * from groups_member;


-- 	name 			varchar2(15)   CONSTRAINT FK_NAME_GROUPS REFERENCES member,
