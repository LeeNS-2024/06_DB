





SELECT 
	AREA_NAME 지역명, 
	MEMBER_ID 아이디, 
	MEMBER_NAME 이름, 
	GRADE_NAME 등급명
FROM TB_MEMBER
JOIN TB_GRADE ON(GRADE = GRADE_CODE)
JOIN TB_AREA USING(AREA_CODE)
WHERE 
	AREA_CODE = (
	SELECT AREA_CODE 
	FROM TB_MEMBER
	WHERE MEMBER_NAME = '김영희')
ORDER BY 이름 ASC;


-- 김영희 회원은 031 AREA_CODE를 가지고 있다
-- 같은 지역으로는 심사임당 박철수가 존재. 즉, 2행이 출력되어야한다.
-- 김영희가 출력값에 보여야 되나 말아야되나.....
-- 안 보여야될듯 

SELECT 
	AREA_NAME 지역명, 
	MEMBER_ID 아이디, 
	MEMBER_NAME 이름, 
	GRADE_NAME 등급명
FROM TB_MEMBER
JOIN TB_GRADE ON(GRADE = GRADE_CODE)
JOIN TB_AREA ON(TB_MEMBER.AREA_CODE = TB_AREA.AREA_CODE)
WHERE 
	TB_AREA.AREA_CODE = (
	SELECT AREA_CODE 
	FROM TB_MEMBER
	WHERE MEMBER_NAME = '김영희')
	AND
	MEMBER_NAME != '김영희'
ORDER BY 이름 ASC;




/*

원인

1. WHERE 안에 서브쿼리인 WHERE구문에서 별칭을 사용하였는데
SQL의 해석순서에 따르면 WHERE는 SELECT보다 해석순서가 느리므로 아직 '이름'이라는 별칭이 선언되지 않았다.

2. 두 번쨰 JOIN에서 TB_AREA와 TB_MEMBER의 내부에 있는 AREA_CODE의 이름이 같아서 오류가 뜬다.

3. 요구사항은 SELECT 값들을 '이름' 오름차순으로 조회하길 바라는데 ( ORDER BY 이름 DESC ) 를 사용해서 이름 내림차순으로 조회하고 있다 





조치내용
1. WHERE의 서브쿼리안에 ( WHERE 이름 = '김영희' ) =>  ( WHERE MEMBER_NAME = '김영희' ) 로 바꾸어주었다.

2. 두 번째 JOIN을  { JOIN TB_AREA ON(AREA_CODE = AREA_CODE) } => { JOIN TB_AREA USING(AREA_CODE) } 로 바꾸어주었다

3. ( ORDER BY 이름 DESC ) => ( ORDER BY 이름 ASC )로 바꾸어서 이름 오름차순으로 조회할 수 있게 해주었다.

*/