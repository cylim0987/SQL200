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

--020 특정 철자를 다른 철자로 변경 (REPlACE)

SELECT ename, REPLACE(sal, 0, '*' )
FROM emp;

SELECT ename, REGEXP_REPlACE(sal, '[0-3]', '*') as SALARY
FROM emp;


CREATE TABLE TEST_ENAME
(ENAME      VARCHAR2(10));

INSERT INTO TEST_ENAME VALUES('김인호');
INSERT INTO TEST_ENAME VALUES('안상수');
INSERT INTO TEST_ENAME VALUES('최영희');
COMMIT;

SELECT ename
FROM test_ename;

/*
SELECT ename REPLACE (ename, '[2]', '*')
FROM test_ename;
*/


--SUBSTR + REPLACE
SELECT REPLACE(ENAME, SUBSTR(ENAME, 2, 1), '*') as "전광판 이름"
FROM test_ename;

--021 특정 철자를 N개 만큼 채우기 (LPAD, RPAD)
SELECT ename, LPAD(sal, 10, '*') as salary1, RPAD(sal, 10, '*') as salary2
FROM emp;

SELECT ename, sal, RPAD('#', round(sal/100) , '#') as bar_chart
FROM emp;

--022 특정 철자 잘라내기 (TRIM, RTRIM, LTRIM)
SELECT 'smith', LTRIM('smith', 's') as 맨앞삭제, RTRIM('smith', 'h'), TRIM('s' from 'smiths')
FROM dual;

INSERT INTO emp(empno, ename, sal, job, deptno)
VALUES(8291, 'JACK ', 3000, 'SALESMAN', 30);
commit;

--위에 공백을 넣었기 때문에 안 나온다
SELECT ename, sal
FROM emp
WHERE ename = 'JACK';
--

SELECT ename, sal
FROM emp
WHERE RTRIM(ename)='JACK';

DELETE FROM emp
WHERE TRIM(ename)='JACK';
commit;

--023 반올림해서 출력(ROUND)
SELECT '876.567' as 숫자, ROUND(876.567, 1)
FROM dual;
-- 567에서 6에서 반올림 되었다. 그러면 -2는 876에서 7에서 반올림이니까 900이 나올까. 그렇다

SELECT '876.567' as 숫자, ROUND(876.567, -2)
FROM dual;
-- 소수점을 가르는 . 이 0의 자리를 가리킨다.

--024 숫자를 버리고 출력(TRUNC)
SELECT '876.567' as 숫자, TRUNC(876.567, 1)
FROM dual;

--025 나눈 나머지 값 출력(MOD)
SELECT MOD(10, 3)
FROM dual;

-- empno를 2로 나눈 나머지.
SELECT empno, MOD(empno, 2)
FROM emp;

--사원번호가 짝수인 사원들의 사원 번호와 이름을 출력하는 쿼리 -
    --SELECT절에 몰아넣지 말고 WHERE를 이용해야... SELECT에서 어떻게 더 해야하는지 고민하니까 답이 나올리가 없음
    --SELECT empno, ename, MOD(empno, 2)
    --FROM emp;
SELECT empno, ename
FROM emp
WHERE MOD(empno, 2) = 0;

--10을 3으로 나눈 몫을 출력.
SELECT FLOOR(10/3)
FROM dual;

--026 날짜 간 개월 수 출력 (MONTHS_BETWEEN)
SELECT ename, MONTHS_BETWEEN(sysdate, hiredate)
FROM emp;

SELECT TO_DATE('2019-06-01', 'RRRR-MM-DD') - TO_DATE('2018-10-01', 'RRRR-MM-DD')
FROM dual;

--다음과 같이 하면 총 주수가 35가 나온다 그런데
SELECT ROUND((TO_DATE('2019-06-01','RRRR-MM-DD') - TO_DATE('2018-10-01','RRRR-MM-DD')) / 7 ) as "총 주수"
FROM dual;

--이렇게 하면 우괄호를 누락해서 오류가 발생함.
SELECT ROUND((TO_DATE('2019-06-01','RRRR-MM-DD') -
            TO_DATE('2018-10-01','RRRR-MM-DD')) / 7 ) as "총 주수"
FROM dual;

--027 개월 수 더한 날짜 출력하기(ADD_MONTHS)
SELECT ADD_MONTHS(TO_DATE('2019-05-01', 'RRRR-MM-DD'), 100)
FROM dual;

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '100' month
FROM dual;

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '3' year
FROM dual;

--028 특정 날짜 뒤에 오는 요일 날짜 출력(NEXT_DAY) -- 월요일, 월 , 화 다 된다.
SELECT '2019/05/22' as 날짜, NEXT_DAY('2019/05/22', '화')
FROM dual;

SELECT sysdate as "오늘 날짜"
FROM dual;

