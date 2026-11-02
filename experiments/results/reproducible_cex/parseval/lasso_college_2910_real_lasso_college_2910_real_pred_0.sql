-- Schema DDL
CREATE TABLE EMPLOYEE (EMP_NUM INTEGER PRIMARY KEY, EMP_LNAME TEXT(15), EMP_FNAME TEXT(12), EMP_INITIAL TEXT(1), EMP_JOBCODE TEXT(5), EMP_HIREDATE INTEGER, EMP_DOB INTEGER);

CREATE TABLE DEPARTMENT (DEPT_CODE TEXT(10) PRIMARY KEY, EMP_NUM INTEGER, DEPT_NAME TEXT(30), SCHOOL_CODE TEXT(8), DEPT_ADDRESS TEXT(20), DEPT_EXTENSION TEXT(4), FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEE (EMP_NUM));

CREATE TABLE PROFESSOR (DEPT_CODE TEXT(10), EMP_NUM INTEGER, PROF_OFFICE TEXT(50), PROF_EXTENSION TEXT(4), PROF_HIGH_DEGREE TEXT(5), FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_CODE), FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEE (EMP_NUM));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1, 'rhs_35a7e0', 'rhs_c68efa', 'rhs_c83e0c', 'rhs_c077c6', 1, 1);

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483647, 'rhs_d91325', 'rhs_e9c178', 'rhs_ad857d', 'rhs_1cd975', 1, 1);

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (2, 'rhs_35a7e0', 'rhs_c68efa', 'rhs_c83e0c', 'rhs_c077c6', 1, 1);

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (3, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', -55602865, -59984348);

-- Inserting into table: department --
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_701d33', 1, 'History', 'lhs_f97d09', 'lhs_8bdfda', 'lhs_26f86a');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_b9c0d4', 1, 'History', 'lhs_0baa0e', 'lhs_febec2', 'lhs_bab10f');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_3', 1, 'History', 'lhs_0baa0e', 'lhs_febec2', 'lhs_bab10f');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_4', 1, 'History', 'lhs_0baa0e', 'lhs_febec2', 'lhs_bab10f');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_5', 1, 'History', 'lhs_0baa0e', 'lhs_febec2', 'lhs_bab10f');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_6', 1, 'History', 'lhs_0baa0e', 'lhs_febec2', 'lhs_bab10f');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_7', 1, 'History', 'lhs_0baa0e', 'lhs_febec2', 'lhs_bab10f');

-- Inserting into table: professor --
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 3, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 3, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 3, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 3, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 3, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'value', 'rhs_c3a0bc');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, 'rhs_b941c8', 'f495', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_701d33', 1, NULL, 'f495', 'Ph.D.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LHS.emp_fname, RHS.prof_office FROM (SELECT LHS.dept_code, LHS.dept_name, LHS.school_code, LHS.emp_num, LHS.dept_address, LHS.dept_extension, RHS.emp_lname, RHS.emp_fname, RHS.emp_initial, RHS.emp_jobcode, RHS.emp_hiredate, RHS.emp_dob FROM DEPARTMENT AS LHS INNER JOIN EMPLOYEE AS RHS ON LHS.emp_num = RHS.emp_num) AS LHS INNER JOIN PROFESSOR AS RHS ON LHS.dept_code = RHS.dept_code AND LHS.emp_num = RHS.emp_num WHERE dept_name = 'History' AND prof_high_degree = 'Ph.D.';

/*
Gold Result:
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', None)
*/

-- Prediction Query
SELECT T1.emp_fname, T2.prof_office FROM EMPLOYEE AS T1 JOIN PROFESSOR AS T2 ON T1.emp_num = T2.emp_num JOIN DEPARTMENT AS T3 ON T3.dept_code = T2.dept_code WHERE T3.dept_name = 'History' AND T2.prof_high_degree = 'Ph.D.';

/*
Prediction Result:
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('emp_d05cb6', 'rhs_b941c8')
('emp_d05cb6', 'rhs_b941c8')
('emp_d05cb6', 'rhs_b941c8')
('emp_d05cb6', 'rhs_b941c8')
('emp_d05cb6', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', 'rhs_b941c8')
('rhs_c68efa', None)
*/