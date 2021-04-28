drop sequence board_seq;
create sequence board_seq;
drop table board cascade constraints;
create table board (
	num		  		  	number		  		primary key,
	member_id		  	varchar2(50)	  	references member(id),
	subject	  			varchar2(100)	 	not null,
	content	  			varchar2(4000)  	not null,
	readcount	  		number		  		default 0,
	board_date		  	date				,
	board_like		  	number		  		default 0,
	board_report	  	number		  		default 0,
	is_notice   		number(1)		  	default 0 check(is_notice in (0, 1))
);


drop sequence board_comment_seq;
create sequence board_comment_seq;
drop table board_comment cascade constraints;
create table board_comment (
	num		  		  	number		  		primary key,
	member_id		  	varchar2(50)	  	references member(id) on delete cascade,
	board_num		  	number	  			references board(num) on delete cascade,
	content	  			varchar2(3000)  	not null,
	comment_date		date			  	default sysdate,
	comment_like		number		  		default 0,
	comment_report	  	number		  		default 0
);


drop sequence board_reply_seq;
create sequence board_reply_seq;
drop table board_reply cascade constraints;
create table board_reply (
	num		  		  	number		  		primary key,
	member_id		  	varchar2(50)	  	references member(id) on delete cascade,
	comment_num		  	number	  			references board_comment(num) on delete cascade,
	content	  			varchar2(3000)  	not null,
	reply_date			date			  	default sysdate,
	reply_like			number		  		default 0,
	reply_report	  	number		  		default 0
);

drop table board_like;
create table board_like (
	member_id		varchar2(50)	references member(id) on delete cascade,
	num				number			not null,
	table_name		varchar2(20)	not null
);

select * from board;
select * from board_comment;
select * from board_reply;
select * from board_like;