SELECT NEXT_DAY(SYSDATE, '화요일') as "다음 날짜"
FROM dual;

SELECT NEXT_DAY(ADD_MONTHS('2019/05/22', 100), '화요일') as "다음 날짜"
FROM dual;

SELECT NEXT_DAY(ADD_MONTHS(sysdate, 100), '월요일') as "다음 날짜"
FROM dual;

--029 특정 날짜가 있는 달의 마지막 날짜 출력(LAST_DAY)
SELECT '2019/05/22' as 날짜, LAST_DAY('2019/05/22') as "마지막 날짜"
FROM dual;

SELECT LAST_DAY(SYSDATE) - SYSDATE as "남은 날짜"
FROM dual;

--이름이 KING인 사원의 이름, 입사일, 입사한 달의 마지막 날짜를 출력
SELECT ename, hiredate, LAST_DAY(hiredate)
FROM emp
WHERE ename='KING';

--030 문자형으로 데이터 유형 변환(TO_CHAR)
SELECT ename, hiredate, sal
FROM emp
WHERE ename = 'SCOTT';


--숫자형을 문자형으로 변환할 때, 날짜형을 문자형으로 변환할 때 : TO_CHAR
SELECT ename, TO_CHAR(hiredate, 'DAY') as 요일, TO_CHAR(sal, '999,999') as 월급
FROM emp
WHERE ename = 'SCOTT';

SELECT hiredate, TO_CHAR(hiredate, 'RRRR') as 연도, TO_CHAR(hiredate, 'MM')as 달,
                TO_CHAR(hiredate, 'DD') as 일, TO_CHAR(hiredate, 'DAY') as 요일
FROM emp
WHERE hiredate = '81/11/17';

--1981년도에 입사한 사원의 이름과 입사일을 출력하는 쿼리
SELECT ename, hiredate
FROM emp
WHERE TO_CHAR(hiredate, 'RRRR') = '1981';

SELECT ename as 이름, EXTRACT(year from hiredate) as 연도,
                     EXTRACT(month from hiredate) as 달,
                     EXTRACT(day from hiredate) as 일
FROM emp;

SELECT ename as 이름, to_char(sal, '999,999') as 월급
FROM emp;

SELECT ename as 이름, TO_CHAR(sal*200, '999,999,999') as 월급
FROM emp;

SELECT ename as 이름, TO_CHAR(sal*200, 'L999,999,999') as 월급
FROM emp;

--031 날짜형으로 데이터 유형 변환(TO_DATE)
SELECT ename, hiredate
FROM emp
WHERE hiredate = TO_DATE('81/11/17','RR/MM/DD');

SELECT *
FROM NLS_SESSION_PARAMETERS
WHERE parameter = 'NLS_DATE_FORMAT';

SELECT ename, hiredate
FROM emp
WHERE hiredate = TO_DATE('81/11/17');

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/RR';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '17/11/81';

SELECT ename, hiredate
FROM emp
WHERE hiredate = TO_DATE('81/11/17', 'RR/MM/DD');

ALTER SESSION set nls_date_format='rr/mm/dd';

ALTER SESSION SET NLS_DATE_FORMAT='RR/MM/DD';

--032 암시적 형 변환?
SELECT ename, sal
FROM emp
WHERE sal = '3000';

--032-2
CREATE TABLE EMP32
(ENAME VARCHAR2(10),
SAL VARCHAR2(10));

INSERT INTO EMP32 VALUES('SCOTT', '3000');
INSERT INTO EMP32 VALUES('SMITH', '1200');
COMMIT;

SELECT ename, sal
FROM emp32
WHERE sal = '3000';

--된다. 문자형=숫자형
SELECT ename, sal
FROM emp32
WHERE sal = 3000;

--오라클이 자동변환함.
SELECT ename, sal
FROM emp32
WHERE TO_NUMBER(SAL) = 3000;

SET AUTOT ON

SELECT ename, sal
FROM emp32
WHERE SAL = 3000;

--033 NULL 값 대신 다른 데이터 출력(NVL, NVL2)
SELECT ename, comm, NVL(comm, 0)
FROM emp;

SELECT ename, sal, comm, sal+comm, job
FROM emp;

--IN은 (값)을 포함하는 조건검색
SELECT ename, sal, comm, sal+comm, job
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

SELECT ename, sal, comm, NVL(comm, 0), sal+NVL(comm, 0)
FROM emp
WHERE job IN ('SALESMAN', 'ANALYST');

SELECT ename, sal, comm, NVL2(comm, sal+comm, sal)
FROM emp
WHERE job IN ('SALESMAN', 'ANALYST');

