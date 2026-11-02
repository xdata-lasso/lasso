create table DEPT
	(DEPTNO		int,
	 NAME		varchar(255) not null,
	 primary key (DEPTNO)
	);

create table EMP
	(EMPNO		int,
	 DEPTNO		int not null,
	 ENAME		varchar(255) not null,
	 JOB		varchar(255) not null,
	 MGR		int,
	 HIREDATE	date not null,
	 SAL		int not null,
	 COMM		int not null,
	 SLACKER	boolean not null,
	 primary key (EMPNO),
	 foreign key (DEPTNO) references DEPT (DEPTNO)
	);

create table BONUS
	(ENAME		varchar(255) not null,
	 JOB		varchar(255) not null,
	 SAL		int not null,
	 COMM		int not null
	);

create table EMPNULLABLES
	(EMPNO		int,
	 DEPTNO		int,
	 ENAME		varchar(255),
	 JOB		varchar(255),
	 MGR		int,
	 HIREDATE	date,
	 SAL		int,
	 COMM		int,
	 SLACKER	boolean,
	 primary key (EMPNO),
	 foreign key (DEPTNO) references DEPT (DEPTNO)
	);

create table EMPNULLABLES_20
	(EMPNO		int,
	 DEPTNO		int,
	 ENAME		varchar(255),
	 JOB		varchar(255),
	 MGR		int,
	 HIREDATE	date,
	 SAL		int,
	 COMM		int,
	 SLACKER	boolean,
	 primary key (EMPNO),
	 foreign key (DEPTNO) references DEPT (DEPTNO)
	);

create table EMP_B
	(EMPNO		int,
	 DEPTNO		int not null,
	 ENAME		varchar(255) not null,
	 JOB		varchar(255) not null,
	 MGR		int,
	 HIREDATE	date not null,
	 SAL		int not null,
	 COMM		int not null,
	 SLACKER	boolean not null,
	 BIRTHDATE	date not null,
	 primary key (EMPNO),
	 foreign key (DEPTNO) references DEPT (DEPTNO)
	);