


-- EMPLOYEE 테이블에서
-- 사번, 이름, 성별, 급여, 직급명, 부서명을 조회
-- 단, 입력 받은 조건에 맞는 결과만 조회하고 정렬할 것
-- - 조건 1 : 성별 (M, F)
-- - 조건 2 : 급여 범위
-- - 조건 3 : 급여 오름차순/내림차순

SELECT 
		EMP_ID 사번,
		EMP_NAME 이름,
		DECODE(SUBSTR(EMP_NO,8,1), '1', 'M', '2', 'F') 성별,
		SALARY 급여,
		JOB_NAME 직급명,
		DEPT_TITLE 부서명
FROM EMPLOYEE
NATURAL JOIN JOB
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE 
		DECODE(SUBSTR(EMP_NO,8,1), '1', 'M', '2', 'F')
ORDER BY SALARY ASC;






/* 조회받은 값
 * 1. 성별 M/F
 * 2. 급여 범위 3000000 4000000
 * 3. 급여 정렬 1/2 
 *  (1.ASC / 2.DESE)
 * 
 * 문자 -> 숫자 / 숫자 -> 숫자쪼개기? / 숫자 -> 문자
 * */

SELECT
		EMP_ID 사번,
		EMP_NAME 이름,
		SALARY 급여,
		DECODE(SUBSTR(EMP_NO,8,1), '1', 'M', '2', 'F') 성별,
		JOB_NAME 직급명,
		DEPT_TITLE 부서명
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE
		DECODE(SUBSTR(EMP_NO,8,1), '1', 'M', '2', 'F') = ?
		AND
		SALARY BETWEEN ? AND ?
ORDER BY SALARY ?;



SELECT *
FROM TB_TODO;



