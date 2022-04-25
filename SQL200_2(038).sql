--038 ��հ� ���(AVG) --�׷��Լ��� null���� �����Ѵ�. null�� ������ ������ �������� ����� ����ߴ�.
SELECT avg(comm)
FROM emp;
--550

SELECT ROUND(AVG(NVL(comm,0)))
FROM emp;
--:157

--039 ��Ż�� ���
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

        --������ ������ ��Ż ������ ����ϴµ� ������ ��Ż ������ ���� �ͺ��� ���
SELECT job, SUM(sal)
FROM emp
GROUP BY job
ORDER BY 2 desc;

        --������ ������ ��Ż ������ ����ϴµ�, ������ ��Ż ������ 4000 �̻��� �͸� ���
SELECT job, SUM(sal)
FROM emp
WHERE SUM(sal) >= 4000; --�ȵǴ� �� �³�
--�׷� �Լ��� ������ �� ���� WHERE�� ��� HAVING ���� ���
SELECT job, SUM(sal)
FROM emp
GROUP by job
HAVING SUM(sal) >= 4000;

        --������ ������ ��Ż ������ ����ϴµ� �������� SALESMAN�� �����ϰ�, ������ ��Ż ������ 4000 �̻��� ����鸸 ���
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


--040 �Ǽ� ����ϱ�(COUNT)
SELECT COUNT(empno)
FROM emp; --14

SELECT COUNT(*)
FROM emp; --14

SELECT COUNT(comm)
FROM emp; --4(NULL �� ����)

--041 ������ �м� �Լ��� ���� ���(RANK)
        --������ ANALYST, MANAGER �� ������� �̸�, ����, ����, ������ ������ ���
/*SELECT ename, job, sal
FROM emp
WHERE job IN ('ANALYST', 'MANAGER');
HAVING sal asc;
*/
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) ����
FROM emp
WHERE job IN ('ANALYST', 'MANAGER');
--RANK()�� ������ ����ϴ� ������ �м� �Լ�.
SELECT ename, job, sal
FROM emp
WHERE job IN ('ANALYST', 'MANAGER')
ORDER BY sal desc;

SELECT ename, job, sal, RANK() over (PARTITION BY job ORDER BY sal DESC) as ����
FROM emp;