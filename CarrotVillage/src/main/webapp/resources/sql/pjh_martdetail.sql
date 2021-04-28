drop table sub cascade constraints;

create table sub(
item_num number not null,
main_category varchar2(50) not null,
sub_category varchar2(50) references martlist(martname) on delete cascade,
mart_subject varchar2(50) not null,
mart_name varchar2(50) not null,
mart_addr varchar2(100) not null,
mart_ori varchar2(50) not null,
mart_del varchar2(50) not null,
mart_deliverycost number not null,
item_name1 varchar2(50) not null,
item_price1 varchar2(20) not null,
item_name2 varchar2(50) ,
item_price2 varchar2(20) ,
item_name3 varchar2(50) ,
item_price3 varchar2(20) ,
item_name4 varchar2(50),
item_price4 varchar2(20),
item_name5 varchar2(50),
item_price5 varchar2(20),
item_name6 varchar2(50),
item_price6 varchar2(20),
mart_prod varchar2(20)  not null,
item_name varchar2(50) not null,
item_origin varchar2(50) not null,
item_exp varchar2(50) not null,
item_storage varchar2(50) not null,
board_content varchar2(2000) ,
board_thumbnail varchar2(100)not null,
board_thumbnail_ori varchar2(100)not null,
upfile1 varchar2(100) not null,
upfile1_ori varchar2(100) not null,
upfile2 varchar2(100) not null,
upfile2_ori varchar2(100) not null,
upfile3 varchar2(100),
upfile3_ori varchar2(100),
upfile4 varchar2(100),
upfile4_ori varchar2(100),
board_date	DATE default sysdate
);


create sequence sub_seq;

select * from sub;


select * from sub where sub_category='가락시장'