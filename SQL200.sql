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