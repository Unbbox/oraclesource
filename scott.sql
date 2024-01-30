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
SET DEPTNO = 70 WHERE SAL > (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO = 50);

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
				
-- 실습 5의 다른 방법
DELETE EXAM_EMP
WHERE EMPNO IN (SELECT EMPNO
				FROM EXAM_EMP, SALGRADE
				WHERE SAL BETWEEN LOSAL AND HISAL AND GRADE = 5);

-- 확인용
SELECT empno
FROM EXAM_EMP ee
JOIN SALGRADE s ON ee.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE s.GRADE = 5


-- 트랜잭션(Transaction)
-- 하나의 작업 또는 밀접하게 연관되어 있는 작업 수행을 위해 나눌 수 없는 최소 작업 단위
-- 최종반영(commit) / 모두 취소(rollback)

-- dbeaver 설정에서 커밋 모드 변경 가능
-- auto commit 상태임
INSERT INTO DEPT_TEMP VALUES(55, 'NETWORK', 'SEOUL');
UPDATE DEPT_TEMP SET LOC = 'BUSAN' WHERE DEPTNO = 55;

COMMIT;
ROLLBACK;

SELECT * FROM DEPT_TEMP dt;

DELETE FROM DEPT_TEMP dt WHERE DEPTNO = 55;
UPDATE DEPT_TEMP SET DNAME = 'WEB' WHERE DEPTNO = 10;

-- LOCK : 한 세션에서 트랜잭션 작업이 완료되지 않으면
--        다른 세션에서 작업을 처리할 수 없는 상태
--        (DML - insert, update, delete)

-- SQL - 1.DDL(정의)   2.DML(select, insert, update, delete)   3.DCL(권한부여)

-- 데이터 정의어 (DDL)
-- 테이블 정의, 사용자 정의, 권한 부여(취소)
-- CREATE

-- 1. 테이블 생성
-- CREATE TABLE 테이블명(
--  필드명 필드타입(크기) 제약조건,
--)

-- 열 이름 규칙
-- 문자로 시작 / 30byte 이하로 작성 / 한 테이블 안 열 이름 중복 불가
-- 열 이름은 문자, 0-9, 특수문자($, #, _) 사용가능
-- sql 키워드는 열 이름으로 사용 불가(order, group, select...)

-- 문자
-- 1)CHAR 2)VARCHAR 3)NCHAR 4)NVARCHAR 5)CLOB 6)NCLOB 7)LONG
-- char or varchar : 열의 너비가 고정값인지 가변인지
-- char(10) : 'hong'	=> 10자리 다 사용		// 고정
-- varchar(10) : 'hong'	=> 입력된 글자에 따라 가변	// 가변

-- varchar2, char 가 한글, 영문, 입력 시 사용하는 바이트 수가 다름
-- nchar, nvarchar 사용하는 바이트 수 통일해서 사용
-- nchar(10) :'hong' => 유니코드 문자열 타입, 고정
-- nvarchar(10) : 'hong' => 유니코드 문자열 타입, 가변

-- CLOB : 문자열 데이터를 외부 파일로 저장
--        엄청 많은 텍스트 데이터 입력 시 사용

-- LONG : 2기가

-- 숫자
-- NUMBER(전체자릿수, 소수점자릿수)
-- BINARY_FLOAT, BINARY_DOUBLE

-- 날짜
-- DATE, TIMESTAMP

CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
);

SELECT * FROM EMP_DDL;

-- 기본 테이블 열 구조와 데이터 복사해서 새 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;

-- 기본 테이블 열 구조만 복사해서 새 테이블 생성
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1<>1;

-- DDL : CREATE, ALTER
-- 2. 테이블 변경
-- 1) 열 추가(ADD)
-- ALTER TABLE 테이블명 ADD 추가할 열이름 데이터타입(10)
-- EMP_DDL 새로운 컬럼 추가 hp
ALTER TABLE EMP_DDL ADD HP VARCHAR2(10);

SELECT * FROM EMP_DDL;

-- 2) 열 이름 변경(RENAME)
-- ALTER TABLE 테이블명 RENAME COLUMN 기존이름 TO 변경이름
-- HP -> MOBILE
ALTER TABLE EMP_DDL RENAME COLUMN HP TO MOBILE;

-- 3) 열 자료형 변경(MODIFY)
-- ALTER TABLE 테이블명 MODIFY 열이름 데이터타입(20)
-- EMPNO NUMBER(5)
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

-- 4) 열 제거
-- ALTER TABLE 테이블명 DROP COLUMN 열이름;
ALTER TABLE EMP_DDL DROP COLUMN MOBILE;

-- 테이블 이름 변경
-- RENAME 변경전테이블명 TO 변경할테이블명
-- EMP_DDL => EMP_ALTER
RENAME EMP_DDL TO EMP_ALTER;
SELECT * FROM EMP_ALTER;


