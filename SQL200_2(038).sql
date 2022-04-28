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

--042 ������ �м� �Լ��� ���� ���(DENSE_RANK)
        --�� ANALYST, MANAGER�� ������� �̸�, ����, ����, ������ ������ ����ϴµ�
        --���� 1���� ����� �� ���� ���� ��� ���� ������ 3���� ��µ��� �ʰ� 2���� ���
/*SELECT ename, job, sal, DENSE_RANK() over (ORDER BY 
FROM emp
WHERE job in 'ANALYST', 'MANAGER';*/
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) AS RANK,
                        DENSE_RANK() over (ORDER BY sal DESC) AS DENSE_RANK
FROM emp
WHERE job in ('ANALYST', 'MANAGER');
--WHERE job = ('ANALYST','MANAGER');//�ȵ�

        -- 81�⵵�� �Ի��� ������� ����, �̸�, ����, ������ ����ϴµ�, �������� ��
        --���� ���� ������� ������ �ο��� ����
/*SELECT job, ename, sal, RANK() over (ORDER BY sal DESC) AS RANK
FROM emp
WHERE hiredate in '81/MM/DD';
*/
SELECT job, ename, sal, DENSE_RANK() OVER (PARTITION BY job
                                            ORDER BY sal DESC) ����
FROM emp
WHERE hiredate BETWEEN to_date('1981/01/01', 'RRRR/MM/DD')
                    AND to_date('1981/12/31', 'RRRR/MM/DD');

SELECT DENSE_RANK(2975) within group (ORDER BY sal DESC) ����
FROM emp; --3

        --�Ի��� 81�� 11�� 17���� ��� ���̺� ��ü ����� �� �� ��°�� �Ի��� ������
        --����ϴ� ����
SELECT DENSE_RANK('81/11/17') within group (ORDER BY hiredate ASC) ����
FROM emp; --9

--043 ������ �м� �Լ��� ��� ���(NTILE)
        --�̸��� ����, ����, ������ ����� ���. ������ ����� 4������� ���� 1���
        --(0~25%), 2��� (25~50%), 3��� (50~75%), 4��� (75~100%)���� ���
SELECT ename, sal, job, NTILE(4) over (order by sal desc nulls last) ���
FROM emp;

--NTILE �Լ��� ���� 4�� ����ϸ� 4��޿� �������� #�� ����ϸ� #������� ����������.
SELECT ename, comm
FROM emp
WHERE deptno = 30
ORDER BY comm DESC;

--null���� �������� ���
SELECT ename, comm
FROM emp
WHERE deptno = 30
ORDER BY comm DESC NULLS LAST;
        
        
        
        
        
--044 ������ �м� �Լ��� ������ ���� ���(CUME_DIST)
        --�̸��� ����, ������ ����, ������ ���� ������ ���

SELECT ename, sal, RANK() over (order by sal desc) as RANK,
                   DENSE_RANK() over (ORDER BY sal desc) as DENSE_RANK,
                   CUME_DIST() over (ORDER BY sal desc) as CUME_DIST
    FROM emp;

        -- PARTITION BY JOB�� ����� �������� CUME DIST�� ���
SELECT job, ename, sal, RANK() over (PARTITION BY job ORDER BY sal desc) as RANK,
                        CUME_DIST() over (PARTITION by job ORDER BY sal desc) as CUME_DIST
    FROM emp;