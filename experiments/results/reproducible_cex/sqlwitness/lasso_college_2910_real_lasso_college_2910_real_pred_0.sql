-- Schema DDL
CREATE TABLE EMPLOYEE (EMP_NUM INTEGER PRIMARY KEY, EMP_LNAME TEXT(15), EMP_FNAME TEXT(12), EMP_INITIAL TEXT(1), EMP_JOBCODE TEXT(5), EMP_HIREDATE INTEGER, EMP_DOB INTEGER);

CREATE TABLE DEPARTMENT (DEPT_CODE TEXT(10) PRIMARY KEY, EMP_NUM INTEGER, DEPT_NAME TEXT(30), SCHOOL_CODE TEXT(8), DEPT_ADDRESS TEXT(20), DEPT_EXTENSION TEXT(4), FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEE (EMP_NUM));

CREATE TABLE PROFESSOR (DEPT_CODE TEXT(10), EMP_NUM INTEGER, PROF_OFFICE TEXT(50), PROF_EXTENSION TEXT(4), PROF_HIGH_DEGREE TEXT(5), FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_CODE), FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEE (EMP_NUM));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (emp_num, emp_lname, emp_fname, emp_initial, emp_jobcode, emp_hiredate, emp_dob) VALUES (1, 'default1', 'History', 'Ph.D.', 'Ph.D.', NULL, NULL), (0, 'default1', 'History', 'default2', 'default2', NULL, 0), (2, 'default2', 'History', 'History', 'Ph.D.', NULL, 0), (3, NULL, NULL, NULL, NULL, NULL, 1), (4, 'default2', NULL, 'Ph.D.', 'default1', 1, 0), (5, NULL, NULL, 'default2', 'History', NULL, 1), (6, 'default1', 'default1', NULL, 'History', 0, NULL), (7, 'History', NULL, 'default1', 'default1', 1, NULL), (8, NULL, 'default2', NULL, NULL, NULL, NULL), (9, 'History', 'Ph.D.', 'default2', 'default2', 1, NULL), (10, NULL, 'History', 'default2', NULL, 1, NULL), (11, 'default2', 'Ph.D.', 'History', 'Ph.D.', 1, 0);
INSERT INTO department (dept_code, emp_num, dept_name, school_code, dept_address, dept_extension) VALUES ('History', 3, NULL, 'History', 'default2', 'History'), ('default2', 2, 'History', 'default2', 'History', 'default1'), ('default1', 4, 'default2', NULL, 'History', 'default1'), ('Ph.D.', 11, NULL, 'default2', 'default1', 'History'), ('unique_4', 10, 'History', 'default2', 'Ph.D.', 'History'), ('unique_5', 11, NULL, 'History', 'Ph.D.', 'default2'), ('unique_6', 8, NULL, 'Ph.D.', 'default2', 'default1'), ('unique_7', 10, 'History', 'Ph.D.', 'default2', 'default1'), ('unique_8', 3, 'History', NULL, 'Ph.D.', 'default2'), ('unique_9', 5, 'Ph.D.', 'History', 'Ph.D.', 'Ph.D.'), ('unique_10', 11, 'History', 'Ph.D.', 'Ph.D.', 'History'), ('unique_11', 9, 'default1', 'default1', 'Ph.D.', NULL), ('unique_12', 11, 'default2', 'default2', 'Ph.D.', 'Ph.D.');
INSERT INTO professor (dept_code, emp_num, prof_office, prof_extension, prof_high_degree) VALUES ('History', 5, NULL, 'default2', NULL), ('unique_12', 6, 'default2', 'default1', 'History'), ('unique_6', 3, 'History', NULL, 'default2'), (NULL, NULL, 'History', 'default1', 'default1'), ('unique_7', 8, 'Ph.D.', 'Ph.D.', 'Ph.D.'), ('unique_10', 6, 'default1', 'default2', 'Ph.D.'), ('unique_5', 7, 'default2', NULL, NULL), ('unique_12', 2, 'default1', 'default1', NULL), ('unique_8', 8, NULL, 'default2', 'default2'), ('default1', 2, 'History', NULL, 'default2'), ('unique_7', 7, 'Ph.D.', 'default1', NULL), ('Ph.D.', 3, 'Ph.D.', 'Ph.D.', 'Ph.D.'), ('unique_5', 2, 'default2', 'default1', 'default1'), ('unique_8', 2, NULL, 'History', 'default1'), ('unique_11', 10, NULL, 'History', 'default1'), ('unique_12', 8, 'default2', 'default1', 'Ph.D.'), ('History', 2, 'default1', 'History', 'Ph.D.');
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
('default2', 'Ph.D.')
('default1', 'default1')
*/