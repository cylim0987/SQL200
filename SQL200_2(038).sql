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
    
    
--045 ������ �м� �Լ��� �����͸� ���η� ���(LISTAGG)
        --�μ� ��ȣ ���, �μ� ��ȣ ���� �ش� �μ��� ���ϴ� ������� �̸��� ���η� ���
SELECT deptno, LISTAGG(ename, ',') within group (order by ename) as EMPLOYEE
FROM emp
GROUP BY deptno;

--LISTAGG �Լ��� �����͸� ���η� ����ϴ� �Լ�
-- LISTAGG�� �����ڷ� �޸�(,)�� ����Ͽ� �̸��� �޸�(,)�� ���� ���� �޸�(,)�� �ƴ϶� ������(/)�� �����ϰ��� �ϸ�
--������(/)�� ����Ͽ� ���а���
-- WITHIN GROUP�� '~�̳���'��� ������ group ������ ������ ��ȣ�� ���� �׷��� �����͸� ���

        -- ������ �� ������ ���� ������� �̸��� ���η� ����ϴ� ����
SELECT job, LISTAGG(ename, ',') within group (ORDER BY ename) as ���
FROM emp
GROUP BY job;
        --�̸� ���� ���޵� ���� ����Ϸ��� ���� �����ڸ� ����Ͽ� �ۼ�
SELECT job, LISTAGG(ename||'('||sal||')',',') within group (ORDER BY ename) as ���
FROM emp
GROUP BY job;

--046 ������ �м� �Լ��� �ٷ� �� ��� ���� �� ���(LAG, LEAD)
        --��� ��ȣ, �̸�, ������ ����ϰ� �� ���� �ٷ� �� ���� ������ ����ϰ�, �� ���� �ٷ� ���� ���� ������ ���
SELECT deptno, ename, sal,
            LAG(sal, 1) over (ORDER BY sal asc) as "�� ��",
            LEAD(sal, 1) over (ORDER BY sal asc) as "���� ��"
FROM emp
WHERE job in ('ANALYST', 'MANAGER');
--LAG �Լ��� �ٷ� �� ���� �����͸� ����ϴ� �Լ�.    ���� 1�� ����ϸ� �ٷ� �� ���� ���.   ���� 2�� ����ϸ� �ٷ� �� �� ���� ���
--LEAD �Լ��� �ٷ� ���� ���� �����͸� ����ϴ� �Լ�. ���� 1�� ����ϸ� �ٷ� ���� ���� ���. ���� 2�� ����ϸ� �ٷ� ���� ���� ���� ���    

        --������ ANALYST �Ǵ� MANAGER �� ������� ��� ��ȣ, �̸�, �Ի���, �ٷ� ���� �Ի��� ��
        --���� �Ի���, �ٷ� ������ �Ի��� ����� �Ի����� ���        
SELECT deptno, ename, hiredate,
        LAG(hiredate, 1) over (ORDER BY hiredate asc) as "�� ��",
        LEAD(hiredate, 1) over (ORDER BY hiredate asc) as "���� ��"
FROM emp
WHERE job in ('ANALYST', 'MANAGER');
        
        --�μ� ��ȣ, ��� ��ȣ, �̸�, �Ի���, �ٷ� ���� �Ի��� ����� �Ի����� ����ϰ�
        --�ٷ� ������ �Ի��� ����� �Ի����� ����ϴµ�, �μ� ��ȣ���� �����ؼ� ���
/*SELECT deptno, empno, ename, hiredate,
        LAG(hiredate, 1) over (ORDER BY deptno asc) as "�� ��",
        LEAD(hiredate, 1) over (ORDER BY deptno asc) as "���� ��"
FROM emp;*/
SELECT deptno, empno, ename, hiredate,
        LAG(hiredate, 1) over (PARTITION BY deptno ORDER BY hiredate asc) "�� ��",
        LEAD(hiredate, 1) over (PARTITION BY deptno ORDER BY hiredate asc) "���� ��"
FROM emp;

--047 COLUMN�� ROW�� ���. (SUM + DECODE)
        --�μ� ��ȣ, �μ� ��ȣ�� ��Ż ������ ����ϴµ� ���η� ���.
SELECT SUM(DECODE(deptno, 10, sal)) as "10",
     SUM(DECODE(deptno, 20, sal)) as "20",
     SUM(DECODE(deptno, 30, sal)) as "30"
FROM emp;

        --�μ� ��ȣ�� 10���̸� ������ ��µǰ� �ƴϸ� NULL�� ��µǴ� ����
SELECT deptno, DECODE(deptno, 10, sal) as "10"
FROM emp;
        
         --����, ������ ��Ż ������ ����ϴµ� ���η� ����ϴ� ����
SELECT SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
FROM emp;
--ANALYST�̸� ������ ����ϰ� �� ������ SUM �Լ��� �ջ��ϸ� �ϳ��� ���� ���

        -- ���� ������ DEPTNO�� �߰�. �μ� ��ȣ���� ���� ������ ��Ż ������ ������ ���� ����
SELECT deptno, SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
FROM emp
GROUP BY deptno;
        
--048 COLUMN�� ROW�� ��� (PIVOT)
        --�μ� ��ȣ, �μ� ��ȣ�� ��Ż ������ Pivot���� ����Ͽ� ���η� ���
