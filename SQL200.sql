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

