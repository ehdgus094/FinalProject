
drop table groups_like CASCADE CONSTRAINTS;
create table groups_like(
    num                  	   NUMBER(5)    	NOT NULL PRIMARY KEY, 
    groups_like_num            NUMBER(5)    	NOT NULL,    
    id                     varchar2(15)         NOT NULL,
    FOREIGN KEY (groups_like_num) REFERENCES groups(num),
    FOREIGN KEY (id) REFERENCES member(id)
);

create sequence groups_like_seq;

insert into groups_like 
values (1, 15, 'jointest1');

delete groups_like;
		
select * from groups_like;



  