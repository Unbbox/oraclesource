-- scott

-- SELECT(데이터 조회)
SELECT EMPNO, ENAME  FROM EMP ;

-- ctrl + shift + f로 쿼리문 정렬
SELECT
	empno,
	mgr,
	mgr,
	deptno
FROM
	emp;

SELECT DISTINCT deptno
FROM emp;

SELECT 
	empno AS 사원번호,
	mgr 매니저번호,
	deptno "부서 번호"
FROM
	emp;

SELECT
	empno AS 사워번호,
	ename AS 이름,
	sal AS 급여,
	(sal * 12)+comm AS 연봉
FROM
	emp
ORDER BY sal desc;

-- emp 테이블에서 empno, ename, sal 조회
-- 단, empno를 내림차순으로 정렬하여 조회
SELECT
	empno,
	ename,
	sal
FROM
	EMP
ORDER BY
	empno DESC;

-- 전체조회, 부서번호 오름차순, sal 내림차순
SELECT
	*
FROM
	EMP
ORDER BY
	empno,
	sal DESC;

-- 부서전호가 30번인 사원 조회
-- sal > 1000 이상인 사원 조회
SELECT
	*
FROM
	EMP
WHERE
	deptno = 30
	AND sal >= 1000
ORDER BY sal desc;

-- empno가 7782인 사람 조회
SELECT
	*
FROM
	EMP
WHERE
	empno = 7782;

-- deptno가 30이고, job이 saleman인 사원 조회
SELECT
	*
FROM
	EMP
WHERE
	deptno = 30
	AND job = 'SALESMAN';

-- 사원번호가 7499이고, 부서번호가 30인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	empno = 7499
	AND deptno = 30;

-- 부서번호가 30번 이거나 job이 SALESMAN인 사원 조회
SELECT
	*
FROM
	emp
WHERE
	deptno = 30
	OR job = 'SALESMAN';

-- 연봉이 36000인 사원 조회
-- 연봉 : SAL * 12 + COMM
SELECT
	*
FROM
	emp
WHERE
	SAL * 12 + COMM = 36000;

SELECT * FROM emp WHERE ename >= 'F';

-- sal이 3000이 아닌 사원 조회(!=, <>, ^= 전부 같은 의미)
SELECT
	*
FROM
	emp
WHERE
	SAL != 3000;
	
SELECT
	*
FROM
	emp
WHERE
	SAL <> 3000;

SELECT
	*
FROM
	emp
WHERE
	SAL ^= 3000;

-- job이 salesman이거나 manager이거나 clerk 인 사람 조회
SELECT
	*
FROM
	emp
WHERE
	job = 'SALESMAN'
	OR job = 'MANAGER'
	OR job = 'CLERK';

-- IN
SELECT
	*
FROM
	emp
WHERE
	job IN ('MANAGER', 'SALESMAN', 'CLERK');

-- NOT IN
SELECT
	*
FROM
	emp
WHERE
	job NOT IN ('MANAGER', 'SALESMAN', 'CLERK');
	
-- hiredate가 1981.10.31이후에 고용된 사원을 조회
SELECT * FROM emp e WHERE HIREDATE > '1981-10-31';

-- between a and b
-- sal이 2000이상 3000이하인 사원 조회
SELECT
	*
FROM
	emp
WHERE
	sal BETWEEN 2000 AND 3000;

-- not between a and b
SELECT
	*
FROM
	emp
WHERE
	sal NOT BETWEEN 2000 AND 3000;

-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)를 
-- 다음과 같은 조건을 기준으로 변환해서 CHG_MGR 열에 출력하시오.
-- CASE 사용
SELECT
	EMPNO,
	ENAME,
	MGR,
	CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '78' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM
	EMP e;

-- CASE 사용 간략화
SELECT
	EMPNO,
	ENAME,
	MGR,
	CASE SUBSTR(TO_CHAR(NVL(MGR, 0)), 1, 2)
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM
	EMP e;

-- DECODE 사용
SELECT
	EMPNO,
	ENAME,
	MGR,
	DECODE(SUBSTR(TO_CHAR(MGR), 1, 2), NULL, '0000', '75', '5555', '76', '6666', '77', '7777', '78', '8888', 
	SUBSTR(TO_CHAR(MGR), 1)) AS CHG_MGR
FROM
	EMP e; 

-- 다중행 함수
-- sum(), avg(), count(), max(), min()

