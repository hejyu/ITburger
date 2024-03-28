/**
 * 테이블 생성 		   03.13
 * BG_BUY 타이틀 컬럼 추가 03.15
 * BG_NOTICE 테이블 반영  03.15
 * BG_ERVENT 테이블 반영  03.18
 * BG_EVENT 좋아요 컬럼 추가 03.19
 * LIKEUSER 테이블 추가 	03.20
 * BG_CATEGORY 테이블 추가  03.22
 */


-- 테이블 삭제
DROP TABLE LIKEUSER;
DROP TABLE BG_CATEGORY;
DROP TABLE BG_BUYS;
DROP TABLE BG_MENU_OPTION;
DROP TABLE BG_MENU;
DROP TABLE BG_EVENT;
DROP TABLE BG_USER;


-- 시퀀스 삭제
DROP SEQUENCE BG_BUYS_SEQ;
DROP SEQUENCE BG_EVENT_SEQ;
DROP SEQUENCE BG_MENU_OPTION_SEQ;
DROP SEQUENCE BG_MENU;

-- 데이터 삭제
TRUNCATE TABLE LIKEUSER;
TRUNCATE TABLE BG_CATEGORY;
TRUNCATE TABLE BG_BUYS;
TRUNCATE TABLE BG_EVENT;
TRUNCATE TABLE BG_MENU_OPTION;
TRUNCATE TABLE BG_MENU;
TRUNCATE TABLE BG_USER;

-- 햄버거 메인 테이블
CREATE TABLE BG_MENU(
   menu_code VARCHAR2(100) PRIMARY KEY,	-- 메뉴코드 
   menu_name VARCHAR2(100) NOT NULL,
   menu_desc VARCHAR2(500) ,	-- 메뉴 설명
   price NUMBER(7) NOT NULL,
   create_dttm TIMESTAMP,		-- 생성일시
   img_name VARCHAR2(100)		-- 이미지파일명
);



ALTER SESSION SET nls_timestamp_format='YYYY-MM-DD HH24:MI:SS';


SELECT  * FROM BG_MENU WHERE menu_code IN('BURGER10');

--DELETE FROM BG_MENU_OPTION bmo WHERE menu_code IN('BURGER10');
--DELETE FROM BG_MENU bm WHERE menu_code = 'BURGER12';
--DELETE FROM BG_MENU bm WHERE menu_code = 'BGS0001';

-- 햄버거 옵션 테이블
CREATE TABLE BG_MENU_OPTION(
   option_seq NUMBER(8) PRIMARY KEY,
   option_name VARCHAR2(100) NOT NULL,
   option_price NUMBER(7) NOT NULL,
   option_desc VARCHAR2(500),		-- 메뉴 옵션 설명
   create_dttm TIMESTAMP NOT NULL,	-- 생성일시
   menu_code VARCHAR2(100) NOT NULL,
   FOREIGN KEY (menu_code)				
			REFERENCES BG_MENU(menu_code)
);
-- 시퀀스 생성
CREATE SEQUENCE BG_MENU_OPTION_SEQ;

SELECT  * FROM BG_MENU_OPTION WHERE menu_code IN('BURGER10');

-- DELETE FROM BG_MENU_OPTION WHERE OPTION_seq = 9;

-- 유저 테이블
CREATE TABLE BG_USER(
   user_id VARCHAR2(50) PRIMARY KEY,
   user_password VARCHAR2(500) NOT NULL,
   user_name VARCHAR2(100),
   create_dttm TIMESTAMP
);

SELECT  * FROM BG_USER;


INSERT INTO BG_USER 
VALUES ('test03', '이벤트 리뷰 테스트', '테스트테스트테스트테스트', '2024-03-12 10:41:49', 'eventreview.png','admin');



