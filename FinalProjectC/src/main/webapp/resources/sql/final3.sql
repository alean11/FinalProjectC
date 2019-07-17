---------- *** Final DB *** -------------
/* DB 작성할 때 '날짜.이름.작성내용' 적을 것*/

show user;



--------일반회원테이블  : personal_mbr ------------------
create table personal_mbr
    (idx number not null
    ,p_userid varchar2(20)  not null
    ,p_pwd varchar2(300)    not null
    ,p_name varchar2(40)    not null
    ,p_email varchar2(300)  not null
    ,p_birthday varchar2(8) 
    ,p_gender number(1)     not null
    ,p_hp1 varchar2(3)      not null
    ,p_hp2 varchar2(100)    not null
    ,p_hp3 varchar2(100)    not null
    ,p_post1 varchar2(30)   not null
    ,p_post2 varchar2(30)   not null
    ,p_addr1 varchar2(90)   not null
    ,p_addr2 varchar2(90)   not null
    ,p_registerday date default sysdate
    ,p_lastlogin date
    ,p_lastpwdchg date default sysdate
    ,p_status number(1) default 1
,constraint PK_personal_mbr primary key(p_userid)
,constraint CK_personal_mbr_gender check(p_gender in(1,2))
);


--------일반회원 시퀀스
create sequence seq_personal_mbr
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;




-----------------------------------------------------------------------------
--------좋아요 테이블 : like_tbl
create table like_tbl
(acc_idx number
,p_userid varchar2(20)  not null
,status number(1) DEFAULT 0
,constraint FK_like_tbl_p_userid FOREIGN key(p_userid) references personal_mbr(p_userid)
,constraint FK_like_tbl_acc_idx FOREIGN key(acc_idx) references acc_tbl(acc_idx)
);



-------------------------------------------------------------------------------
--------댓글테이블 :comment_tbl
create table comment_tbl
(acc_idx number not null
,p_userid varchar2(20)  not null
,comments CLOB
,status number(1) DEFAULT 1
,com_writedate date default sysdate
,constraint FK_comment_tbl_p_userid FOREIGN key(p_userid) references personal_mbr(p_userid)
,constraint FK_comment_tbl_acc_idx FOREIGN key(acc_idx) references acc_tbl(acc_idx)
);



--------------------------------------------------------
--------QNA 테이블 : qna_tbl
create table qna_tbl
(qna_idx number         not null
,p_userid varchar2(20)
,q_title varchar2(40)   not null
,q_context CLOB         not null
,q_writeday date default sysdate
,q_writer varchar2(40)  not null
,q_viewcnt number(6)    not null
,q_pwd number(4)        not null
,status number(1)   default 1
,constraint FK_qna_tbl_p_userid FOREIGN key(p_userid) references personal_mbr(p_userid)
);

--------QNA 시퀀스
create sequence seq_qna_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;



-------------------------------------------------
----기업회원테이블  :  company_mbr
create table company_mbr
(idx number
,cp_id varchar2(20) 
,cp_pwd varchar2(300)   not null
,cp_num1 varchar2(3)    not null
,cp_num2 varchar2(2)    not null
,cp_num3 varchar2(5)    not null
,cp_name varchar2(60)   not null
,ceoname varchar2(40)   not null
,cp_email varchar2(300) not null
,cp_tel1 varchar2(3)    not null
,cp_tel2 varchar2(4)    not null
,cp_tel3 varchar2(4)    not null
,status number(1) DEFAULT 1
,constraint PK_company_mbr_cp_id primary key(cp_id)
);

--------기업회원 테이블 시퀀스
create sequence seq_company_mbr
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;



