--058 ���� ���̺��� �����͸� �����ؼ� ��� (EQUI JOIN)
        --���(EMP) ���̺�� �μ�(DEPT) ���̺��� �����Ͽ� �̸��� �μ� ��ġ�� ���
SELECT ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;
/*
SELECT Į��1, Į��2
FROM ���̺�1, ���̺�2
WHERE ���̺�1.Į��# = ���̺�2.Į��#;*/

--ename�� emp ���̺� �ְ� loc�� dept ���̺� �����ϹǷ� ename�� loc�� �ϳ��� ����� �� ���ϱ� ���ؼ��� from���� emp�� dept �� �� ����Ѵ�.
-- emp�� dept�� �����ϱ� ���ؼ��� ���� ������ �־�� �Ѵ�.
-- ���� ������ �� ���� ���̺��� �����ϱ� ���� �����.. emp���̺� deptno�� ����, dept ���̺��� deptno�� ����. 
--emp���̺��� �μ� ��ȣ�� dept ���̺��� �μ� ��ȣ�� ���ٶ�� ���� : emp.deptno=dept.deptno�� �־� ������ ����.

SELECT ename, loc
FROM emp, dept;

SELECT ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT ename, loc, job
FROM emp, dept
WHERE emp.deptno = dept.deptno and emp.job='ANALYST';
--        (Join ����)                   (�˻� ����)

SELECT ename, loc, job, deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno and emp.job='ANALYST';
--����. Į�� deptno�� emp���̺���, dept���̺��� �����ϴ� Į���̱� ����.
--�̷����� �� �̸� �տ� ���̺���� ���ξ�� �ٿ�����(SELECT -- emp.deptno)
SELECT ename, loc, job, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno and emp.job='ANALYST';
--������ ���̺���� �ϳ��ϳ� ���̴� ���̺���� �ݺ��Ǹ鼭 �ڵ尡 �����.
--�׷��� ���̺�� �ڿ� ���̺� ��Ī�� ����� �ڵ带 �����ϰ� ��.
SELECT e.ename, d.loc, e.job
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.job='ANALYST';

SELECT emp.ename, d.loc, e.job
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.job='ANALYST';
--SELECT�κ� emp.ename�� e.ename���� ����� ������ ���� �ʴ´�.