--034 IF문을 SQL로 구현(DECODE)
--                          부서 번호가 10번이면 300,  부서번호가 20번이면 400 부서번호가 10번, 20번이 아니면 0
SELECT ename, deptno, DECODE(deptno,   10,     300,            20,    400,            0) as 보너스 
FROM emp;
    /*
    IF DEPTNO = 10 THEN 300
    else if DEPTNO = 20 THEN 400
    else 0
    */

SELECT empno, mod(empno, 2), DECODE(mod(empno, 2), 0, '짝수', 1, '홀수') as 보너스
FROM emp;

SELECT empno, DECODE(mod(empno, 2), 0, '짝수', 1, '홀수') as 보너스
FROM emp;

--나머지에 해당하는 2000은 else에 해당하는 것이기 때문에 앞에 아무것도 써줄 필요 없다는 것을 기억할 것
SELECT ename, job, DECODE(job, 'SALESMAN', 5000, 'MANAGER',333, 2000) as 보너스
FROM emp;
SELECT ename, job, DECODE(job, 'SALESMAN', 5555, 2000) as 보너스
FROM emp;

--035 IF문을 SQL로 구현(CASE)
SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                             WHEN sal >= 2000 THEN 300
                             WHEN sal >= 1000 THEN 200
                             ELSE 0 END AS BONUS
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
--CASE / DECODE
--DECODE는 등호(=)비교만 가능,
--CASE는 등호(=) 부등호(>=, <=, >, <) 둘 다 가능.

                    --다음의 예제는 이름, 직업, 커미션, 보너스를 출력합니다. 보너스는 커미션이 NULL이면
                    --500을 출력하고 NULL이 아니면 0을 출력합니다.
SELECT ename, job, comm, DECODE(comm, null, 500, 0)  as 보너스
FROM emp;

                    -- + SALESMAN과 ANALYST만
SELECT ename, job, comm, CASE WHEN comm is null THEN 500
                              ELSE 0 END as 보너스
FROM emp
WHERE job in ('SALESMAN', 'ANALYST');
    
                    --보너스를 출력할 때 직업이 SALESMAN, ANALYST이면 500을 출력하고, 직업
                    --이 CLERK, MANAGER이면 400을 출력하고, 나머지 직업은 0을 출력하는 쿼리
/*
SELECT ename, job, sal, DECODE(('SALESMAN', 'ANALYST'), 500, ('CLERK', 'MANAGER'), 400, 0)
FROM emp;
*/

/* -- is가 아니라 IN을 썼어야지 값을 포함하는거니까
SELECT ename, job, CASE WHEN job is ('SALESMAN', 'ANALYST') THEN 500
                        WHEN job is ('CLERK', 'MANAGER') THEN 400
                        ELSE 0 END as 보너스
FROM emp;
*/
SELECT ename, job, CASE WHEN job IN ('SALESMAN', 'ANALYST') THEN 500
                        WHEN job IN ('CLERK', 'MANAGER') THEN 400
                        ELSE 0 END bonus
FROM emp;

--036 최대값 출력(MAX)
SELECT MAX(sal)
FROM emp;

SELECT MAX(sal)
FROM emp
WHERE job='SALESMAN';


/* -- 에러. job 칼럼의 값은 여러 개의 행이 출력되려고 하는데 MAX(sal)의 값은 하나가 출력되려 하기 때문임.
        때문에 GROUP by 절이 필요함 GROUP BY절은 데이터를 grouping한다.
SELECT job, MAX(sal)
FROM emp
WHERE job='SALESMAN';
*/

SELECT job, MAX(sal)
FROM emp
WHERE job='SALESMAN'
GROUP BY job;

                    --부서 번호와 부서 번호별 최대 월급을 출력하는 쿼리입
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;


--037 최소값 출력(MIN)
SELECT MIN(SAL)
FROM EMP
WHERE job = 'SALESMAN';

                        --직업과 직업별 최소 월급을 출력하는데, ORDER BY절을 사용하여 최소 월급이 높은것부터 출력
/*SELECT MIN(sal)
FROM emp
ORDER BY job;
*/

--ORDER BY 정렬 asc, desc 
--ORDER BY절은 항상 맨 마지막에 작성하고 실행 또한 맨 마지막에 실행
SELECT job, MIN(sal) as 최소값
FROM emp
GROUP BY job
ORDER BY 최소값 DESC;

SELECT MIN(sal)
FROM emp
WHERE 1 = 2;

                        --직업, 직업별 최소 월급을 출력하는데, 직업에서 SAELSMAN은 제외하고 출력하고 직업별 최소 월급이 높은 것부터 출력
SELECT job, MIN(sal)
FROM emp
GROUP BY job
ORDER BY MIN(sal) desc;
                        
SELECT job, MIN(sal)
FROM emp
WHERE job != 'SALESMAN' --제외
GROUP BY job
ORDER BY MIN(sal) desc;                        
                        