--058 ���� ���̺��� �����͸� �����ؼ� ��� (EQUI JOIN)
        --���(EMP) ���̺�� �μ�(DEPT) ���̺��� �����Ͽ� �̸��� �μ� ��ġ�� ���
SELECT ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--ename�� emp ���̺� �ְ� loc�� dept ���̺� �����ϹǷ� ename�� loc�� �ϳ��� ����� �� ���ϱ� ���ؼ��� from���� emp�� dept �� �� ����Ѵ�.
-- emp�� dept�� �����ϱ� ���ؼ��� ���� ������ �־�� �Ѵ�.
-- ���� ������ �� ���� ���̺��� �����ϱ� ���� �����.. emp���̺� deptno�� ����, dept ���̺��� deptno�� ����. 
--emp���̺��� �μ� ��ȣ�� dept ���̺��� �μ� ��ȣ�� ���ٶ�� ���� : emp.deptno=dept.deptno�� �־� ������ ����.

SELECT ename, loc
FROM emp, dept;