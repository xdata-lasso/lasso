-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "EMPLOYEE_ID" INT,
    "DEPARTMENT_ID" INT,
    "PRIMARY_FLAG" TEXT,
    PRIMARY KEY ("EMPLOYEE_ID", "DEPARTMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (0, 0, NULL);
INSERT INTO EMPLOYEE VALUES (0, -1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, A.DEPARTMENT_ID FROM EMPLOYEE AS A INNER JOIN (SELECT EMPLOYEE_ID, COUNT(DISTINCT PRIMARY_FLAG) AS CN FROM EMPLOYEE GROUP BY EMPLOYEE_ID) AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID WHERE (B.CN = 1) OR (B.CN > 1 AND PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(0, -1)
(0, 0)
*/