-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (2, NULL);

INSERT INTO "departments" ("id", "name") VALUES (5, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (6, 'dep_4ca018');

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 's_s_790cb2', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483647, 's_s_6c3845', 6);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483646, 's_s_6c3845', 6);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483645, 's_s_6c3845', 6);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483644, 's_s_6c3845', 6);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483643, 's_s_6c3845', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483642, 's_s_6c3845', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483641, 's_s_6c3845', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483640, 's_s_6c3845', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.ID, S.NAME FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID WHERE D.NAME IS NULL ORDER BY S.DEPARTMENT_ID ASC, S.id NULLS LAST, D.id NULLS LAST;

/*
Prediction Result:
(-2147483643, 's_s_6c3845')
(-2147483642, 's_s_6c3845')
(-2147483641, 's_s_6c3845')
(-2147483640, 's_s_6c3845')
(1, 's_s_790cb2')
*/