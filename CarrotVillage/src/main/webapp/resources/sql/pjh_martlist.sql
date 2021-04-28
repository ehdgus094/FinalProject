drop table martlist

create table martlist(
num		number,
martname	varchar2(30) primary key,
martloc		varchar2(80) not null,
mart_delloc	varchar2(150) not null,
mart_deltime	varchar2(150) not null,
mart_delpri	number not null
)



drop sequence martlist_seq;
create sequence martlist_seq;

insert into martlist
values(martlist_seq.nextval,'가락시장'
,'서울 송파구 양재대로 932','하남시,강동구,노원구,중랑구,동대문수'
,'오후 1시까지 주문시 당일 오후7시까지 배달(휴일배달불가)'
,4000);




truncate table martlist;

select * from MARTLIST;

delete from martlist where martname='가락시장'

select martname from MARTLIST where mart_delloc like '%양천구%' and martloc like'%서울%';