-- CREATE, ALTER, DROP
-- 3) 삭제 : DROP
-- DROP TABLE 테이블명;
DROP TABLE EMP_ALTER;

-- VIEW : 가상테이블

-- CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명)
-- VIEW를 통해 원본 수정이 가능

-- 편리성, 보안성

-- 권한이 불충분합니다
-- view 는 권한을 가진 사용자만 생성 가능
CREATE VIEW VM_EMP20 AS (SELECT * FROM EMP WHERE DEPTNO = 20);

SELECT * FROM VM_EMP20;

-- 뷰 테이블에 값을 추가하면 원본 테이블에도 영챵을 끼친다.
INSERT INTO VM_EMP20
VALUES(8888, 'HONG', 'ANALYST', 7902, SYSDATE, 2500, NULL, 20);

SELECT * FROM EMP e ;

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VM_EMP20';

-- CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명) WITH READ ONLY
-- VIEW를 통해 읽기만 가능
CREATE VIEW VM_EMP30 AS (SELECT * FROM EMP WHERE DEPTNO = 30) WITH READ ONLY;

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VM_EMP30';

-- VIEW 삭제
DROP VIEW VM_EMP20;

-- INDEX 생성, 삭제
-- INDEX(색인, 목차)
-- 인덱스 : 기본키, 고유키 일 때 자동으로 생성됨

-- CREATE INDEX 인덱스명 ON 테이블명(인덱스로사용할필드명)
CREATE INDEX idx_emp_sal ON emp(sal);

SELECT * FROM USER_IND_COLUMNS;

DROP INDEX idx_emp_sal;

-- 시퀀스 생성/삭제
-- 오라클 한정 객체, 하나씩 증가하는 값이 필요할 때 주로 사용
-- 다른 DB의 auto_increment와 동일한 역할

-- CREATE SEQUENCE 시퀀스명
-- INCREMENT BY 증감값 START WITH 시작값 MAXVALUE 최대값 MINVALUE 최소값
-- nocycle cache 숫자;

-- 1에서 시작 ~ 9,999,999,999,999,999,999,999,999,999
-- 1씩 증가하면서 숫자 생성
CREATE SEQUENCE dept_seq;
DROP SEQUENCE dept_seq;

SELECT * FROM USER_SEQUENCES;

CREATE TABLE dept_sequence AS SELECT * FROM dept WHERE 1<>1;
CREATE SEQUENCE dept_seq
INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0
NOCYCLE CACHE 2;

INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC)
VALUES(DEPT_SEQ.NEXTVAL, 'DATABASE', 'SEOUL');

SELECT * FROM DEPT_SEQUENCE;

ALTER SEQUENCE dept_seq INCREMENT BY 3 MAXVALUE 99 CYCLE;

-- 마지막으로 생성된 시퀀스 확인(.CURRVAL)
SELECT dept_seq.CURRVAL FROM DUAL;

-- 제약조건
-- 테이블의 특정 열에 지정
-- 1) NOT NULL : 열에 NULL을 허용하지 않음
-- 2) UNIQUE : 지정한 열이 유일한 값을 가져야 함(NULL은 중복 시 따지지 않음)
-- 3) PRIMARY KEY : 지정한 열이 유일한 값이면서 NULL을 허용하지 않음(테이블 당 하나만 지정)
-- 4) FOREIGN KEY : 다른 테이블의 열을 참조하여 존재하는 값만 입력
-- 5) CHECK : 설정한 조건식을 만족하는 데이터만 입력

-- 열이름(컬럼명) : USERNAME -> USER_NAME(snake case)
CREATE TABLE TBL_NOTNULL(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

INSERT INTO TBL_NOTNULL VALUES('TESTD1', NULL, '010-1234-5678');
INSERT INTO TBL_NOTNULL VALUES('TESTD1', 'TESTD1', NULL);

SELECT * FROM TBL_NOTNULL;

-- 제약조건 확인
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;

CREATE TABLE TBL_NOTNULL2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LOGIN_NN NOT NULL,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LOGPWD_NN NOT NULL,
	TEL VARCHAR2(20)
);

-- 생성한 테이블에 제약 조건 추가
-- TEL에 이미 NULL값이 들어가있어 제약 조건 추가 불가능
ALTER TABLE TBL_NOTNULL MODIFY(TEL NOT NULL);
-- 생성한 테이블에 제약 조건 추가
ALTER TABLE TBL_NOTNULL2 MODIFY(TEL CONSTRAINT TBLNN2_TEL_NN NOT NULL);

-- 기존 TEL 데이터에 NULL값이 아닌 다른 값 입력
UPDATE TBL_NOTNULL
SET TEL = '010-1234-5678' WHERE TEL IS NULL;