-- 햄버거 구매관리 테이블
CREATE TABLE BG_BUYS(
   buy_seq NUMBER(8) PRIMARY KEY,
   menu_code VARCHAR2(100) NOT NULL,			-- 메뉴코드 ex) BGS1234
   order_id VARCHAR2(500) NOT NULL,		-- 매뉴코드7자리_주문일시 ex) BGS1234_20240312111321 
   detail_option_seq VARCHAR2(1000), 	-- 구매한 메뉴옵션 pk , 콤마로 연결 ex)7,8
   detail_option_desc VARCHAR2(1000), 	-- 구매한 메뉴옵션 설명 ex)한라봉패션후르츠에이드 `수량`개,콜라 `수량`개
   amount 	NUMBER(8) NOT NULL,			-- 총 결제금액 = 메뉴가격 + 메뉴옵션가격합계 ex ) 5000+ (2500*1 + 2000*2)
   user_id	VARCHAR2(50)  NOT NULL,		-- 구매자 아이디
   pay_type VARCHAR2(100) NOT NULL, 	-- 결제수단	
   payment_key VARCHAR2(500) NOT NULL, 	
   create_dttm  TIMESTAMP NOT NULL,
   buy_title VARCHAR(100) DEFAULT '테스트' NOT NULL,
   FOREIGN KEY (menu_code)				
			REFERENCES BG_MENU(menu_code),
   FOREIGN KEY (user_id)				
			REFERENCES BG_USER(user_id)				
);
-- 시퀀스 생성
CREATE SEQUENCE BG_BUYS_SEQ;



-------------------------------------------------------------------

-- 공지사항
CREATE TABLE BG_NOTICE(
   notice_seq NUMBER(8) PRIMARY KEY,
   notice_title varchar2(100) NOT NULL,
   notice_content varchar2(3000) NOT NULL,
   notice_readcount number(10) DEFAULT 0,
   notice_date TIMESTAMP NOT NULL,
   notice_image varchar2(200)
);

CREATE SEQUENCE BG_NOTICE_SEQ;

UPDATE BG_NOTICE
SET notice_date = CURRENT_TIMESTAMP
WHERE notice_date IS NULL;


ALTER SESSION SET nls_timestamp_format='YYYY-MM-DD HH24:MI:SS';



INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 신메뉴 론칭 이벤트',
'노브랜드 버거에서 신메뉴 론칭 이벤트를 진행합니다! 오는 5월 1일부터 5월 15일까지 매장을 방문하시면 새로운 메뉴를 특별한 할인가로 즐기실 수 있습니다. 기간 한정의 이벤트를 놓치지 마세요!'
,0,'2024-04-25 10:00:00','8.png');

INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 사회적 거리두기 단계 조정에 따른 안내',
'노브랜드 버거는 정부의 사회적 거리두기 단계 조정에 따라 매장 내 식사가 가능한 단계로 변경되었습니다. 이에 매장 내 식사가 가능하니 이용에 참고하시기 바랍니다. 더불어 마스크 착용 및 손 소독 등 방역수칙을 준수해주시기 바랍니다.'
,0,'2024-04-10 15:20:00','9.png');

INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 배달 서비스 확대',
'노브랜드 버거가 배달 서비스를 확대합니다! 이제 더 많은 지역에서 노브랜드 버거의 맛을 즐기실 수 있습니다. 편리한 배달 서비스를 이용해보세요!'
,0,'2024-03-28 11:45:00','10.png');

INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 고객 감사 이벤트',
'고객 여러분께 감사의 마음을 전하며 이벤트를 준비했습니다! 오는 7월 1일부터 7월 15일까지 매장 방문 시 특정 상품을 구매하시면 추첨을 통해 푸짐한 상품을 드립니다. 많은 관심 부탁드립니다!'
,0,'2024-06-25 09:00:00','11.png');

INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 여름 시즌 한정 메뉴 출시',
'노브랜드 버거가 여름 시즌을 맞아 특별한 한정 메뉴를 출시합니다! 시원한 맛과 함께 여름을 느낄 수 있는 메뉴들로 구성되어 있으니 기대해주세요!'
,0,'2024-07-05 14:30:00','12.png');

INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 프리미엄 메뉴 업그레이드',
'노브랜드 버거의 프리미엄 메뉴가 업그레이드되었습니다! 더욱 고소하고 풍성한 맛으로 새롭게 선보입니다. 매장에서 만나보세요!'
,0,'2024-02-05 13:00:00','13.png');

INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 새로운 지점 오픈',
'노브랜드 버거가 새로운 매장을 오픈합니다! 새로운 매장에서는 다양한 이벤트와 함께 더욱 특별한 경험을 제공할 예정입니다. 많은 관심 부탁드립니다!'
,0,'2024-08-15 10:10:00','14.png');

INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 가을 맞이 이벤트',
'가을이 다가오면서 노브랜드 버거에서는 특별한 이벤트를 준비했습니다! 오는 9월 10일부터 9월 30일까지 매장을 방문하시면 가을 분위기가 물씬 풍기는 메뉴를 특별 가격으로 즐기실 수 있습니다.'
,0,'2024-09-01 11:20:00','15.png');

