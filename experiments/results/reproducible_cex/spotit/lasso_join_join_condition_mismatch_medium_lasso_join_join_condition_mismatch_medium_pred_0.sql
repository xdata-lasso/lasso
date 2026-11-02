-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "ID" INT,
    "NAME" TEXT,
    "DEPARTMENT_ID" INT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "DEPARTMENTS"("ID")
);
CREATE TABLE "DEPARTMENTS" (
    "ID" INT,
    "NAME" TEXT,
    "MANAGER_ID" INT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (-1, 9, 0);
INSERT INTO EMPLOYEES VALUES (0, 11, 0);
INSERT INTO DEPARTMENTS VALUES (1, 10, 1);
INSERT INTO DEPARTMENTS VALUES (0, 12, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
('9', '12')
('11', '12')
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.id = d.manager_id;

/*
Prediction Result:
*/