-- 생성한 제약 조건 이름 변경
ALTER TABLE TBL_NOTNULL2 RENAME CONSTRAINT TBLNN2_TEL_NN TO TBLNN2_TEL;

-- 제약 조건 삭제
ALTER TABLE TBL_NOTNULL2 DROP CONSTRAINT TBLNN2_TEL;

-- UNIQUE : 중복되지 않은 값
CREATE TABLE TBL_UNIQUE(
	LOGIN_ID VARCHAR2(20) UNIQUE,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

-- 데이터 무결성 : 데이터 정확성, 일관성을 보장해야 함

-- 무결성 제약 조건(SCOTT.SYS_C008361)에 위배
INSERT INTO TBL_UNIQUE VALUES('TESTD1', 'TESTD1', '010-1234-5678');

CREATE TABLE TBL_UNIQUE2(
	LOGIN_ID VARCHAR2(20) CONSTRAINTS TBL_UNQ2_LOGIN_ID UNIQUE,
	LOGIN_PWD VARCHAR2(20) CONSTRAINTS TBL_UNQ2_LOGPWD_NN NOT NULL,
	TEL VARCHAR2(20)
);

-- 제약조건 확인
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;

ALTER TABLE TBL_UNIQUE2 MODIFY(TEL UNIQUE);
ALTER TABLE TBL_UNIQUE MODIFY(TEL CONSTRAINTS TBL_UNQ_TEL_UNQ UNIQUE);

ALTER TABLE TBL_UNIQUE DROP CONSTRAINT TBL_UNQ_TEL_UNQ;

-- 3) PRIMARY KEY(PK) : 기본키
-- 인덱스 설정 자동으로 만들어짐
-- NOT NULL + UNIQUE => 회원 아이디, 이메일, 상품코드, 글번호, ...

CREATE TABLE TBL_PRIMARY(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20)  NOT NULL,
	TEL VARCHAR2(20)
);

INSERT INTO TBL_PRIMARY(LOGIN_ID, LOGIN_PWD, TEL)
VALUES('TESTID1', 'TESTPWD1', '010-1234-5678');

-- 4) FOREIGN KEY(외래키) : 다른 테이블의 기본키로 지정한 열을 다른 테이블의 특정 열에서 참조
-- 부모키 / 자식키

CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
	DNAME VARCHAR2(20),
	LOC VARCHAR2(20)
);

CREATE TABLE EMP_FK(
	EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIERDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
);

DROP TABLE EMP_FK;

-- 부모(참조 대상 테이블) / 자식(참조하는 테이블)
-- 부모 키가 없습니다(참조 대상 테이블에 데이터 INSERT)
INSERT INTO EMP_FK VALUES(1000, 'HONG', 'CLERK', 7788, SYSDATE, 1200, NULL, 50);

INSERT INTO DEPT_FK VALUES(50, 'DATABASE', 'SEOUL');

-- 자식 레코드가 발견되었습니다(참조하는 테이블의 자식 DELETE)
DELETE FROM DEPT_FK WHERE DEPTNO = 50;

-- FOREIGN KEY
-- 1) ON DELETE CASCADE : 부모가 삭제되면 자식도 같이 삭제
-- 2) ON DELETE SET NULL : 부모가 삭제되면 자식이 참조하는 부모의 값을 NULL로 변경

CREATE TABLE EMP_FK2(
	EMPNO NUMBER(4) CONSTRAINT EMPFK2_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIERDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT EMPFK2_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE
);
DROP TABLE EMP_FK2;
INSERT INTO EMP_FK2 VALUES(1000, 'HONG', 'CLERK', 7788, SYSDATE, 1200, NULL, 50); 

-- 부모가 제거되면서 자식도 같이 제거됨
DELETE FROM DEPT_FK WHERE DEPTNO = 50;

CREATE TABLE EMP_FK3(
	EMPNO NUMBER(4) CONSTRAINT EMPFK3_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIERDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT EMPFK3_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL
);

INSERT INTO DEPT_FK VALUES(50, 'DATABASE', 'SEOUL');
INSERT INTO EMP_FK3 VALUES(1000, 'HONG', 'CLERK', 7788, SYSDATE, 1200, NULL, 50);

DELETE FROM DEPT_FK WHERE DEPTNO = 50;
SELECT * FROM EMP_FK3;

-- 5) CHECK : 열에 저장할 수 있는 값의 범위 혹은 패턴 정의
CREATE TABLE TBL_CHECK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_PWD_CK CHECK(LENGTH(LOGIN_PWD) > 3),
	TEL VARCHAR2(20)
);

-- 체크 제약조건(SCOTT.TBLCK_PWD_CK)이 위배
INSERT INTO TBL_CHECK VALUES('TESTID1', '123', NULL);

