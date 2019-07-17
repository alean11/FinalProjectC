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


-------------- 2019.07.17. 정혜윤: 지역코드 추가
/* 지역코드
서울: 1
경기: 2
강원: 3
충북: 4
충남: 5
경북: 6
경남: 7
전북: 8
전남: 9
제주: 10
*/
insert into area_tbl(region_code, region_name, region_shortName)
values(1, '서울', '서울');
insert into area_tbl(region_code, region_name, region_shortName)
values(2, '경기도', '경기');
insert into area_tbl(region_code, region_name, region_shortName)
values(3, '강원도', '강원');
insert into area_tbl(region_code, region_name, region_shortName)
values(4, '충청북도', '충북');
insert into area_tbl(region_code, region_name, region_shortName)
values(5, '충청남도', '충남');
insert into area_tbl(region_code, region_name, region_shortName)
values(6, '경상북도', '경북');
insert into area_tbl(region_code, region_name, region_shortName)
values(7, '경상남도', '경남');
insert into area_tbl(region_code, region_name, region_shortName)
values(8, '전라북도', '전북');
insert into area_tbl(region_code, region_name, region_shortName)
values(9, '전라남도', '전남');
insert into area_tbl(region_code, region_name, region_shortName)
values(10, '제주도', '제주');

commit;



-------------- 2019.07.17. 정혜윤: 호텔 추가 (경상남도)

------------------------------------ 회사 및 호텔 정보 입력 시작 --------------------------------------------
/* 호텔 여러 개 있는 기업종류

라마다(ramada), 대명(daemyong), 앰배서더(ambassador), 금호(kumho), 한화(hanhwa),
켄싱턴(kensington), 힐튼(hilton), 코오롱(kolong), 신라(shinla), 롯데(lotte), 하얏트(hyatt),
메리어트(marriott), 한진=칼(hanjin)

*/

/*
select ascii('&') from dual;
select chr(38) from dual;

select ascii('a') from dual;
select chr(97) from dual;

select  '스탠포드 호텔'||chr(38)||'리조트 통영' from  dual;
select replace('스탠포드 호텔}리조트 통영','}',chr(38)) from dual;
insert into aaa(memo)  values(replace('스탠포드 호텔}리조트 통영','}',chr(38)));
*/

----------- >>>>>>>>>>>>>> 경상남도 <<<<<<<<<<<<<<<< --------------------------

-- 스탠포드 호텔&리조트 통영
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'stanford', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '스탠포드', '스탠포드', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'stanford', 7, '스탠포드 호텔 리조트 통영', '055', '725', '0000', '530', '79', '경상남도 통영시 도남동 도남로 347', '스탠포드 호텔 리조트 통영', '리조트 통영_HI569533145.jpg', '호텔 설명', '120', default, '호텔', 5);



-- 라마다 스위츠 거제
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'ramada', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '라마다', '스위츠', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ramada', 7, '라마다 스위츠 거제', '000', '0000', '0000', '533', '26', '경상남도 거제시 일운면 거제대로 2631', '소동리 라마다호텔', '라마다 거제_HI533294890.jpg',  '호텔설명',  '80', default, '리조트', 5);



-- 아난티 남해
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'ananti', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '아난티', '아난티', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ananti',  7,  '아난티 남해',  '000',  '0000',  '0000',  '524',  '33', '경상남도 남해군 남면 남서대로1179번길 40-109', '아난티남해골프장', '아난티 남해_HI549544950.jpg',  '호텔설명',  '220', default, '리조트', 4);



-- 아이스퀘어호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'isquare', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '아이스퀘어', '스퀘어', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'isquare',  7,  '아이스퀘어호텔',  '000',  '0000',  '0000',  '509',  '40', '경상남도 김해시 김해대로 2360', '부원동 아이스퀘어', '아이스퀘어_HI409061760.jpg',  '호텔설명',  '70', default, '호텔', 4);



-- 대명리조트 거제마리나
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'daemyong', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '대명', '대명씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'daemyong',  7,  '대명리조트 거제마리나',  '000',  '0000',  '0000',  '533',  '26', '경상남도 거제시 일운면 거제대로 2660', '소동리 대명리조트거제휴양콘도미니엄', '대명리조트 거제마리나_HI543279018.jpg',  '호텔설명',  '230', default, '리조트', 4);



-- 그랜드 머큐어 앰배서더 창원
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'ambassador', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '앰배서더', '앰배씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ambassador',  7,  '그랜드 머큐어 앰배서더 창원',  '000',  '0000',  '0000',  '514',  '08', '경상남도 창원시 의창구 원이대로 332', '대원동 더시티세븐풀만호텔', '그랜드 머큐어 앰배서더_HI552205106.jpg',  '호텔설명',  '70', default, '호텔', 5);



-- 금호 통영 마리나 리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'kumho', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '금호', '아시아나', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'kumho',  7,  '금호 통영 마리나 리조트',  '000',  '0000',  '0000',  '530',  '79', '경상남도 통영시 큰발개1길 33', '도남동 금호충무마리나콘도', '금호 통영_HI519521852.jpg',  '호텔설명',  '82', default, '리조트', 3);



-- 아르떼리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'arte', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '아르떼', '아르씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'arte',  7,  '아르떼리조트',  '000',  '0000',  '0000',  '525',  '54', '경상남도 사천시 해안관광로 109-10', '실안동 아르떼리조트', '아르떼리조트_HI400835701.jpg',  '호텔설명',  '90', default, '호텔', 3);



-- 한화리조트 거제 벨버디어
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'hanhwa', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '한화', 'ceo이름', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'hanhwa',  7,  '한화리조트 거제 벨버디어',  '000',  '0000',  '0000',  '532',  '00', '경상남도 거제시 장목면 거제북로 2501-40', '농소리 한화리조트거제벨버디어', '한화거제_HI549909636.jpg',  '호텔설명',  '110', default, '리조트', 5);



-- 프래밀리 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'frie', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '프래밀리', '프래씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'frie',  7,  '프래밀리 호텔',  '000',  '0000',  '0000',  '533',  '29', '경상남도 거제시 일운면 거제대로 2308', '와현리 프래밀리 호텔', '프래밀리_HI360877901.jpg',  '호텔설명',  '88', default, '호텔', 2);

commit;

------------- 


