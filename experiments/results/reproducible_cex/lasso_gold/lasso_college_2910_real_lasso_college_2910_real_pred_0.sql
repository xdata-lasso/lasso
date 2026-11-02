-- Schema DDL
CREATE TABLE EMPLOYEE (EMP_NUM INTEGER PRIMARY KEY, EMP_LNAME TEXT(15), EMP_FNAME TEXT(12), EMP_INITIAL TEXT(1), EMP_JOBCODE TEXT(5), EMP_HIREDATE INTEGER, EMP_DOB INTEGER);

CREATE TABLE DEPARTMENT (DEPT_CODE TEXT(10) PRIMARY KEY, EMP_NUM INTEGER, DEPT_NAME TEXT(30), SCHOOL_CODE TEXT(8), DEPT_ADDRESS TEXT(20), DEPT_EXTENSION TEXT(4), FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEE (EMP_NUM));

CREATE TABLE PROFESSOR (DEPT_CODE TEXT(10), EMP_NUM INTEGER, PROF_OFFICE TEXT(50), PROF_EXTENSION TEXT(4), PROF_HIGH_DEGREE TEXT(5), FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_CODE), FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEE (EMP_NUM));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1102, 'Hensley', 'Danny', 'attention', 'Oncologist', 1103, 1104);
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('million', 0, 'History', 'back', '29413 Angela Mall
Port Alexandra, NV 58529', 'finish');
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('million', 1102, 'trade', 'per', 'Ph.D.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LHS.emp_fname, RHS.prof_office FROM (SELECT LHS.dept_code, LHS.dept_name, LHS.school_code, LHS.emp_num, LHS.dept_address, LHS.dept_extension, RHS.emp_lname, RHS.emp_fname, RHS.emp_initial, RHS.emp_jobcode, RHS.emp_hiredate, RHS.emp_dob FROM DEPARTMENT AS LHS INNER JOIN EMPLOYEE AS RHS ON LHS.emp_num = RHS.emp_num) AS LHS INNER JOIN PROFESSOR AS RHS ON LHS.dept_code = RHS.dept_code AND LHS.emp_num = RHS.emp_num WHERE dept_name = 'History' AND prof_high_degree = 'Ph.D.';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.emp_fname, T2.prof_office FROM EMPLOYEE AS T1 JOIN PROFESSOR AS T2 ON T1.emp_num = T2.emp_num JOIN DEPARTMENT AS T3 ON T3.dept_code = T2.dept_code WHERE T3.dept_name = 'History' AND T2.prof_high_degree = 'Ph.D.';

/*
Prediction Result:
('Danny', 'trade')
*/