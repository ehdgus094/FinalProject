
drop table review CASCADE CONSTRAINTS;
create table review (
	num			 number 	primary key,
	name		 varchar2(30),
	content		 varchar2(300),
	regi_date	 date 	default sysdate,
	review_groups_num	 references groups(num) on delete cascade, 
	review_re_lev		number(1)	check(review_re_lev in (0,1,2)), --원문이면 0, 답글이면 1
	review_re_seq		number, --원문이면 0, 1레벨이면 1레벨 시퀀스 +1
	review_re_ref		number  --댓글의 원문 글 번호
);

drop sequence rev_seq;
create sequence rev_seq;

select * from review;

delete review;

insert into review
values(rev_seq.nextval, '테스트닉네임', '테스트리뷰인서트 from db', sysdate, 16, 0, 0, rev_seq.nextval);
insert into review
values(rev_seq.nextval, '테스트답글', '테스트리뷰답글 from db', sysdate, 3, 1, rev_seq.nextval, 1);

delete review where name = '테스트닉네임';

alter table review rename column reg_date to regi_date;
alter table review rename column groups_num to review_groups_num;

select * from review;
				
				 			)

-- 	name		 varchar2(30) references member(name),