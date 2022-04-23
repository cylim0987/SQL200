--SQL 200��

--001
select empno, ename, sal
FROM emp;

--002
select *
from emp;

SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp;

--003
Select empno as "��� ��ȣ", ename as ����̸�, sal as "Salary"
FROM emp;

SELECT ename, sal *(12 + 3000)
FROM emp;

SELECT ename, sal *(12 + 3000) as ����
FROM emp;

SELECT ename, sal*(12+3000) as ����
FROM emp
ORDER by ���� desc;

--004
SELECT  ename||sal
FROM emp;

/* ���� ������. �÷��� �÷��� ���� �����ؼ� ��� */

SELECT ename || '�� ������' || sal || '�Դϴ�....' as ��������
FROM emp;

select ename || '�� ������ ' || job || '�Դϴ�...' as ��������
FROM emp;

--005 �ߺ��� �����͸� �����ؼ� ���(DISTINCT)
SELECT DISTINCT job
FROM emp;

select unique job
from emp;

select * from emp;

--006
SELECT ename, sal
FROM emp
ORDER BY sal asc; --asc ��������

SELECT ename, sal as ����
FROM emp
ORDER BY ���� desc;

SELECT ename, deptno, sal
FROM emp
ORDER BY deptno asc, sal desc;

SELECT ename, deptno, sal
FROM emp
ORDER BY 1 asc, 2 asc, 3 desc;

--007 where��

SELECT ename, sal, job
FROM emp
WHERE sal = 3000
ORDER BY 1 desc;

SELECT ename as �̸�, sal as ����
FROM emp
WHERE sal >= 3000;

/*
SELECT ename as �̸�, sal as ����
FROM emp
WHERE ���� >= 3000; --����. from emp�� 1��, where�� 2��, select�� 3������ ����Ǳ� ����.
*/

--008 (���ڿ� ��¥ �˻�)
SELECT ename, sal, job, hiredate, deptno
FROM emp
WHERE ename = 'SCOTT'; --�빮�� �ҹ��� �Ű澵 ��

SELECT ename, hiredate
FROM emp
WHERE hiredate = '81/11/17';

alter session set nls_date_format='YY/MM/DD';
alter session set nls_date_format='RR/MM/DD';

--009 ��� ������
SElECT ename, sal*12 as ����
FROM emp
WHERE sal*12 >= 36000;

SELECT ename, sal, comm, sal+comm
FROM emp
WHERE deptno = 10;

/* NVL �Լ��� null �����͸� ó���Ѵ� �Լ�. NVL(comm,0)�� comm�� null�̸� 0���� ���.*/
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

--BETWEEN ���Ѱ� AND ���Ѱ�. �ݴ�� �ϸ� �˻����� �ʴ´�.
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

-- % : 0�� �̻��� ���� ���ڿ� ��ġ, _ : �ϳ��� ���ڿ� ��ġ
SELECT ename
FROM emp
WHERE ename LIKE '%G';

--A�� �����ϴ�.
SELECT ename
FROM emp
WHERE ename LIKE '%A%';

--013 . !=NULL �Ұ�.
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
--UPPER:��δ빮�� ,LOWER:�ҹ���, INITCAP:ù��°�� �빮�ڷ� ���
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

--017 SUBSTR -- SMITH, 1, 2 : 1�� ������ ������ ��ġ. 2�� �� ��,
-- 1,2,3,4,5,6 = 1,2,3, -3, -2, -1
SELECT SUBSTR('SMITH', -3, 3)
FROM DUAL;

--018 ���ڿ��� ���� ���(LENGTH)
SELECT ename, LENGTH(ename), job, LENGTH(job)
FROM emp;

SELECT LENGTH('�����ٶ�')
FROM DUAL;

--019 ���ڿ��� Ư�� ö���� ��ġ ���(INSTR)
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

--020 Ư�� ö�ڸ� �ٸ� ö�ڷ� ���� (REPlACE)

SELECT ename, REPLACE(sal, 0, '*' )
FROM emp;

SELECT ename, REGEXP_REPlACE(sal, '[0-3]', '*') as SALARY
FROM emp;


CREATE TABLE TEST_ENAME
(ENAME      VARCHAR2(10));

INSERT INTO TEST_ENAME VALUES('����ȣ');
INSERT INTO TEST_ENAME VALUES('�Ȼ��');
INSERT INTO TEST_ENAME VALUES('�ֿ���');
COMMIT;