-- 단일 그룹의 그룹 함수가 아닙니다.(여러 행이 나올 수 있는 컬럼을 추가한 경우)
SELECT
	SUM(sal), AVG(sal),	COUNT(sal),	MAX(sal), MIN(sal)
FROM
	EMP e; 

-- 동일한 급여를 하나만 선택해서 합계(중복 제외)
SELECT SUM(DISTINCT sal) FROM EMP e ;

SELECT COUNT(*) FROM EMP e;

-- 부서번호가 30인 사원의 수 출력
SELECT count(*) FROM EMP e WHERE DEPTNO = 30;

-- 부서번호가 30인 사원 중에서 급여의 최대값
SELECT MAX(sal) 
FROM EMP e 
WHERE DEPTNO = 30;

-- 부서번호가 20인 사원의 입사일 중에서 제일 최근 입사일 조회
SELECT MAX(HIREDATE)
FROM EMP e 
WHERE DEPTNO = 20;

-- 부서번호가 20인 사원의 입사일 중에서 제일 오래된 입사일 조회
SELECT MIN(HIREDATE)
FROM EMP e 
WHERE DEPTNO = 20;

-- 부서번호가 30인 사원 중에서 sal의 중복값을 제거한 후, 평균 출력
SELECT AVG(DISTINCT sal) 
FROM EMP e 
WHERE DEPTNO = 30;

-- 부서별 급여 합계 구하기
SELECT SUM(sal)
FROM EMP e
WHERE DEPTNO = 10
UNION
SELECT SUM(sal)
FROM EMP e 
WHERE DEPTNO = 20
UNION
SELECT SUM(sal)
FROM EMP e 
WHERE DEPTNO = 30;

-- 결과 값을 원하는 열로 묶기 : GROUP BY
-- select 작성 순서 : 셀프웨구해오(select, from, where, group by, having, order by)
-- 실제 실행 순서 : 프웨구해셀오
-- group by 표현식이 아닙니다.
-- group by 옆에 오는 컬럼만 select 절에 사용 가능
SELECT DEPTNO, sum(sal)
FROM EMP e 
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 부서별 급여 평균
SELECT DEPTNO, ROUND(AVG(sal), 2)
FROM EMP e 
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 부서번호, 직무별 급여 평균
SELECT DEPTNO, JOB, AVG(sal) 
FROM EMP e 
GROUP BY DEPTNO, JOB 
ORDER BY DEPTNO;

-- 부서별 직책의 평균 급여가 500 이상인 사원들의 부서번호, 직책, 부서별 직책 평균 급여
SELECT DEPTNO, JOB, avg(sal)
FROM EMP e 
GROUP BY DEPTNO, JOB HAVING avg(sal) >= 500
ORDER BY DEPTNO, JOB;

-- 위에거에서 where절 추가 
SELECT DEPTNO, JOB, avg(sal)
FROM EMP e 
WHERE sal <= 3000
GROUP BY DEPTNO, JOB HAVING avg(sal) >= 2000
ORDER BY DEPTNO, JOB;

-- 같은 직무에 종사하는 사원이 3명이 이상인 직무와 인원수 조회
SELECT JOB, count(JOB) AS "인원수"
FROM EMP e 
GROUP BY JOB HAVING count(job) >= 3
ORDER BY job;

-- 사원들의 입사연도를 기준으로 부서별 몇명이 입사했는지 조회
-- 1981 10 3
-- 1981 20 2
SELECT TO_CHAR(HIREDATE, 'yyyy') AS 입사연도, DEPTNO, COUNT(*) AS 인원수  
FROM EMP e 
GROUP BY TO_CHAR(HIREDATE, 'yyyy'), DEPTNO
ORDER BY TO_CHAR(HIREDATE, 'yyyy');

-- JOIN : 여러 테이블을 하나의 테이블처럼 사용
-- EMP와 DEPT 조인
SELECT * 
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO ;

-- 조인 조건이 없을 때 나올 수 있는 모든 조합이 결과로 나옴
SELECT e.ENAME, e.SAL, d.DEPTNO, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO ;

-- 옛날 구문
SELECT e.ENAME, e.SAL, d.DEPTNO, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL >= 3000;

-- 표준 구문으로 변경(SQL-99) - (join-on)
SELECT e.ENAME, e.SAL, d.DEPTNO, d.DNAME, d.LOC
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE e.SAL >= 3000;

