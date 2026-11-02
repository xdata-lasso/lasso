-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "ID" INT,
    "NAME" TEXT,
    "DEPARTMENT_ID" TEXT,
    "SALARY" FLOAT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (-1, 4, 2217997555952161820, 0);
INSERT INTO EMPLOYEE VALUES (0, 5, 2217997555952161820, 8366);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
*/