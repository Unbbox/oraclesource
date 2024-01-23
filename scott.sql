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


