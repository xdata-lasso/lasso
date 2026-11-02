DELETE FROM BONUS;
DELETE FROM EMP_B;
DELETE FROM EMPNULLABLES_20;
DELETE FROM EMPNULLABLES;
DELETE FROM EMP;
DELETE FROM DEPT;

-- DEPT
insert into DEPT values (10, 'Sales');
insert into DEPT values (20, 'Research');
insert into DEPT values (30, 'Accounting');
insert into DEPT values (40, 'Operations');
insert into DEPT values (50, 'HR');
insert into DEPT values (60, 'IT');
insert into DEPT values (70, 'Marketing');
insert into DEPT values (80, 'Finance');
insert into DEPT values (90, 'Support');
insert into DEPT values (100, 'Legal');

-- EMP
insert into EMP values (1001,10,'SMITH','CLERK',7902,'2020-01-15',3000,200,true);
insert into EMP values (1002,20,'ALLEN','SALESMAN',7698,'2019-03-11',4500,300,false);
insert into EMP values (1003,30,'WARD','SALESMAN',7698,'2018-07-19',4200,250,true);
insert into EMP values (1004,40,'JONES','MANAGER',7839,'2017-10-01',6000,0,false);
insert into EMP values (1005,50,'MARTIN','ANALYST',7566,'2021-02-28',5200,100,true);
insert into EMP values (1006,60,'BLAKE','MANAGER',7839,'2016-06-14',7000,0,false);
insert into EMP values (1007,70,'CLARK','CLERK',7782,'2022-08-09',3100,150,true);
insert into EMP values (1008,80,'SCOTT','ANALYST',7566,'2019-12-05',6500,0,false);
insert into EMP values (1009,90,'KING','PRESIDENT',null,'2015-04-17',9000,0,false);
insert into EMP values (1010,100,'TURNER','SALESMAN',7698,'2023-01-01',3900,180,true);

-- BONUS
insert into BONUS values ('SMITH','CLERK',3000,200);
insert into BONUS values ('ALLEN','SALESMAN',4500,300);
insert into BONUS values ('WARD','SALESMAN',4200,250);
insert into BONUS values ('JONES','MANAGER',6000,0);
insert into BONUS values ('MARTIN','ANALYST',5200,100);
insert into BONUS values ('BLAKE','MANAGER',7000,0);
insert into BONUS values ('CLARK','CLERK',3100,150);
insert into BONUS values ('SCOTT','ANALYST',6500,0);
insert into BONUS values ('KING','PRESIDENT',9000,0);
insert into BONUS values ('TURNER','SALESMAN',3900,180);

-- EMPNULLABLES
insert into EMPNULLABLES values (2001,10,'ADAMS','CLERK',7902,'2021-01-10',2800,100,true);
insert into EMPNULLABLES values (2002,20,'FORD','ANALYST',7566,'2020-05-20',5500,0,false);
insert into EMPNULLABLES values (2003,30,null,'SALESMAN',7698,'2019-03-03',4000,200,true);
insert into EMPNULLABLES values (2004,null,'JAMES','CLERK',7788,'2022-07-15',2500,null,false);
insert into EMPNULLABLES values (2005,50,'MILLER',null,null,null,null,null,null);
insert into EMPNULLABLES values (2006,60,'GREEN','MANAGER',7839,'2018-09-09',7200,0,true);
insert into EMPNULLABLES values (2007,70,'WHITE','ANALYST',7566,'2021-12-12',5100,100,false);
insert into EMPNULLABLES values (2008,80,'BLACK','CLERK',7902,'2023-04-04',2900,120,true);
insert into EMPNULLABLES values (2009,90,'YOUNG','SALESMAN',7698,'2020-08-18',4100,220,false);
insert into EMPNULLABLES values (2010,100,'HALL','LAWYER',null,'2017-11-11',8000,0,true);

-- EMPNULLABLES_20
insert into EMPNULLABLES_20 values (3001,10,'A','CLERK',7902,'2020-01-01',3000,100,true);
insert into EMPNULLABLES_20 values (3002,20,'B','MANAGER',7839,'2020-02-01',7000,0,false);
insert into EMPNULLABLES_20 values (3003,30,'C','ANALYST',7566,'2020-03-01',6000,50,true);
insert into EMPNULLABLES_20 values (3004,40,'D','SALESMAN',7698,'2020-04-01',4000,300,false);
insert into EMPNULLABLES_20 values (3005,50,'E','HR',null,'2020-05-01',4500,0,true);
insert into EMPNULLABLES_20 values (3006,60,'F','ENGINEER',7839,'2020-06-01',6500,0,false);
insert into EMPNULLABLES_20 values (3007,70,'G','CLERK',7902,'2020-07-01',3100,120,true);
insert into EMPNULLABLES_20 values (3008,80,'H','ACCOUNTANT',7782,'2020-08-01',5200,80,false);
insert into EMPNULLABLES_20 values (3009,90,'I','SUPPORT',7788,'2020-09-01',3300,50,true);
insert into EMPNULLABLES_20 values (3010,100,'J','LAWYER',null,'2020-10-01',8500,0,false);

-- EMP_B
insert into EMP_B values (4001,10,'SMITH','CLERK',7902,'2020-01-15',3000,200,true,'1990-03-15');
insert into EMP_B values (4002,20,'ALLEN','SALESMAN',7698,'2019-03-11',4500,300,false,'1989-08-12');
insert into EMP_B values (4003,30,'WARD','SALESMAN',7698,'2018-07-19',4200,250,true,'1991-01-21');
insert into EMP_B values (4004,40,'JONES','MANAGER',7839,'2017-10-01',6000,0,false,'1985-09-10');
insert into EMP_B values (4005,50,'MARTIN','ANALYST',7566,'2021-02-28',5200,100,true,'1992-06-18');
insert into EMP_B values (4006,60,'BLAKE','MANAGER',7839,'2016-06-14',7000,0,false,'1983-12-01');
insert into EMP_B values (4007,70,'CLARK','CLERK',7782,'2022-08-09',3100,150,true,'1994-11-23');
insert into EMP_B values (4008,80,'SCOTT','ANALYST',7566,'2019-12-05',6500,0,false,'1988-04-30');
insert into EMP_B values (4009,90,'KING','PRESIDENT',null,'2015-04-17',9000,0,false,'1978-02-14');
insert into EMP_B values (4010,100,'TURNER','SALESMAN',7698,'2023-01-01',3900,180,true,'1995-07-07');