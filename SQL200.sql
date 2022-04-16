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