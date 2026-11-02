-- Schema DDL
CREATE TABLE "DEPARTMENT" (
    "DEPT_NAME" TEXT,
    "BUILDING" INT
);
CREATE TABLE "STUDENT" (
    "STUDENT_ID" INT,
    "DEPT_NAME" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DEPARTMENT VALUES (5, 0);
INSERT INTO DEPARTMENT VALUES (4, 0);
INSERT INTO STUDENT VALUES (0, 4);
INSERT INTO STUDENT VALUES (0, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student.student_id FROM department NATURAL JOIN student GROUP BY student.student_id, student.dept_name HAVING COUNT(dept_name) >= 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT student.student_id FROM department NATURAL JOIN student GROUP BY student.student_id HAVING COUNT(dept_name) >= 2;

/*
Prediction Result:
(0,)
*/