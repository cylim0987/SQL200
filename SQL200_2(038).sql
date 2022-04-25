--038 평균값 출력(AVG) --그룹함수는 null값을 무시한다. null을 제외한 나머지 데이터의 평균을 출력했다.
SELECT avg(comm)
FROM emp;
--550

SELECT ROUND(AVG(NVL(comm,0)))
FROM emp;
--:157

--039 토탈값 출력
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

        --직업과 직업별 토탈 월급을 출력하는데 직업별 토탈 월급이 높은 것부터 출력
SELECT job, SUM(sal)
FROM emp
GROUP BY job
ORDER BY 2 desc;

        --직업과 직업별 토탈 월급을 출력하는데, 직업별 토탈 월급이 4000 이상인 것만 출력
SELECT job, SUM(sal)
FROM emp
WHERE SUM(sal) >= 4000; --안되는 게 맞네
--그룹 함수로 조건을 줄 때는 WHERE절 대신 HAVING 절을 사용
SELECT job, SUM(sal)
FROM emp
GROUP by job
HAVING SUM(sal) >= 4000;

        --직업과 직업별 토탈 월급을 출력하는데 직업에서 SALESMAN은 제외하고, 직업별 토탈 월급이 4000 이상인 사원들만 출력
/*SELECT job, SUM(sal)
FROM emp
GROUP BY job
HAVING SUM(sal) >= 4000
NOT IN 'SALESMAN'*/
--
SELECT job, SUM(sal)
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal) >= 4000
ORDER BY sum(sal) DESC;


--040 건수 출력하기(COUNT)
SELECT COUNT(empno)
FROM emp; --14

SELECT COUNT(*)
FROM emp; --14

SELECT COUNT(comm)
FROM emp; --4(NULL 값 무시)

--041 데이터 분석 함수로 순위 출력(RANK)
        --직업이 ANALYST, MANAGER 인 사원들의 이름, 직업, 월급, 월급의 순위를 출력
/*SELECT ename, job, sal
FROM emp
WHERE job IN ('ANALYST', 'MANAGER');
HAVING sal asc;
*/
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) 순위
FROM emp
WHERE job IN ('ANALYST', 'MANAGER');
--RANK()는 순위를 출력하는 데이터 분석 함수.
SELECT ename, job, sal
FROM emp
WHERE job IN ('ANALYST', 'MANAGER')
ORDER BY sal desc;

SELECT ename, job, sal, RANK() over (PARTITION BY job ORDER BY sal DESC) as 순위
FROM emp;