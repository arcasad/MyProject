
/* Drop Tables */

DROP TABLE job_board CASCADE CONSTRAINTS;
DROP TABLE job_member CASCADE CONSTRAINTS;

DROP SEQUENCE job_board;
DROP SEQUENCE job_reserve;

CREATE SEQUENCE job_board;
CREATE SEQUENCE job_reserve;

/* Create Tables */

CREATE TABLE job_board
(
	no number NOT NULL,
	title varchar2(100) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	readcount number DEFAULT 0 NOT NULL,
	content varchar2(4000) NOT NULL,
	user_id varchar2(40) NOT NULL,
	PRIMARY KEY (no)
);


CREATE TABLE job_member
(
	user_id varchar2(20) NOT NULL,
	user_pw varchar2(128) NOT NULL,
	user_phone varchar2(20) NOT NULL,
	user_name varchar2(20) NOT NULL,
	PRIMARY KEY (user_id)
);

CREATE TABLE job_reserve
(
   user_id varchar2(20) NOT NULL,
   user_name varchar2(20) NOT NULL,
   user_phone varchar2(20) NOT NULL,
   re_year number NOT NULL,
   re_month number NOT NULL,
   re_day number NOT NULL,
   re_room number NOT NULL,
   PRIMARY KEY (user_id)
);

select * from JOB_RESERVE;
select * from job_board;
select * from job_member;

ALTER table job_board
add(user_id varchar2(20));

DELETE FROM JOB_board;
DELETE FROM JOB_RESERVE;

select *
FROM job_reserve
WHERE user_id='admin' OR user_id='1111'
ORDER BY re_date;

select no, user_id, user_name, user_phone, re_year, re_month, re_day, re_year||DECODE(length(re_month),1,'0'||re_month,re_month)||DECODE(length(re_day),1,'0'||re_day,re_day) as re_date, re_room, re_cost
FROM job_reserve
WHERE user_id='admin' OR (user_id='1111' AND user_name='test')
ORDER BY re_date;