--------------------------------------------------------
----업체 회원테이블  :  acc_tbl
create table acc_tbl
(acc_idx number
,cp_id varchar2(20)     not null
,state number(2)     not null
,acc_name varchar2(60)  not null
,acc_tel1 varchar2(3)   not null
,acc_tel2 varchar2(4)   not null
,acc_tel3 varchar2(4)   not null
,acc_post1 varchar2(3)  not null
,acc_post2 varchar2(3)  not null
,acc_addr1 varchar2(90) not null
,acc_addr2 varchar2(90) not null
,acc_img varchar2(100)  not null
,acc_text CLOB          not null
,acc_Rcnt number(3)     not null
,acc_status number(1)   DEFAULT 1
,acc_type varchar2(10) not null    -- 호텔/리조트    
,acc_grade number(1) not null      -- 1,2,3,4,5
,constraint PK_company_mbr_acc_idx primary key(acc_idx)
,constraint FK_comment_tbl_cp_id FOREIGN key(cp_id) references company_mbr(cp_id)
,constraint FK_comment_tbl_state FOREIGN key(state) references area_tbl(region_code)
);
    
--------업체 시퀀스
create sequence seq_acc_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;




-----------------------------------------------
----------공지사항테이블----------------------
create table notice
(n_idx number
,n_title varchar2(20)   not null
,n_context CLOB         not null
,n_writeday date   DEFAULT sysdate
,n_viewcnt number(6)    not null
,status number(1)   DEFAULT 1
,constraint PK_notice_idx primary key(n_idx)
);

--------공지사항 시퀀스
create sequence seq_notice
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;



------------------------------------------------------------------
-----장바구니 테이블 :cart_tbl
create table cart_tbl
(cartno number
,p_userid varchar2(20)  not null
,p_name     varchar2(40) not null
,r_idx number(4)    not null
,cart_price varchar2(7)     not null
,cart_cnt number(5)     not null
,startDate  varchar2(20)     not null
,endDate    varchar2(20)     not null
,constraint PK_cart_tbl_cartno primary key(cartno)
,constraint FK_room_tbl_r_idx foreign key(r_idx) references room_tbl(r_idx)
,constraint FK_personal_mbr_p_userid foreign key(p_userid) references personal_mbr(p_userid)
);

--------장바구니 시퀀스
create sequence seq_cart_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;


------------------------------------------------
---------객실테이블 : room_tbl
create table room_tbl
(r_idx number
,acc_idx number         not null
,r_kind varchar2(40)    not null
,r_text CLOB            not null
,r_cnt number(2)        not null
,ay_fee number(8)       not null
,k_fee number(8)        not null
,constraint PK_room_tbl_r_idx primary key(r_idx)
,constraint FK_acc_tbl_acc_idx foreign key(acc_idx) references acc_tbl(acc_idx)
);

--------객실테이블 시퀀스
create sequence seq_room_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;



---------------------------------------------------------------
-- 예약여부확인 테이블 : booking_ck
create table booking_ck
(r_idx number       not null
,book_start date    not null
,book_end date      not null
,constraint FK_booking_ck_r_idx foreign key(r_idx) references room_tbl(r_idx)
);



-----------------------------------------------
-- 브라메니티 테이블  : barmenity
create table barmenity
(r_idx number   not null
,bm_br_addfee varchar2(6)     DEFAULT 'none'
,bm_amenity varchar2(300)   DEFAULT 'none'
,bm_device varchar2(300)    DEFAULT 'none'
,constraint FK_barmenity_r_idx foreign key(r_idx) references room_tbl(r_idx)
);



---------------------------------------------
-- 추가이미지 테이블 : addtional_img
create table addtional_img
(r_idx number   not null
,ad_img1 varchar2(100)
,ad_img2 varchar2(100)
,ad_img3 varchar2(100)
,ad_img4 varchar2(100)
,ad_img5 varchar2(100)
,constraint FK_addtional_img_r_idx foreign key(r_idx) references room_tbl(r_idx)
);

---------------------------------------
-- 태그테이블
create table acc_tag
(acc_idx		number  not null
,acc_name	varchar2(60)    not null
,cnt		number          DEFAULT 0
,constraint FK_acc_tag_acc_idx foreign key(acc_idx) references acc_tbl(acc_idx)
);


--------------------------------------------
-- 지역 테이블
create table area_tbl
(
region_code number(2)   not null
,region_name varchar2(20)   not null
,region_shortName varchar2(10) not null    
,constraint PK_area_tbl_region_code primary key(region_code)
);
commit;



