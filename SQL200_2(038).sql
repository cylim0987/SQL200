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

--042 데이터 분석 함수로 순위 출력(DENSE_RANK)
        --이 ANALYST, MANAGER인 사원들의 이름, 직업, 월급, 월급의 순위를 출력하는데
        --순위 1위인 사원이 두 명이 있을 경우 다음 순위가 3위로 출력되지 않고 2위로 출력
/*SELECT ename, job, sal, DENSE_RANK() over (ORDER BY 
FROM emp
WHERE job in 'ANALYST', 'MANAGER';*/
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) AS RANK,
                        DENSE_RANK() over (ORDER BY sal DESC) AS DENSE_RANK
FROM emp
WHERE job in ('ANALYST', 'MANAGER');
--WHERE job = ('ANALYST','MANAGER');//안됨

        -- 81년도에 입사한 사원들의 직업, 이름, 월급, 순위를 출력하는데, 직업별로 월
        --급이 높은 순서대로 순위를 부여한 쿼리
/*SELECT job, ename, sal, RANK() over (ORDER BY sal DESC) AS RANK
FROM emp
WHERE hiredate in '81/MM/DD';
*/
SELECT job, ename, sal, DENSE_RANK() OVER (PARTITION BY job
                                            ORDER BY sal DESC) 순위
FROM emp
WHERE hiredate BETWEEN to_date('1981/01/01', 'RRRR/MM/DD')
                    AND to_date('1981/12/31', 'RRRR/MM/DD');

SELECT DENSE_RANK(2975) within group (ORDER BY sal DESC) 순위
FROM emp; --3

        --입사일 81년 11월 17일인 사원 테이블 전체 사원들 중 몇 번째로 입사한 것인지
        --출력하는 쿼리
SELECT DENSE_RANK('81/11/17') within group (ORDER BY hiredate ASC) 순위
FROM emp; --9

--043 데이터 분석 함수로 등급 출력(NTILE)
        --이름과 월급, 직업, 월급의 등급을 출력. 월급의 등급은 4등급으로 나눠 1등급
        --(0~25%), 2등급 (25~50%), 3등급 (50~75%), 4등급 (75~100%)으로 출력
SELECT ename, sal, job, NTILE(4) over (order by sal desc nulls last) 등급
FROM emp;

--NTILE 함수에 숫자 4를 사용하면 4등급올 나눠지고 #을 사용하면 #등급으로 나누어진다.
SELECT ename, comm
FROM emp
WHERE deptno = 30
ORDER BY comm DESC;

--null값을 마지막에 출력
SELECT ename, comm
FROM emp
WHERE deptno = 30
ORDER BY comm DESC NULLS LAST;
        
        
        
        
        
--044 데이터 분석 함수로 순위의 비율 출력(CUME_DIST)
        --이름과 월급, 월급의 순위, 월급의 순위 비율을 출력

SELECT ename, sal, RANK() over (order by sal desc) as RANK,
                   DENSE_RANK() over (ORDER BY sal desc) as DENSE_RANK,
                   CUME_DIST() over (ORDER BY sal desc) as CUME_DIST
    FROM emp;

        -- PARTITION BY JOB을 사용해 직업별로 CUME DIST를 출력
SELECT job, ename, sal, RANK() over (PARTITION BY job ORDER BY sal desc) as RANK,
                        CUME_DIST() over (PARTITION by job ORDER BY sal desc) as CUME_DIST
    FROM emp;