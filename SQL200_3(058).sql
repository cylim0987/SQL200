--058 여러 테이블의 데이터를 조인해서 출력 (EQUI JOIN)
        --사원(EMP) 테이블과 부서(DEPT) 테이블을 조인하여 이름과 부서 위치를 출력
SELECT ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;
/*
SELECT 칼럼1, 칼럼2
FROM 테이블1, 테이블2
WHERE 테이블1.칼럼# = 테이블2.칼럼#;*/

--ename은 emp 테이블에 있고 loc는 dept 테이블에 존재하므로 ename과 loc를 하나의 결과로 출 력하기 위해서는 from절에 emp와 dept 둘 다 기술한다.
-- emp와 dept를 조인하기 위해서는 조인 조건이 있어야 한다.
-- 조인 조건은 두 개의 테이블을 연결하기 위한 연결고리.. emp테이블에 deptno가 존재, dept 테이블에더 deptno가 존재. 
--emp테이블의 부서 번호는 dept 테이블의 부서 번호와 같다라는 조건 : emp.deptno=dept.deptno를 주어 조인을 수행.

SELECT ename, loc
FROM emp, dept;

SELECT ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT ename, loc, job
FROM emp, dept
WHERE emp.deptno = dept.deptno and emp.job='ANALYST';
--        (Join 조건)                   (검색 조건)

SELECT ename, loc, job, deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno and emp.job='ANALYST';
--오류. 칼럼 deptno는 emp테이블에도, dept테이블에도 존재하는 칼럼이기 떄문.
--이럴때는 열 이름 앞에 테이블명을 접두어로 붙여야함(SELECT -- emp.deptno)
SELECT ename, loc, job, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno and emp.job='ANALYST';
--하지만 테이블명을 하나하나 붙이니 테이블명이 반복되면서 코드가 길어짐.
--그래서 테이블명 뒤에 테이블 별칭을 사용해 코드를 간결하게 함.
SELECT e.ename, d.loc, e.job
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.job='ANALYST';

SELECT emp.ename, d.loc, e.job
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.job='ANALYST';
--SELECT부분 emp.ename을 e.ename으로 해줘야 오류가 나지 않는다.