-- emp, salgrade 연결(join)
SELECT *
FROM EMP e, SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- emp, emp 조인(self 조인)
SELECT e.empno, e.ename, e.mgr, e2.ENAME AS MGR_NAME
FROM EMP e, EMP e2
WHERE e.MGR = e2.EMPNO ;

-- 2) 외부조인
-- (1) 왼쪽 외부조인 : LEFT OUTER JOIN
SELECT e.empno, e.ename, e.mgr, e2.ENAME AS MGR_NAME
FROM EMP e LEFT OUTER JOIN EMP e2 ON e.MGR = e2.EMPNO;

-- (2) 오른쪽 외부조인 : RIGHT OUTER JOIN
SELECT e.empno, e.ename, e.mgr, e2.ENAME AS MGR_NAME
FROM EMP e RIGHT OUTER JOIN EMP e2 ON e.MGR = e2.EMPNO;

SELECT DISTINCT mgr
FROM EMP e 

-- 각 부서별 평균급여, 최대급여, 최소급여, 사원수
-- 부서번호, 부서명, 평균급여, 최대급여, 최소급여, 사원수
SELECT e.DEPTNO, d.DNAME, AVG(e.SAL), MAX(e.SAL), MIN(e.SAL), COUNT(*)
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY e.DEPTNO, d.DNAME
-- d.DNAME도 써주는게 중요
ORDER BY e.DEPTNO;
-- group by 표현식이 아닙니다.
-- group by 옆에 오는 컬럼만 select 절에 사용 가능

-- 3개 테이블 조인하기
SELECT *
FROM
	EMP e1
JOIN EMP e2 ON
	e1.EMPNO = e2.EMPNO
JOIN EMP e3 ON
	e2.EMPNO = e3.EMPNO;

-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원 이름 순으로 정렬하여 출력
-- 부서번호, 부서명 , 사원번호, 사원명, 직무, 급여
-- dept 테이블 기준으로 출력
SELECT
	d.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL
FROM
	EMP e
RIGHT OUTER JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
ORDER BY
	d.DEPTNO,
	e.ENAME; 

-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원 이름 순으로 정렬하여 출력
-- 부서번호, 부서명 , 사원번호, 사원명, 직무, 급여, LOSAL, HISAL, GRADE
-- dept 테이블 기준으로 출력
SELECT
	d.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	s.LOSAL,
	s.HISAL,
	s.GRADE
FROM
	DEPT d
LEFT OUTER JOIN EMP e ON
	e.DEPTNO = d.DEPTNO
LEFT OUTER JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	d.DEPTNO,
	e.ENAME;

-- 서브쿼리
-- SQL문 안에 내부에서 SELECT 문을 사용
-- 괄호로 묶어서 사용
-- 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정해야한다.

-- JONES 사원의 급여보다 높은 급여를 받는 사원을 조회
SELECT
	*
FROM
	EMP e
WHERE
	SAL > (
	SELECT
		SAL
	FROM
		EMP e2
	WHERE
		ENAME = 'JONES');

-- allen 이 받는 comm보다 많은 추가수당을 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	COMM > (
	SELECT
		COMM
	FROM
		EMP e2
	WHERE
		ENAME = 'ALLEN');

-- WARD 사원의 입사일보다 빠른 입사자 조회
SELECT
	*
FROM
	EMP e
