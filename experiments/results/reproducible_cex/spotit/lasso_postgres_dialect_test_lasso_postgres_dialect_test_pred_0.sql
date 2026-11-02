-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "EMP_ID" INT,
    "NAME" TEXT NOT NULL,
    "DEPARTMENT" TEXT,
    "SALARY" FLOAT,
    PRIMARY KEY ("EMP_ID"),
    CHECK (salary > 0)
);
CREATE TABLE "PROJECTS" (
    "PROJECT_ID" INT,
    "TITLE" TEXT NOT NULL,
    "LEAD_ID" INT,
    PRIMARY KEY ("PROJECT_ID"),
    FOREIGN KEY ("LEAD_ID") REFERENCES "EMPLOYEES"("EMP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (1, 0, 0, 1);
INSERT INTO EMPLOYEES VALUES (0, 0, 0, 50000);
INSERT INTO PROJECTS VALUES (0, 0, 1);
INSERT INTO PROJECTS VALUES (1, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_id, name FROM employees WHERE salary > 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT emp_id, name FROM employees;

/*
Prediction Result:
(1, '0')
(0, '0')
*/