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
INSERT INTO EMPLOYEES VALUES (0, 6, 0);
INSERT INTO EMPLOYEES VALUES (-1, 8, 0);
INSERT INTO DEPARTMENTS VALUES (0, 7, 0);
INSERT INTO DEPARTMENTS VALUES (-1, 9, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
('6', '7')
('8', '7')
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
('6', '7')
('6', '9')
('8', '7')
('8', '9')
*/