WHERE
	HIREDATE < (
	SELECT
		HIREDATE
	FROM
		EMP e2
	WHERE
		ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	e.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 20
	AND
	e.SAL > (
	SELECT
		AVG(e.SAL)
	FROM
		EMP e);	

-- 단일행 서브쿼리 : 서브쿼리 실행 결과가 단 하나의 행으로 나오는 서브쿼리
-- 사용가능한 연산자 : >, <, >=, <=, <>, ^=,!=

-- 다중행 서브쿼리 : 서브쿼리 실행 결과가 여러 행으로 나오는 서브쿼리
--  사용가능한 연산자 : IN, ANY(SOME), ALL, EXISTS
--                 IN, ANY(SOME) : 메인 쿼리의 조건식을 만족하는 서브쿼리가 하나 이상
--                 ALL(메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족)
--                 EXISTS(서브 쿼리의 결과가 존재하면)

-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
-- 서브쿼리가 여러 개의 결과값을 리턴하는데 단일행 서브쿼리에 사용하는 연산자가 사용된 경우
-- SELECT * FROM EMP e WHERE SAL >= (SELECT MAX(SAL) FROM EMP e GROUP BY DEPTNO);
SELECT
	*
FROM
	EMP e
WHERE
	SAL IN (
	SELECT
		MAX(SAL)
	FROM
		EMP e
	GROUP BY
		DEPTNO);

-- IN사용과 동일한 결과(ANY)
SELECT
	*
FROM
	EMP e
WHERE
	SAL = ANY (
	SELECT
		MAX(SAL)
	FROM
		EMP e
	GROUP BY
		DEPTNO);

-- 30번 부서의 직원들 중 최대급여보다 적은 직원 조회
-- ANY는 조건이 하나만 맞아도 출력되기 때문에, MAX()를 쓰지 않아도 같은 결과가 나옴
SELECT
	*
FROM
	EMP e
WHERE
	SAL < ANY (
	SELECT
		SAL
	FROM
		EMP e
	WHERE
		DEPTNO = 30);
	
-- ALL은 모든 결과가 만족해야하기 때문에
-- 30번 부서의 직원들 중 가장 급여가 낮은 사람보다 낮은 급여를 받는 사람 출력
-- MIN을 안써도 같은 결과가 나옴
SELECT
	*
FROM
	EMP e
WHERE
	SAL < ALL (
	SELECT
		SAL
	FROM
		EMP e
	WHERE
		DEPTNO = 30);
	
-- 
SELECT
	*
FROM
	EMP e
WHERE
	EXISTS (
	SELECT
		DNAME
	FROM
		DEPT
	WHERE
		DEPTNO = 20);
	
-- 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원정보, 부서 정보를 출력
-- 직업, 사원번호, 이름, 급여, 부서번호, 부서이름
SELECT
	e.JOB,
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO,
	d.DNAME 
FROM
	EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE
	e.JOB IN (
	SELECT
		e.JOB
	FROM
		EMP e
	WHERE
		e.ENAME = 'ALLEN'); 

-- 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 정보를 출력하는 SQL 작성
-- 사원정보, 부서정보, 급여 등급 정보 출력
-- 급여가 많은 순으로 출력되게 정렬, 급여가 같을 경우 사원번호 기준 오름차순 정렬
SELECT
	e.EMPNO,
	e.ENAME,
	d.DNAME,
	e.HIREDATE,
	d.LOC,
	e.SAL,
	s.GRADE
FROM
	EMP e
JOIN DEPT d ON 
	e.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON 
	e.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE
	e.SAL > (
	SELECT
		AVG(e.SAL)
	FROM
		EMP e)
ORDER BY
	e.SAL DESC,
	e.EMPNO;

-- 다중 열 서브쿼리
-- 부서별 급여 최대값
SELECT
	*
FROM
	EMP e
WHERE
	(DEPTNO, SAL)
	IN (
	SELECT
		DEPTNO,
		MAX(SAL)
	FROM
		EMP e
	GROUP BY
		DEPTNO);

-- from절에 사용하는 서브쿼리(인라인 뷰)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
	 (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- select 절에 사용하는 서브쿼리(스칼라 서브쿼리)
SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	(
	SELECT
		GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL) AS SALGRADE
FROM
	EMP e;



SELECT * FROM SALGRADE s;
SELECT * FROM EMP e ;
SELECT * FROM DEPT d ;



-- EMP 테이블에서 사원들은 입사일(hiredate)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원들이 정직원이 되는 날짜(R_JOB)를 yyyy-mm-dd 영식으로 아래와 같이 출력하시오.
-- 단, 추가수당(COMM)이 없는 사원의 추가 수당은 n/a로 출력하시오.

SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	NEXT_DAY(ADD_MONTHS(HIREDATE , 3), '월요일') AS R_JOB,
	NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM
	EMP;

-- DML(DATA Mainpulation Language : 데이터 조작 언어)
-- SELECT(조회), INSERT(삽입), UPDATE(수정), DELETE(삭제)

-- 기존 테이블 복제해서 새로운 테이블 생성
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

-- 새로운 부서 추가
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(60, 'DATABASE', 'DELAWARE');

-- 값의 수가 충분하지 않습니다.
INSERT INTO DEPT_TEMP
VALUES(70, 'DB');

INSERT INTO DEPT_TEMP
VALUES(70, 'DB', 'BUSAN');

INSERT INTO DEPT_TEMP(DEPTNO, DNAME)
VALUES(80, 'SECURITY');

-- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
INSERT INTO DEPT_TEMP(DEPTNO, DNAME)
VALUES(800, 'DATABASE');

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(90, 'DATABASE', NULL);

CREATE TABLE EMP_TEMP AS SELECT * FROM EMP;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8000, 'HONG', 'MANAGER', '7902', '2015-03-15', 1000, NULL, 50);

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(9000, 'SUNG', 'MANAGER', '7782', SYSDATE, 1200, 800, 50);

-- 테이블의 구조만 복사(데이터는 복사하지 않을 때)
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1<>1;

-- 수정(UPDATE)
-- UPDATE 테이블명 SET 수정할 내용, ..., ... ;
-- UPDATE 테이블명 SET 수정할 내용, ..., ... WHERE 조건;
UPDATE DEPT_TEMP SET LOC = 'BUSAN';

UPDATE DEPT_TEMP SET LOC = 'SEOUL' WHERE DEPTNO = 50;

UPDATE DEPT_TEMP SET LOC = 'SEOUL', DNAME = 'NETWORK' WHERE DEPTNO = 40;

-- 삭제(DELETE)
-- DELETE 테이블명 WHERE 조건;
-- DELETE FROM 테이블명 WHERE 조건;
DELETE DEPT_TEMP WHERE DEPTNO = 20;
DELETE FROM DEPT_TEMP WHERE DEPTNO = 30;

-- 서브쿼리 + DELETE
-- 급여등급이 3등급이고, 30번 부서의 사원 삭제
DELETE
FROM
	EMP_TEMP
WHERE
	EMPNO IN (
	SELECT
		EMPNO
	FROM
		EMP_TEMP et
	JOIN SALGRADE s ON
		et.SAL BETWEEN s.LOSAL AND s.HISAL AND s.GRADE = 3 AND et.DEPTNO = 30);

-- 서브쿼리 + UPDATE
UPDATE DEPT_TEMP
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT WHERE DEPTNO = 40)
WHERE DEPTNO = 40;

