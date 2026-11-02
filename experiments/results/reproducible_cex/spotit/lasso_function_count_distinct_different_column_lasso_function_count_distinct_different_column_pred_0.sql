-- Schema DDL
CREATE TABLE "DEPARTMENTS" (
    "DEPT_ID" INT,
    "DEPT_NAME" TEXT NOT NULL,
    "LOCATION" TEXT,
    "MANAGER_NAME" TEXT,
    PRIMARY KEY ("DEPT_ID")
);
CREATE TABLE "EMPLOYEES" (
    "EMP_ID" INT,
    "EMP_NAME" TEXT,
    "DEPT_ID" INT,
    "ROLE" TEXT,
    PRIMARY KEY ("EMP_ID"),
    FOREIGN KEY ("DEPT_ID") REFERENCES "DEPARTMENTS"("DEPT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DEPARTMENTS VALUES (1, 10, 11, 12);
INSERT INTO DEPARTMENTS VALUES (0, 15, 5794299357740465354, 16);
INSERT INTO EMPLOYEES VALUES (0, 13, 0, 14);
INSERT INTO EMPLOYEES VALUES (1, 17, 0, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.role) FROM departments AS T1 INNER JOIN employees AS T2 ON T1.dept_id = T2.dept_id WHERE T1.location = 'NYC';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.emp_id) FROM departments AS T1 INNER JOIN employees AS T2 ON T1.dept_id = T2.dept_id WHERE T1.location = 'NYC';

/*
Prediction Result:
(0,)
*/