-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1006, 'Kimberly Robinson', 'Indiana', 1007.5);
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1008, 'Javier Johnson', 'Virginia', 1008.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, born_state, age FROM head ORDER BY name, head.head_id NULLS LAST;

/*
Gold Result:
('Javier Johnson', 'Virginia', 1008.5)
('Kimberly Robinson', 'Indiana', 1007.5)
*/

-- Prediction Query
SELECT name, born_state, age FROM head ORDER BY age, head.head_id NULLS LAST;

/*
Prediction Result:
('Kimberly Robinson', 'Indiana', 1007.5)
('Javier Johnson', 'Virginia', 1008.5)
*/