INSERT INTO BG_NOTICE 
VALUES (BG_NOTICE_SEQ.nextval,
'노브랜드 버거, 겨울 시즌 특별 이벤트',
'겨울이 다가오면 노브랜드 버거에서는 특별한 겨울 시즌 이벤트를 진행합니다! 매장 방문 시 따뜻한 음료와 함께 푸짐한 혜택을 누리세요!'
,0,'2024-11-20 09:30:00','16.png');

SELECT * FROM BG_NOTICE;


-------------------------------------------------------------

-- 이벤트
CREATE TABLE BG_EVENT(
   event_seq NUMBER(8) PRIMARY KEY,
   event_title varchar2(100) NOT NULL,
   event_content varchar2(3000) NOT NULL,
   event_regdate TIMESTAMP NOT NULL,
   event_image varchar2(200),
   user_id VARCHAR2(50),
   FOREIGN KEY (user_id)            
         REFERENCES BG_USER(user_id)
);

CREATE SEQUENCE BG_EVENT_SEQ;

INSERT INTO BG_EVENT 
VALUES (BG_EVENT_SEQ.nextval, '이벤트 리뷰 테스트', '테스트테스트테스트테스트', '2024-03-12 10:41:49', 'eventreview.png','admin');

-- 이벤트 좋아요 컬럼 추가
ALTER TABLE BG_EVENT ADD like_count number(8);



SELECT * FROM BG_EVENT;

-------------------------------------------------------------

-- 이벤트 좋아요 유저 테이블
CREATE TABLE LIKEUSER (
   eventid number(8) NOT NULL,
   user_id varchar2(50) NOT NULL
);

-- 쿠폰 테이블
--CREATE TABLE BG_COUPON(
--   COUPON_CODE VARCHAR2(100) PRIMARY KEY,
--   COUPON_NAME VARCHAR2(100) NOT NULL,
--   COUPON_PRICE NUMBER(8)    NOT NULL,
--   IS_USE   CHAR(1)  DEFAULT 'Y' NOT NULL,
--   CREATE_DTTM TIMESTAMP NOT NULL,
--   USER_ID VARCHAR2(50) NULL,
--   FOREIGN KEY (USER_ID)
--         REFERENCES BG_USER(USER_ID)
--);
--
--
--
--INSERT INTO BG_COUPON (COUPON_CODE, COUPON_NAME, COUPON_PRICE, IS_USE, CREATE_DTTM) 
--VALUES ('couponcode0001', '[웰컴쿠폰]2000원할인',  2000, 'Y', '2024-03-11 10:41:49');
--

----------------------------------------------------

-- 메뉴 카테고리 테이블
CREATE TABLE BG_CATEGORY(
    CODE VARCHAR2(20) PRIMARY KEY ,
    NAME VARCHAR2(40) NOT NULL
);


INSERT INTO BG_CATEGORY (CODE, NAME) 
VALUES ('NEW', 'New');

INSERT INTO BG_CATEGORY (CODE, NAME) 
VALUES ('BURGER', 'Burger');

INSERT INTO BG_CATEGORY (CODE, NAME) 
VALUES ('DRINK', 'Beverage');

INSERT INTO BG_CATEGORY (CODE, NAME) 
VALUES ('SIDE', 'Side');


-- 메뉴 테이블 카테고리 컬럼 추가
ALTER TABLE BG_MENU ADD CATEGORY_CODE VARCHAR2(20);


SELECT * FROM BG_MENU ;



-- 테이블 확인
SELECT * FROM BG_CATEGORY ;


-- 메뉴 카테고리 업데이트


UPDATE BG_MENU A
SET   A.CATEGORY_CODE  = 'NEW'
WHERE A.MENU_NAME LIKE 'IT 오리지널 버거%';

UPDATE BG_MENU A
SET   A.CATEGORY_CODE  = 'NEW'
WHERE A.MENU_NAME LIKE '쓰리랑카치킨 버거%';

UPDATE BG_MENU A
SET	A.CATEGORY_CODE  = 'BURGER'
WHERE A.MENU_CODE LIKE 'BURGER%';

UPDATE BG_MENU A
SET	A.CATEGORY_CODE  = 'DRINK'
WHERE A.MENU_CODE LIKE 'DRINK%';

UPDATE BG_MENU A
SET	A.CATEGORY_CODE  = 'SIDE'
WHERE A.MENU_CODE LIKE 'SIDE%';


-- 업데이트 확인
SELECT * FROM BG_MENU;

COMMIT;





















