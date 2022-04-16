--SQL 200제

--001
select empno, ename, sal
FROM emp;

--002
select *
from emp;

SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp;

--003
Select empno as "사원 번호", ename as 사원이름, sal as "Salary"
FROM emp;

SELECT ename, sal *(12 + 3000)
FROM emp;

SELECT ename, sal *(12 + 3000) as 월급
FROM emp;

SELECT ename, sal*(12+3000) as 월급
FROM emp
ORDER by 월급 desc;

--004
SELECT  ename||sal
FROM emp;

/* 연결 연산자. 컬럼과 컬럼을 서로 연결해서 출력 */

SELECT ename || '의 월급은' || sal || '입니다....' as 월급정보
FROM emp;

select ename || '의 직업은 ' || job || '입니다...' as 직업정보
FROM emp;

--005 중복된 데이터를 제거해서 출력(DISTINCT)
SELECT DISTINCT job
FROM emp;

select unique job
from emp;

select * from emp;

--006
SELECT ename, sal
FROM emp
ORDER BY sal asc; --asc 내림차순

SELECT ename, sal as 월급
FROM emp
ORDER BY 월급 desc;

SELECT ename, deptno, sal
FROM emp
ORDER BY deptno asc, sal desc;

SELECT ename, deptno, sal
FROM emp
ORDER BY 1 asc, 2 asc, 3 desc;

--007 where절

SELECT ename, sal, job
FROM emp
WHERE sal = 3000
ORDER BY 1 desc;

SELECT ename as 이름, sal as 월급
FROM emp
WHERE sal >= 3000;

/*
SELECT ename as 이름, sal as 월급
FROM emp
WHERE 월급 >= 3000; --오류. from emp가 1번, where가 2번, select가 3번으로 실행되기 때문.
*/

--008 (문자와 날짜 검색)
SELECT ename, sal, job, hiredate, deptno
FROM emp
WHERE ename = 'SCOTT'; --대문자 소문자 신경쓸 것

SELECT ename, hiredate
FROM emp
WHERE hiredate = '81/11/17';

alter session set nls_date_format='YY/MM/DD';
alter session set nls_date_format='RR/MM/DD';

--009 산술 연산자
SElECT ename, sal*12 as 연봉
FROM emp
WHERE sal*12 >= 36000;

SELECT ename, sal, comm, sal+comm
FROM emp
WHERE deptno = 10;

/* NVL 함수는 null 데이터를 처리한느 함수. NVL(comm,0)은 comm이 null이면 0으로 출력.*/
SELECT ename, sal, NVL(comm,0), NVL(sal+comm,3939) 
FROM emp
WHERE deptno = 10;

--010
SELECT ename, sal, job, deptno
FROM emp
WHERE sal <= 1200;

--011
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 3000;

--BETWEEN 하한값 AND 상한값. 반대로 하면 검색되지 않는다.
SELECT ename, sal
FROM emp
WHERE (sal >= 1000 AND sal <= 3000);

SELECT ename, sal
FROM emp
WHERE (sal <1000 OR sal >3000);

SELECT ename, sal
FROM emp
WHERE sal NOT BETWEEN 1000 AND 3000;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '1982/01/01' AND '1982/12/31';

--012 --%
SELECT ename, sal
FROM emp
WHERE ename LIKE 'S%';

SELECT ename, sal
FROM emp
WHERE ename LIKE '_M%';

-- % : 0개 이상의 임의 문자와 일치, _ : 하나의 문자와 일치
SELECT ename
FROM emp
WHERE ename LIKE '%G';

--A를 포함하는.
SELECT ename
FROM emp
WHERE ename LIKE '%A%';

--013 . !=NULL 불가.
SELECT ename, NVL(comm,0)
FROM emp
WHERE comm is null;

--014
SELECT ename, sal, job
FROM emp
WHERE job in ('SALESMAN', 'ANALYST', 'MANAGER')
ORDER BY 2 asc, 3 desc;

SELECT ename, sal, job
FROM emp
WHERE (job ='SALESMAN' or job='ANALYST' or job='MANAGER');

SELECT ename, sal, job
FROm emp
WHERE job NOT in ('salesman', 'analyst', 'manager');

SELECT ename, sal, job
FROM emp
WHERE (job != 'SALESMAN' and job !='ANALYST' and job != 'MANAGER');

--015 (AND OR NOT)
SELECT ename, sal, job
FROM emp
WHERE sal >= 1200 AND job ='SALESMAN';

SELECT ename, sal, job
FROM emp
WHERE sal >= 1200 OR job ='ABCD';

--016 UPPER LOWER INITCAP
--UPPER:모두대문자 ,LOWER:소문자, INITCAP:첫번째만 대문자로 출력
SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
FROM emp;

SELECT ename, sal
FROM emp
WHERE LOWER(ename)='scott';

SELECT ename, sal
FROM emp
WHERE INITCAP(ename)='Scott';

SELECT ename, sal
FROM emp
WHERE UPPER(ename)='SCOTT';

SELECT ename, sal
FROM emp
WHERE LOWER(ename)='scott';

--017 SUBSTR -- SMITH, 1, 2 : 1은 추출을 시작할 위치. 2는 몇 개,
-- 1,2,3,4,5,6 = 1,2,3, -3, -2, -1
SELECT SUBSTR('SMITH', -3, 3)
FROM DUAL;

--018 문자열의 길이 출력(LENGTH)
SELECT ename, LENGTH(ename), job, LENGTH(job)
FROM emp;

SELECT LENGTH('가나다라마')
FROM DUAL;

--019 문자에서 특정 철자의 위치 출력(INSTR)
SELECT INSTR('SMITH', 'M')
FROM DUAL;

SELECT INSTR('abcdefg@naver.com', '@')
FROM DUAL;

SELECT INSTR('cylim.dev@gmail.com', 'v')
FROM DUAL;

SELECT SUBSTR('abcdefgh@naver.com', INSTR('abcdefgh@naver.com','@')+1)
FROM DUAL;

SELECT RTRIM(SUBSTR('abcdefgh@naver.com', INSTR('abcdefgh@naver.com','@') + 1) , '.com') as rtrim
FROM DUAL;