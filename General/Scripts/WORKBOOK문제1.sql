--                                          SQL01_SELECT(BASIC)


-- 1번
SELECT 
	DEPARTMENT_NAME "학과 명",
	CATEGORY 계열
FROM 
	TB_DEPARTMENT;
	

-- 2번 -- 오답노트
SELECT 
	DEPARTMENT_NAME || '의 정원은 ' || CAPACITY  || '명 입니다.' "학과별 정원"
FROM TB_DEPARTMENT; -- || 로 출력값에 글자를 넣을 수 있네


-- 3번	"국어국문학과"에 다니는 여학생 중 현재 휴학중인 여학생을 조회하시오.
-- (국문학과의 학과코드 DEPARTMENT_NO 는 001)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 001
AND SUBSTR(STUDENT_SSN,8,1) = '2'
AND ABSENCE_YN = 'Y';


-- 4번
-- 도서관에서 대출 도서 장기 연체자들을 찾아 이름을 게시하려고 함
-- 학번으로 이름 찾기
-- A513079, A513091, A513090, A513110, A513119
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079',
										'A513091', 
										'A513110', 
										'A513119',
										'A513090');

										
										
-- 5번
-- 입학 정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열 조회
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <= 30;



-- 6번
-- 총장을 제외한 모든 교수들이 소속학과를 가짐
-- 이때 총장의 이름을 알아낼 수 있는 문장 작성
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;
									

-- 7번
-- 수강신청 하려고 함.
-- 선수과목 여부를 확인해야 하는데
-- 선수과목이 존재하는 과목은 어떤 과목인지 과목 번호 조회
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;


										
-- 8번 -- 오답노트
-- 춘대학에는 어떤 계열들이 있는지 조회
SELECT CATEGORY
FROM TB_DEPARTMENT
GROUP BY CATEGORY; -- GROUP BY는 중복 X !!!!


-- 9번
-- 02학번 전주 거주자들의 모임 만드려 함.
-- 휴학한 사람 제외하고 재학중인 학생들의
-- 학번, 이름, 주민번호를 조회
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N'
AND SUBSTR(STUDENT_ADDRESS, 1, 2) = '전주';
										
										
										
--                                             SELECT(FUNCTION)								

-- 1번
-- 영어영문학과(학과코드 002) 학생들의 학번, 이름, 입학 년도를
-- 입학 년도가 빠른 순으로 정렬하여 조회
-- 단, 헤더는 "학번", "이름", "입학년도"로 표시
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE ASC;


-- 2번 -- 오답노트
-- 교수 중 이름이 세 글자가 아닌 교수 두 명의
-- 이름과 주민번호를 조회
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___'; -- NOT LIKE!!!
										

-- 3번 -- 오답노트
-- 남자 교수들의 이름과 나이를 나이 오름차순으로 조회
-- 단, 교수 중 00년생 이후 출생자 X, 출력 헤더는 교수이름으로 하고, 나이는 '만'으로 계산					
SELECT PROFESSOR_NAME 교수이름,
   FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6),'RRMMDD')) /12) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 나이;
										
										
-- 4번  -- ING
-- 교수들의 이름 중 성을 제외한 이름만 조회. 출력헤더는 "이름"이 나오도록한다
-- (성 2자인 교수는 없다고 가정)
SELECT PROFESSOR_NAME 이름									
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_NAME, 2, 2);
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										

