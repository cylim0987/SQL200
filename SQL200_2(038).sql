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
    
    
--045 데이터 분석 함수로 데이터를 가로로 출력(LISTAGG)
        --부서 번호 출력, 부서 번호 옆에 해당 부서에 속하는 사원들의 이름을 가로로 출력
SELECT deptno, LISTAGG(ename, ',') within group (order by ename) as EMPLOYEE
FROM emp
GROUP BY deptno;

--LISTAGG 함수는 데이터를 가로로 출력하는 함수
-- LISTAGG에 구분자로 콤마(,)를 사용하여 이름이 콤마(,)로 구분 만약 콤마(,)가 아니라 슬래쉬(/)로 구분하고자 하면
--슬래쉬(/)를 사용하여 구분가능
-- WITHIN GROUP은 '~이내의'라는 뜻으로 group 다음에 나오는 괄호에 속한 그룹의 데이터를 출력

        -- 직업과 그 직업에 속한 사원들의 이름을 가로로 출력하는 예제
SELECT job, LISTAGG(ename, ',') within group (ORDER BY ename) as 사원
FROM emp
GROUP BY job;
        --이름 옆에 월급도 같이 출력하려면 연결 연산자를 사용하여 작성
SELECT job, LISTAGG(ename||'('||sal||')',',') within group (ORDER BY ename) as 사원
FROM emp
GROUP BY job;

--046 데이터 분석 함수로 바로 전 행과 다음 행 출력(LAG, LEAD)
        --사원 번호, 이름, 월급을 출력하고 그 옆에 바로 전 행의 월급을 출력하고, 또 옆에 바로 다음 행의 월급을 출력
SELECT deptno, ename, sal,
            LAG(sal, 1) over (ORDER BY sal asc) as "전 행",
            LEAD(sal, 1) over (ORDER BY sal asc) as "다음 행"
FROM emp
WHERE job in ('ANALYST', 'MANAGER');
--LAG 함수는 바로 전 행의 데이터를 출력하는 함수.    숫자 1을 사용하면 바로 전 행이 출력.   숫자 2를 사용하면 바로 전 전 행이 출력
--LEAD 함수는 바로 다음 행의 데이터를 출력하는 함수. 숫자 1을 사용하면 바로 다음 행이 출력. 숫자 2를 사용하면 바로 다음 다음 행이 출력    

        --직업이 ANALYST 또는 MANAGER 인 사원들의 사원 번호, 이름, 입사일, 바로 전에 입사한 사
        --원의 입사일, 바로 다음에 입사한 사원의 입사일을 출력        
SELECT deptno, ename, hiredate,
        LAG(hiredate, 1) over (ORDER BY hiredate asc) as "전 행",
        LEAD(hiredate, 1) over (ORDER BY hiredate asc) as "다음 행"
FROM emp
WHERE job in ('ANALYST', 'MANAGER');
        
        --부서 번호, 사원 번호, 이름, 입사일, 바로 전에 입사한 사원의 입사일을 출력하고
        --바로 다음에 입사한 사원의 입사일을 출력하는데, 부서 번호별로 구분해서 출력
/*SELECT deptno, empno, ename, hiredate,
        LAG(hiredate, 1) over (ORDER BY deptno asc) as "전 행",
        LEAD(hiredate, 1) over (ORDER BY deptno asc) as "다음 행"
FROM emp;*/
SELECT deptno, empno, ename, hiredate,
        LAG(hiredate, 1) over (PARTITION BY deptno ORDER BY hiredate asc) "전 행",
        LEAD(hiredate, 1) over (PARTITION BY deptno ORDER BY hiredate asc) "다음 행"
FROM emp;

--047 COLUMN을 ROW로 출력. (SUM + DECODE)
        --부서 번호, 부서 번호별 토탈 월급을 출력하는데 가로로 출력.
SELECT SUM(DECODE(deptno, 10, sal)) as "10",
     SUM(DECODE(deptno, 20, sal)) as "20",
     SUM(DECODE(deptno, 30, sal)) as "30"
FROM emp;

        --부서 번호가 10번이면 월급이 출력되고 아니면 NULL이 출력되는 예제
SELECT deptno, DECODE(deptno, 10, sal) as "10"
FROM emp;
        
         --직업, 직업별 토탈 월급을 출력하는데 가로로 출력하는 예제
SELECT SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
FROM emp;
--ANALYST이면 월급을 출력하고 그 월급을 SUM 함수로 합산하면 하나의 값이 출력

        -- 위의 예제에 DEPTNO를 추가. 부서 번호별로 각각 직업의 토탈 월급의 분포를 보기 위함
SELECT deptno, SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
FROM emp
GROUP BY deptno;
        
--048 COLUMN을 ROW로 출력 (PIVOT)
        --부서 번호, 부서 번호별 토탈 월급을 Pivot문을 사용하여 가로로 출력
SELECT *
FROM (SELECT deptno, sal FROM emp)
PIVOT (sum(sal) for deptno in (10, 20, 30));
--SUM과 DECODE를 이용해 출력한 결과를 PIVOT문을 이용하면 좀더 간단한 쿼리문으로 출력할 수 있음..

        -- PIVOT문을 이용해서 직업과 직업별 토탈 월급을 가로로 출력하는 예제
