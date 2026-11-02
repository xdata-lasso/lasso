-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, department TEXT, employee_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sales --
INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483648, 'sal_e8e1dd', 1);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483647, 'sal_e8e1dd', 1);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483646, 'sal_e8e1dd', 1);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (2, 'sal_e8e1dd', 1);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (3, 'sal_e8e1dd', 1);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483645, 'sal_e8e1dd', 1);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483642, 'sal_e8e1dd', NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483641, 'sal_e8e1dd', NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483640, 'sal_e8e1dd', NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483639, NULL, NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483638, NULL, NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483637, NULL, NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483636, 'sal_e8e1dd', NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483635, 'sal_e8e1dd', NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483634, 'sal_e8e1dd', NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483633, 'sal_e8e1dd', NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483632, 'sal_e8e1dd', NULL);

INSERT INTO "sales" ("id", "department", "employee_id") VALUES (-2147483631, 'sal_e8e1dd', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department, COUNT(DISTINCT employee_id) FROM sales GROUP BY department;

/*
Gold Result:
(None, 0)
('sal_e8e1dd', 1)
*/

-- Prediction Query
SELECT department, COUNT(employee_id) FROM sales GROUP BY department;

/*
Prediction Result:
(None, 0)
('sal_e8e1dd', 6)
*/