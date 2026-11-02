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
INSERT INTO EMPLOYEES VALUES (1, NULL);
INSERT INTO EMPLOYEES VALUES (0, 14);
INSERT INTO EMPLOYEEUNI VALUES (0, 0);
INSERT INTO EMPLOYEEUNI VALUES (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(None, None)
(0, '14')
(1, '14')
*/

-- Prediction Query
SELECT UNIQUE_ID, (NAME) AS NAME FROM EMPLOYEES AS E LEFT JOIN EMPLOYEEUNI AS U ON E.ID = U.ID GROUP BY E.ID;

/*
Prediction Result:
(0, '14')
(None, None)
*/