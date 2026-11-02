-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "EMPLOYEE_ID" INT,
    "DEPARTMENT_ID" INT,
    "PRIMARY_FLAG" TEXT,
    PRIMARY KEY ("EMPLOYEE_ID", "DEPARTMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (0, 1, NULL);
INSERT INTO EMPLOYEE VALUES (0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT E.EMPLOYEE_ID, COALESCE(E1.DEPARTMENT_ID, E.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN EMPLOYEE AS E1 ON E.EMPLOYEE_ID = E1.EMPLOYEE_ID AND E.PRIMARY_FLAG = 'N' AND E1.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(0, 0)
(0, 1)
*/