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

