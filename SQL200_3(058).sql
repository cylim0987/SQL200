--058 여러 테이블의 데이터를 조인해서 출력 (EQUI JOIN)
        --사원(EMP) 테이블과 부서(DEPT) 테이블을 조인하여 이름과 부서 위치를 출력
SELECT ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--ename은 emp 테이블에 있고 loc는 dept 테이블에 존재하므로 ename과 loc를 하나의 결과로 출 력하기 위해서는 from절에 emp와 dept 둘 다 기술한다.
-- emp와 dept를 조인하기 위해서는 조인 조건이 있어야 한다.
-- 조인 조건은 두 개의 테이블을 연결하기 위한 연결고리.. emp테이블에 deptno가 존재, dept 테이블에더 deptno가 존재. 
--emp테이블의 부서 번호는 dept 테이블의 부서 번호와 같다라는 조건 : emp.deptno=dept.deptno를 주어 조인을 수행.

SELECT ename, loc
FROM emp, dept;