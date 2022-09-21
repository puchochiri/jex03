CREATE USER book_ex IDENTIFIED by book_ex
Default Tablespace users
temporary tablespace temp;

grant connect, dba to book_ex;

create sequence seq_board;

create table tbl_board(
    bno     number(10,0),
    title   varchar2(200) not  null,
    content varchar2(2000) not null,
    writer  varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

alter table tbl_board add constraint pk_board primary key (bno);



//1. sql 실행 계획 볼때 : 안쪽에서 바깥쪽으로 위에서 아래로

select * from tbl_board order by bno + 1 desc;

//2. 더미 데이터 생성
insert into tbl_board (bno, title, content, writer)
(select seq_board.nextval, title, content, writer from tbl_board);

select * from tbl_board order by bno asc;

3. sort없이 Index 검색
select 
    /*+ INDEX_DESC(tbl_board pk_board) */
    *
from
    tbl_board
where bno > 0;

// 4. Sort 사용하지 않기, PK 바로 접근하기, RANGE SCAN DESCENDING, BY INDEX ROWID 로 접근
// PK는 식별자, 인덱스 의미 가짐


create table tbl_reply (

    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate

);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key(rno);

alter table tbl_reply add constraint fk_reply_board
foreign key (bno) references tbl_board (bno);


// 인덱스 생성
create index idx_reply on tbl_reply (bno desc, rno asc);

select /*+INDEX(tbl_reply idx_reply)*/
    rownum rn, bno, rno, reply, replyer, replyDate, updatedate
    from tbl_reply
    where bno = 4
    and rno>0

select rno, bno, reply, replyer, replydate, updatedate
from
    (
        select /*+INDEX(tbl_reply idx_reply) */
            rownum rn, bno, rno, reply, replyer, replyDate, updatedate
        from tbl_reply
        where   bno = 4
                and rno > 0
                and rownum <= 20
                    
    ) where rn > 10    
    
    