SELECT *
FROM (select job, sal from emp)
PIVOT (sum(sal) for job in ('ANALYST', 'CLERK', 'MANAGER', 'SALESMAN'));
--PIVOT문을 사용할 때는 FROM절에 괄호를 사용해서 특정칼럼만 선택해야 함
--PIVOT문을 이용해 토탈 월급 출력 in 다음에 토탈 월급을 출력할 직업 리스트 나열. 쿼테이션?
SELECT *
FROM (select job, sal from emp)
PIVOT (sum(sal) for job in ('ANALYST' as "분석가", 'CLERK' as "사무원", 'MANAGER' as "매니저", 'SALESMAN' as "세일즈맨"));

--040 ROW를 COLUMN으로 출력(UNPIVOT)
        --UNPIVOT을 이용해 칼럼을 로우로 출력
SELECT *
FROM order2
UNPIVOT (건수 for 아이템 in (BICYCLE, CAMERA, NOTEBOOK));

SELECT *
FROM order2;
--UNPIVOT문은 PIVOT 문과는 반대로 열을 행으로 출력

SELECT *
FROM order2
UNPIVOT (건수 for 아이템 in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));

UPDATE order2 set NOTEBOOK=NULL WHERE ename='SMITH';
--NULL값으로 업데이트 했을시
SELECT *
FROM order2;
--smith의 notebook정보가 출력되지 않음. null값인 행도 결과에 포함시키려면 - include nulls을 사용.
SELECT *
FROM order2
UNPIVOT INCLUDE NULLS (건수 for 아이템 in (BICYCLE, CAMERA, NOTEBOOK));

--050데이터 분석 함수로 누적 데이터 출력(SUM OVER)
        --직업이 ANALYST, MANAGER 인 사원들의 사원 번호, 이름, 월급, 월급의 누적치를 출력하는 쿼리
SELECT empno, ename, sal, SUM(sal) over (ORDER BY empno ROWS 
                                BETWEEN unbounded preceding 
                                AND current row) 누적치
        FROM emp
        WHERE job in ('ANALYST', 'MANAGER');
--unbounded preceding -맨 첫번째 행을 가리킨다
--unbounded following -맨 마지막 행을 가리킨다
--currnet row -현재 행을 가리킨다.

--051 데이터 분석 함수로 비율 출력하기 (RATIO_TO_REPORT) ??
        --부서 번호가 20번인 사원들의 사원 번호, 이름, 월급을 출력하고, 20번 부서 번호 내에서 자신
        --의 월급 비율이 어떻게 되는지 출력
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () as 비율
FROM emp
WHERE deptno = 20;

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () as 비율,
                            SAL/SUM(sal) OVER () as "비교 비율"
            FROM emp
            WHERE deptno = 20;
            
--052 데이터 분석 함수로 집계 결과 출력(ROLLUP)
        --직업, 직업별 토탈 월급 출력. 맨 마지막 행에 토탈 월급 출력
SELECT job, sum(sal)
FROM emp
GROUP BY ROLLUP(job);
--직업과 직업별 토탈 월급을 출력하는 쿼리에 ROLLUP만 붙여주면 전체 토탈 월급을 추가적으로 볼 수 있음

SELECT deptno, job, sum(sal)
FROM emp
GROUP BY ROLLUP(deptno, job);

--053 데이터 분석 함수로 집계 결과 출력(CUBE)
        --직업, 직업별 토탈 월급, 첫 번째 행에 토탈 월급 출력
SELECT job, sum(sal)
FROM emp
GROUP BY CUBE(job); --토탈 합게가 나옴

SELECT job, sum(sal)
FROM emp
GROUP BY job; --토탈 합계가 나오지 않음

SELECT deptno, job, sum(sal)
FROM emp
GROUP BY CUBE(deptno, job);

--054 데이터 분석 함수로 집계 결과 출력(GROUPING SETS)
    --부서 번호와 직업, 부서 번호별 토탈 월급과 직업별 토탈 월급, 전체 토탈 월급 출력
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY GROUPING SETS((deptno), (job), ());
--GROUPING SETS는 앞의 ROLLUP, CUBE보다 집계된 결과를 예상하기 쉽다. GROUPING SETS에 집계하고싶은 칼럼만 기술하면 그대로 출력되기 떄문.

--055 데이터 분석 함수로 출력 결과 넘버링(ROW_NUMBER)
SELECT empno, ename, sal, RANK() OVER (ORDER BY sal DESC) RANK,
                          DENSE_RANK() OVER (ORDER BY sal DESC) DENSE_RANK,
                          ROW_NUMBER() OVER (ORDER BY sal DESC) 번호
        FROM emp
        WHERE deptno = 20;

--ROW_NUMBER()함수는 over 다음 괄호 안에 반드시 ORDER BY절을 기술해야 한다.        
/*SELECT empno, ename, sal, ROW_NUMBER() OVER () 번호
FROM emp
WHERE deptno = 20; */ -- 에러

        --부서 번호별로 월급에 대한 순위를 출력하는 쿼리.
SELECT deptno, ename, sal, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) 번호
FROM emp
WHERE deptno in (10, 20);

