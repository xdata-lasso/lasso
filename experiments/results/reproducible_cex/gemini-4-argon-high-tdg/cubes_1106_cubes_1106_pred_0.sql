-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (10, 'Finance', '1990', 1, 10.5, 100.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (20, 'Human Resources', '2000', 2, 5.0, 50.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (1, 'Zack', 'Texas', 50.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (2, 'Alice', 'Alabama', 40.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (3, 'Bob', 'California', 45.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (4, 'Alice', 'New York', 35.0);
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (10, 1, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (20, 1, 'No');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (10, 3, 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "head" WHERE ("born_state" <> 'California') ORDER BY name, head.head_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM head WHERE born_state <> 'California';

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/