-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "EMPLOYEEUNI" (
    "ID" INT,
    "UNIQUE_ID" INT,
    PRIMARY KEY ("ID", "UNIQUE_ID"),
    FOREIGN KEY ("ID") REFERENCES "EMPLOYEES"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (0, 7);
INSERT INTO EMPLOYEES VALUES (1, 10);
INSERT INTO EMPLOYEEUNI VALUES (0, 0);
INSERT INTO EMPLOYEEUNI VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(0, '7')
(1, '10')
*/

-- Prediction Query
SELECT NAME, UNIQUE_ID FROM EMPLOYEEUNI AS UNI RIGHT JOIN EMPLOYEES AS E ON UNI.ID = E.ID;

-- Execution Error:
-- Prediction execution error: RIGHT and FULL OUTER JOINs are not currently supported