SELECT ename
FROM test_ename;

/*
SELECT ename REPLACE (ename, '[2]', '*')
FROM test_ename;
*/


--SUBSTR + REPLACE
SELECT REPLACE(ENAME, SUBSTR(ENAME, 2, 1), '*') as "������ �̸�"
FROM test_ename;

--021 Ư�� ö�ڸ� N�� ��ŭ ä��� (LPAD, RPAD)
SELECT ename, LPAD(sal, 10, '*') as salary1, RPAD(sal, 10, '*') as salary2
FROM emp;

SELECT ename, sal, RPAD('#', round(sal/100) , '#') as bar_chart
FROM emp;

--022 Ư�� ö�� �߶󳻱� (TRIM, RTRIM, LTRIM)
SELECT 'smith', LTRIM('smith', 's') as �Ǿջ���, RTRIM('smith', 'h'), TRIM('s' from 'smiths')
FROM dual;

INSERT INTO emp(empno, ename, sal, job, deptno)
VALUES(8291, 'JACK ', 3000, 'SALESMAN', 30);
commit;

--���� ������ �־��� ������ �� ���´�
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

--023 �ݿø��ؼ� ���(ROUND)
SELECT '876.567' as ����, ROUND(876.567, 1)
FROM dual;
-- 567���� 6���� �ݿø� �Ǿ���. �׷��� -2�� 876���� 7���� �ݿø��̴ϱ� 900�� ���ñ�. �׷���

SELECT '876.567' as ����, ROUND(876.567, -2)
FROM dual;
-- �Ҽ����� ������ . �� 0�� �ڸ��� ����Ų��.

--024 ���ڸ� ������ ���(TRUNC)
SELECT '876.567' as ����, TRUNC(876.567, 1)
FROM dual;

--025 ���� ������ �� ���(MOD)
SELECT MOD(10, 3)
FROM dual;

-- empno�� 2�� ���� ������.
SELECT empno, MOD(empno, 2)
FROM emp;

--�����ȣ�� ¦���� ������� ��� ��ȣ�� �̸��� ����ϴ� ���� -
    --SELECT���� ���Ƴ��� ���� WHERE�� �̿��ؾ�... SELECT���� ��� �� �ؾ��ϴ��� ����ϴϱ� ���� ���ø��� ����
    --SELECT empno, ename, MOD(empno, 2)
    --FROM emp;
SELECT empno, ename
FROM emp
WHERE MOD(empno, 2) = 0;

--10�� 3���� ���� ���� ���.
SELECT FLOOR(10/3)
FROM dual;

--026 ��¥ �� ���� �� ��� (MONTHS_BETWEEN)
SELECT ename, MONTHS_BETWEEN(sysdate, hiredate)
FROM emp;

SELECT TO_DATE('2019-06-01', 'RRRR-MM-DD') - TO_DATE('2018-10-01', 'RRRR-MM-DD')
FROM dual;

--������ ���� �ϸ� �� �ּ��� 35�� ���´� �׷���
SELECT ROUND((TO_DATE('2019-06-01','RRRR-MM-DD') - TO_DATE('2018-10-01','RRRR-MM-DD')) / 7 ) as "�� �ּ�"
FROM dual;

--�̷��� �ϸ� ���ȣ�� �����ؼ� ������ �߻���.
SELECT ROUND((TO_DATE('2019-06-01','RRRR-MM-DD') -
            TO_DATE('2018-10-01','RRRR-MM-DD')) / 7 ) as "�� �ּ�"
FROM dual;

--027 ���� �� ���� ��¥ ����ϱ�(ADD_MONTHS)
SELECT ADD_MONTHS(TO_DATE('2019-05-01', 'RRRR-MM-DD'), 100)
FROM dual;

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '100' month
FROM dual;

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '3' year
FROM dual;

--028 Ư�� ��¥ �ڿ� ���� ���� ��¥ ���(NEXT_DAY) -- ������, �� , ȭ �� �ȴ�.
SELECT '2019/05/22' as ��¥, NEXT_DAY('2019/05/22', 'ȭ')
FROM dual;

SELECT sysdate as "���� ��¥"
FROM dual;

SELECT NEXT_DAY(SYSDATE, 'ȭ����') as "���� ��¥"
FROM dual;

SELECT NEXT_DAY(ADD_MONTHS('2019/05/22', 100), 'ȭ����') as "���� ��¥"
FROM dual;

