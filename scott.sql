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