-- 서브쿼리 + INSERT
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT e.EMPNO, e.ENAME, e.JOB, e.MGR, e.HIREDATE, e.SAL, e.COMM, e.DEPTNO
FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL AND s.GRADE = 1

-- [실습1] 실습을 위해 기존 테이블을 이용하여 테이블 생성
-- 1) EMP 테이블의 내용을 이용하여 EXAM_EMP 생성
-- 2) DEPT 테이블의 내용을 이용하여 EXAM_DEPT 생성
-- 3) SALGRADE 테이블의 내용을 이용하여 EXAM_SALGRADE 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP; 
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;

-- [실습2] 다음의 정보를 EXAM_EMP 테이블에 입력하시오
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, '2016-01-02', 4500, NULL, 50);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, '2016-02-21', 1800, NULL, 50);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7203, 'TEST_USER3', 'ANALIST', 7201, '2016-04-11', 3400, NULL, 60);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, '2016-05-31', 2700, 300, 60);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, '2016-07-20', 2600, NULL, 70);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, '2016-09-08', 2600, NULL, 70);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, '2016-10-28', 2300, NULL, 80);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, '2016-03-09', 1200, NULL, 80);

-- [실습3] EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 
-- 평균 급여보다 많은 급여를 받고 있는 사원들을
-- 70번 부서로 옮기는 SQL문 작성
UPDATE EXAM_EMP
SET DEPTNO = 80 WHERE SAL > (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO = 50);

-- 확인용
SELECT *
FROM EXAM_EMP
WHERE SAL >
(SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO = 50);
-- 


-- [실습4] EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서
-- 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를 10% 인상하고
-- 80번 부서로 옮기는 SQL문 작성
UPDATE EXAM_EMP
SET SAL = (SAL * 1.1), DEPTNO = 80
WHERE HIREDATE > (SELECT MIN(HIREDATE) 
					FROM EXAM_EMP 
					WHERE DEPTNO = 60);

-- 확인용
SELECT *
FROM EXAM_EMP
WHERE HIREDATE >
(SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO = 60);
--

-- [실습5] EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문 작성
DELETE EXAM_EMP
WHERE EMPNO IN (SELECT EMPNO
				FROM EXAM_EMP ee
				JOIN SALGRADE s ON ee.SAL BETWEEN s.LOSAL AND s.HISAL
				WHERE s.GRADE = 5)	

-- 확인용
SELECT empno
FROM EXAM_EMP ee
JOIN SALGRADE s ON ee.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE s.GRADE = 5
--






