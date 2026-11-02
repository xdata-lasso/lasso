-- Schema DDL
CREATE TABLE "SALES" (
    "ID" INT,
    "DEPARTMENT" TEXT,
    "EMPLOYEE_ID" INT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SALES VALUES (0, NULL, 0);
INSERT INTO SALES VALUES (1, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department, COUNT(DISTINCT employee_id) FROM sales GROUP BY department;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT department, COUNT(employee_id) FROM sales GROUP BY department;

/*
Prediction Result:
(None, 2)
*/