SELECT NEXT_DAY(ADD_MONTHS(sysdate, 100), '������') as "���� ��¥"
FROM dual;

--029 Ư�� ��¥�� �ִ� ���� ������ ��¥ ���(LAST_DAY)
SELECT '2019/05/22' as ��¥, LAST_DAY('2019/05/22') as "������ ��¥"
FROM dual;

SELECT LAST_DAY(SYSDATE) - SYSDATE as "���� ��¥"
FROM dual;

--�̸��� KING�� ����� �̸�, �Ի���, �Ի��� ���� ������ ��¥�� ���
SELECT ename, hiredate, LAST_DAY(hiredate)
FROM emp
WHERE ename='KING';

--030 ���������� ������ ���� ��ȯ(TO_CHAR)
SELECT ename, hiredate, sal
FROM emp
WHERE ename = 'SCOTT';


--�������� ���������� ��ȯ�� ��, ��¥���� ���������� ��ȯ�� �� : TO_CHAR
SELECT ename, TO_CHAR(hiredate, 'DAY') as ����, TO_CHAR(sal, '999,999') as ����
FROM emp
WHERE ename = 'SCOTT';

SELECT hiredate, TO_CHAR(hiredate, 'RRRR') as ����, TO_CHAR(hiredate, 'MM')as ��,
                TO_CHAR(hiredate, 'DD') as ��, TO_CHAR(hiredate, 'DAY') as ����
FROM emp
WHERE hiredate = '81/11/17';

--1981�⵵�� �Ի��� ����� �̸��� �Ի����� ����ϴ� ����
SELECT ename, hiredate
FROM emp
WHERE TO_CHAR(hiredate, 'RRRR') = '1981';

SELECT ename as �̸�, EXTRACT(year from hiredate) as ����,
                     EXTRACT(month from hiredate) as ��,
                     EXTRACT(day from hiredate) as ��
FROM emp;

SELECT ename as �̸�, to_char(sal, '999,999') as ����
FROM emp;

SELECT ename as �̸�, TO_CHAR(sal*200, '999,999,999') as ����
FROM emp;

SELECT ename as �̸�, TO_CHAR(sal*200, 'L999,999,999') as ����
FROM emp;

--031 ��¥������ ������ ���� ��ȯ(TO_DATE)
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

--032 �Ͻ��� �� ��ȯ?
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

--�ȴ�. ������=������
SELECT ename, sal
FROM emp32
WHERE sal = 3000;

--����Ŭ�� �ڵ���ȯ��.
SELECT ename, sal
FROM emp32
WHERE TO_NUMBER(SAL) = 3000;

SET AUTOT ON

SELECT ename, sal
FROM emp32
WHERE SAL = 3000;

--033 NULL �� ��� �ٸ� ������ ���(NVL, NVL2)
SELECT ename, comm, NVL(comm, 0)
FROM emp;

SELECT ename, sal, comm, sal+comm, job
FROM emp;

--IN�� (��)�� �����ϴ� ���ǰ˻�
SELECT ename, sal, comm, sal+comm, job
FROM emp
WHERE job IN ('SALESMAN','ANALYST');

SELECT ename, sal, comm, NVL(comm, 0), sal+NVL(comm, 0)
FROM emp
WHERE job IN ('SALESMAN', 'ANALYST');

SELECT ename, sal, comm, NVL2(comm, sal+comm, sal)
FROM emp
WHERE job IN ('SALESMAN', 'ANALYST');

--034 IF���� SQL�� ����(DECODE)
--                          �μ� ��ȣ�� 10���̸� 300,  �μ���ȣ�� 20���̸� 400 �μ���ȣ�� 10��, 20���� �ƴϸ� 0
SELECT ename, deptno, DECODE(deptno,   10,     300,            20,    400,            0) as ���ʽ� 
FROM emp;
    /*
    IF DEPTNO = 10 THEN 300
    else if DEPTNO = 20 THEN 400
    else 0
    */

SELECT empno, mod(empno, 2), DECODE(mod(empno, 2), 0, '¦��', 1, 'Ȧ��') as ���ʽ�
FROM emp;

SELECT empno, DECODE(mod(empno, 2), 0, '¦��', 1, 'Ȧ��') as ���ʽ�
FROM emp;