SELECT *
FROM (SELECT deptno, sal FROM emp)
PIVOT (sum(sal) for deptno in (10, 20, 30));
--SUM�� DECODE�� �̿��� ����� ����� PIVOT���� �̿��ϸ� ���� ������ ���������� ����� �� ����..

        -- PIVOT���� �̿��ؼ� ������ ������ ��Ż ������ ���η� ����ϴ� ����
SELECT *
FROM (select job, sal from emp)
PIVOT (sum(sal) for job in ('ANALYST', 'CLERK', 'MANAGER', 'SALESMAN'));
--PIVOT���� ����� ���� FROM���� ��ȣ�� ����ؼ� Ư��Į���� �����ؾ� ��
--PIVOT���� �̿��� ��Ż ���� ��� in ������ ��Ż ������ ����� ���� ����Ʈ ����. �����̼�?
SELECT *
FROM (select job, sal from emp)
PIVOT (sum(sal) for job in ('ANALYST' as "�м���", 'CLERK' as "�繫��", 'MANAGER' as "�Ŵ���", 'SALESMAN' as "�������"));

--040 ROW�� COLUMN���� ���(UNPIVOT)
        --UNPIVOT�� �̿��� Į���� �ο�� ���
SELECT *
FROM order2
UNPIVOT (�Ǽ� for ������ in (BICYCLE, CAMERA, NOTEBOOK));

SELECT *
FROM order2;
--UNPIVOT���� PIVOT ������ �ݴ�� ���� ������ ���

SELECT *
FROM order2
UNPIVOT (�Ǽ� for ������ in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));

UPDATE order2 set NOTEBOOK=NULL WHERE ename='SMITH';
--NULL������ ������Ʈ ������
SELECT *
FROM order2;
--smith�� notebook������ ��µ��� ����. null���� �൵ ����� ���Խ�Ű���� - include nulls�� ���.
SELECT *
FROM order2
UNPIVOT INCLUDE NULLS (�Ǽ� for ������ in (BICYCLE, CAMERA, NOTEBOOK));

--050������ �м� �Լ��� ���� ������ ���(SUM OVER)
        --������ ANALYST, MANAGER �� ������� ��� ��ȣ, �̸�, ����, ������ ����ġ�� ����ϴ� ����
SELECT empno, ename, sal, SUM(sal) over (ORDER BY empno ROWS 
                                BETWEEN unbounded preceding 
                                AND current row) ����ġ
        FROM emp
        WHERE job in ('ANALYST', 'MANAGER');
--unbounded preceding -�� ù��° ���� ����Ų��
--unbounded following -�� ������ ���� ����Ų��
--currnet row -���� ���� ����Ų��.

--051 ������ �м� �Լ��� ���� ����ϱ� (RATIO_TO_REPORT) ??
        --�μ� ��ȣ�� 20���� ������� ��� ��ȣ, �̸�, ������ ����ϰ�, 20�� �μ� ��ȣ ������ �ڽ�
        --�� ���� ������ ��� �Ǵ��� ���
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () as ����
FROM emp
WHERE deptno = 20;

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () as ����,
                            SAL/SUM(sal) OVER () as "�� ����"
            FROM emp
            WHERE deptno = 20;
            
--052 ������ �м� �Լ��� ���� ��� ���(ROLLUP)
        --����, ������ ��Ż ���� ���. �� ������ �࿡ ��Ż ���� ���
SELECT job, sum(sal)
FROM emp
GROUP BY ROLLUP(job);
--������ ������ ��Ż ������ ����ϴ� ������ ROLLUP�� �ٿ��ָ� ��ü ��Ż ������ �߰������� �� �� ����

SELECT deptno, job, sum(sal)
FROM emp
GROUP BY ROLLUP(deptno, job);

--053 ������ �м� �Լ��� ���� ��� ���(CUBE)
        --����, ������ ��Ż ����, ù ��° �࿡ ��Ż ���� ���
SELECT job, sum(sal)
FROM emp
GROUP BY CUBE(job); --��Ż �հ԰� ����

SELECT job, sum(sal)
FROM emp
GROUP BY job; --��Ż �հ谡 ������ ����

SELECT deptno, job, sum(sal)
FROM emp
GROUP BY CUBE(deptno, job);

--054 ������ �м� �Լ��� ���� ��� ���(GROUPING SETS)
    --�μ� ��ȣ�� ����, �μ� ��ȣ�� ��Ż ���ް� ������ ��Ż ����, ��ü ��Ż ���� ���
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY GROUPING SETS((deptno), (job), ());
--GROUPING SETS�� ���� ROLLUP, CUBE���� ����� ����� �����ϱ� ����. GROUPING SETS�� �����ϰ���� Į���� ����ϸ� �״�� ��µǱ� ����.

--055 ������ �м� �Լ��� ��� ��� �ѹ���(ROW_NUMBER)
SELECT empno, ename, sal, RANK() OVER (ORDER BY sal DESC) RANK,
                          DENSE_RANK() OVER (ORDER BY sal DESC) DENSE_RANK,
                          ROW_NUMBER() OVER (ORDER BY sal DESC) ��ȣ
        FROM emp
        WHERE deptno = 20;

--ROW_NUMBER()�Լ��� over ���� ��ȣ �ȿ� �ݵ�� ORDER BY���� ����ؾ� �Ѵ�.        
/*SELECT empno, ename, sal, ROW_NUMBER() OVER () ��ȣ
FROM emp
WHERE deptno = 20; */ -- ����

        --�μ� ��ȣ���� ���޿� ���� ������ ����ϴ� ����.
SELECT deptno, ename, sal, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) ��ȣ
FROM emp
WHERE deptno in (10, 20);

