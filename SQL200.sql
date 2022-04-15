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