CREATE TABLE TBL_CHECK2(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK2_PWD_CK CHECK(LENGTH(LOGIN_PWD) > 3),
	GRADE VARCHAR2(10) CONSTRAINT TBLCK2_GRADE_CK CHECK (GRADE IN ('SILVER', 'GOLD', 'VIP')),
	TEL VARCHAR2(20)
);

-- 체크 제약조건(SCOTT.TBLCK2_GRADE_CK)이 위배
INSERT INTO TBL_CHECK2 VALUES('TESTID1', '1234', 'DIAMOND', NULL);

-- DEFAULT : 기본값 주기
CREATE TABLE TBL_DEFAULT(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
	TEL VARCHAR2(20)
);

INSERT INTO TBL_DEFAULT VALUES('TESTID1', '4678', NULL);
INSERT INTO TBL_DEFAULT(LOGIN_ID, TEL) VALUES('TESTID2', '010-1234-5678');
SELECT * FROM TBL_DEFAULT;

CREATE TABLE COMPANY(
	CMP_CODE NUMBER(4) CONSTRAINT CMP_CODE_PK PRIMARY KEY,
	CMP_NAME VARCHAR(20) CONSTRAINT CMP_CAME_NN NOT NULL,
	TEL VARCHAR2(20) CONSTRAINT CMP_TEL_NN NOT NULL,
	LOCATION VARCHAR2(10) CONSTRAINT CMP_LOC_NN NOT NULL,
	MANAGER VARCHAR2(10) CONSTRAINT CMP_MNG_NN NOT NULL
);

INSERT INTO COMPANY VALUES(1000, '오리온', '02-123-4567', '대전', '홍길동');


CREATE TABLE HANBIT(
	PCODE NUMBER(20) PRIMARY KEY,
	CMP_CODE NUMBER(4) CONSTRAINT HBT_CODE_FK REFERENCES COMPANY(CMP_CODE),
	PNAME VARCHAR2(20) NOT NULL,
	AMOUNT NUMBER NOT NULL,
	PRICE NUMBER NOT NULL,
	SUPPLY_DATE DATE NOT NULL,
	SUPPLY_AMOUNT NUMBER NOT NULL
);

CREATE SEQUENCE PRODUCT_SEQ;

INSERT INTO PRODUCT(PCODE, CMP_CODE, PNAME, AMOUNT, PRICE, SUPPLY_DATE, SUPPLY_AMOUT)
VALUES(PRODUCT_SEQ.NEXTVAL, 1000, '초코파이', 100, 5500, '2024-01-02', 500);

CREATE TABLE member(
	userid varchar2(20) PRIMARY KEY,
	userpwd varchar2(30) NOT NULL,
	name varchar2(20) NOT NULL,
	age number(3) CHECK(age >= 0),
	job varchar2(10) DEFAULT NULL,
	grade varchar2(10) DEFAULT 'SILVER' CHECK(grade IN ('SILVER', 'GOLD', 'VIP')),
	point NUMBER(8) DEFAULT 0
)

INSERT INTO member(userid, userpwd, name)
VALUES('kim123', 'kim123', '김지호');

INSERT INTO member(userid, userpwd, name, age)
values('kim1234', 'kim123', '김지호', 15);

INSERT INTO member(userid, userpwd, name, job)
values('kim12345', 'kim123', '김지호', '학생');

-- 주문번호는 sequence로 많이 씀
-- 주문일자도 SYSDATE 많이 씀
-- 추가로 봐야함 insert 작동이 안됨
CREATE TABLE MEMBER_ORDER(
	ORDER_ID NUMBER PRIMARY KEY,
	userid varchar2(20) REFERENCES member(userid),
	PCODE NUMBER(20) REFERENCES HANBIT(PCODE),
	AMOUNT NUMBER NOT NULL,
	ADDR VARCHAR2(20) NOT NULL,
	ORDER_DATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE ORDER_SEQ;

INSERT INTO MEMBER_ORDER(ORDER_ID, userid, PCODE, AMOUNT, ADDR)
VALUES(ORDER_SEQ.NEXTVAL, 'hong123', 1, 10, '서울시 종로구');



-- 게시글 번호도 sequence로 많이 씀
CREATE TABLE BOARD(
	BNO NUMBER PRIMARY KEY,
	userid VARCHAR2(20) REFERENCES member(userid),
	TITLE VARCHAR2(20) NOT NULL,
	CONTENT VARCHAR2(2000) NOT NULL,
	REG_DATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE BOARD_SEQ;

INSERT INTO BOARD(BNO, TITLE, CONTENT)
VALUES(BOARD_SEQ.NEXTVAL, 'INSERT', 'INSERT');

SELECT * FROM BOARD;

-- 제약조건
CREATE TABLE EMP_FK2(
	EMPNO NUMBER(4) CONSTRAINT EMPFK4_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIERDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) 
	CONSTRAINT EMPFK4_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
);