--�������� �ش��ϴ� 2000�� else�� �ش��ϴ� ���̱� ������ �տ� �ƹ��͵� ���� �ʿ� ���ٴ� ���� ����� ��
SELECT ename, job, DECODE(job, 'SALESMAN', 5000, 'MANAGER',333, 2000) as ���ʽ�
FROM emp;
SELECT ename, job, DECODE(job, 'SALESMAN', 5555, 2000) as ���ʽ�
FROM emp;

--035 IF���� SQL�� ����(CASE)
SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                             WHEN sal >= 2000 THEN 300
                             WHEN sal >= 1000 THEN 200
                             ELSE 0 END AS BONUS
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
--CASE / DECODE
--DECODE�� ��ȣ(=)�񱳸� ����,
--CASE�� ��ȣ(=) �ε�ȣ(>=, <=, >, <) �� �� ����.

                    --������ ������ �̸�, ����, Ŀ�̼�, ���ʽ��� ����մϴ�. ���ʽ��� Ŀ�̼��� NULL�̸�
                    --500�� ����ϰ� NULL�� �ƴϸ� 0�� ����մϴ�.
SELECT ename, job, comm, DECODE(comm, null, 500, 0)  as ���ʽ�
FROM emp;

                    -- + SALESMAN�� ANALYST��
SELECT ename, job, comm, CASE WHEN comm is null THEN 500
                              ELSE 0 END as ���ʽ�
FROM emp
WHERE job in ('SALESMAN', 'ANALYST');
    
                    --���ʽ��� ����� �� ������ SALESMAN, ANALYST�̸� 500�� ����ϰ�, ����
                    --�� CLERK, MANAGER�̸� 400�� ����ϰ�, ������ ������ 0�� ����ϴ� ����
/*
SELECT ename, job, sal, DECODE(('SALESMAN', 'ANALYST'), 500, ('CLERK', 'MANAGER'), 400, 0)
FROM emp;
*/

/* -- is�� �ƴ϶� IN�� ������ ���� �����ϴ°Ŵϱ�
SELECT ename, job, CASE WHEN job is ('SALESMAN', 'ANALYST') THEN 500
                        WHEN job is ('CLERK', 'MANAGER') THEN 400
                        ELSE 0 END as ���ʽ�
FROM emp;
*/
SELECT ename, job, CASE WHEN job IN ('SALESMAN', 'ANALYST') THEN 500
                        WHEN job IN ('CLERK', 'MANAGER') THEN 400
                        ELSE 0 END bonus
FROM emp;

--036 �ִ밪 ���(MAX)
SELECT MAX(sal)
FROM emp;

SELECT MAX(sal)
FROM emp
WHERE job='SALESMAN';


/* -- ����. job Į���� ���� ���� ���� ���� ��µǷ��� �ϴµ� MAX(sal)�� ���� �ϳ��� ��µǷ� �ϱ� ������.
        ������ GROUP by ���� �ʿ��� GROUP BY���� �����͸� grouping�Ѵ�.
SELECT job, MAX(sal)
FROM emp
WHERE job='SALESMAN';
*/

SELECT job, MAX(sal)
FROM emp
WHERE job='SALESMAN'
GROUP BY job;

                    --�μ� ��ȣ�� �μ� ��ȣ�� �ִ� ������ ����ϴ� ������
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;


--037 �ּҰ� ���(MIN)
SELECT MIN(SAL)
FROM EMP
WHERE job = 'SALESMAN';

                        --������ ������ �ּ� ������ ����ϴµ�, ORDER BY���� ����Ͽ� �ּ� ������ �����ͺ��� ���
/*SELECT MIN(sal)
FROM emp
ORDER BY job;
*/

--ORDER BY ���� asc, desc 
--ORDER BY���� �׻� �� �������� �ۼ��ϰ� ���� ���� �� �������� ����
SELECT job, MIN(sal) as �ּҰ�
FROM emp
GROUP BY job
ORDER BY �ּҰ� DESC;

SELECT MIN(sal)
FROM emp
WHERE 1 = 2;

                        --����, ������ �ּ� ������ ����ϴµ�, �������� SAELSMAN�� �����ϰ� ����ϰ� ������ �ּ� ������ ���� �ͺ��� ���
SELECT job, MIN(sal)
FROM emp
GROUP BY job
ORDER BY MIN(sal) desc;
                        
SELECT job, MIN(sal)
FROM emp
WHERE job != 'SALESMAN' --����
GROUP BY job
ORDER BY MIN(sal) desc;                        
                        