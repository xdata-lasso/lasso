-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (-1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (6, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (3, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (0, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 's_s_bf16d5', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483647, 's_s_e42865', 3);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483646, 's_s_e42865', 3);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483645, 's_s_e42865', 3);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483644, 's_s_e42865', 3);

INSERT INTO "students" ("id", "name", "department_id") VALUES (2, 's_s_bf16d5', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.ID, S.NAME FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID WHERE D.NAME IS NULL ORDER BY S.ID, D.id NULLS LAST;

/*
Prediction Result:
(1, 's_s_bf16d5')
(2, 's_s_bf16d5')
*/