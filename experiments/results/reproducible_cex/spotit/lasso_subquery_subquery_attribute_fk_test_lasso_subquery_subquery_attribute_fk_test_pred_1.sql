-- Schema DDL
CREATE TABLE "DEPARTMENTS" (
    "DEPT_ID" INT,
    "NAME" TEXT NOT NULL,
    "BUILDING" TEXT NOT NULL,
    PRIMARY KEY ("DEPT_ID")
);
CREATE TABLE "EMPLOYEES" (
    "EMP_ID" INT,
    "DEPT_ID" INT NOT NULL,
    "NAME" TEXT NOT NULL,
    "SALARY" INT NOT NULL,
    PRIMARY KEY ("EMP_ID"),
    FOREIGN KEY ("DEPT_ID") REFERENCES "DEPARTMENTS"("DEPT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DEPARTMENTS VALUES (0, 0, 0);
INSERT INTO DEPARTMENTS VALUES (1, 0, 0);
INSERT INTO EMPLOYEES VALUES (-2, 0, 0, 50001);
INSERT INTO EMPLOYEES VALUES (-1, 1, 0, 50001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM departments WHERE dept_id IN (SELECT dept_id FROM employees WHERE salary > 50000);

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT name FROM departments WHERE dept_id IN (SELECT emp_id FROM employees WHERE salary > 50000);

/*
Prediction Result:
*/