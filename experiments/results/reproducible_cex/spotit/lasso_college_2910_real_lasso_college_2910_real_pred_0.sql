-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "EMP_NUM" INT,
    "EMP_LNAME" TEXT,
    "EMP_FNAME" TEXT,
    "EMP_INITIAL" TEXT,
    "EMP_JOBCODE" TEXT,
    "EMP_HIREDATE" INT,
    "EMP_DOB" INT,
    PRIMARY KEY ("EMP_NUM")
);
CREATE TABLE "DEPARTMENT" (
    "DEPT_CODE" TEXT,
    "EMP_NUM" INT,
    "DEPT_NAME" TEXT,
    "SCHOOL_CODE" TEXT,
    "DEPT_ADDRESS" TEXT,
    "DEPT_EXTENSION" TEXT,
    PRIMARY KEY ("DEPT_CODE"),
    FOREIGN KEY ("EMP_NUM") REFERENCES "EMPLOYEE"("EMP_NUM")
);
CREATE TABLE "PROFESSOR" (
    "DEPT_CODE" TEXT,
    "EMP_NUM" INT,
    "PROF_OFFICE" TEXT,
    "PROF_EXTENSION" TEXT,
    "PROF_HIGH_DEGREE" TEXT,
    FOREIGN KEY ("DEPT_CODE") REFERENCES "DEPARTMENT"("DEPT_CODE"),
    FOREIGN KEY ("EMP_NUM") REFERENCES "EMPLOYEE"("EMP_NUM")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (0, 20, 21, 22, 23, 0, 0);
INSERT INTO EMPLOYEE VALUES (1, 24, 25, 26, 27, 0, 0);
INSERT INTO DEPARTMENT VALUES (4, 0, 1641431194474334770, 11, 12, 13);
INSERT INTO DEPARTMENT VALUES (7, 1, 1641431194474334770, 14, 15, 16);
INSERT INTO PROFESSOR VALUES (4, 0, 10, 17, 7338255504089421546);
INSERT INTO PROFESSOR VALUES (7, 0, 18, 19, 7338255504089421546);
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
*/