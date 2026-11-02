-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (1, 'HR', '1990', 1, 1.5, 100.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (2, 'IT', '2000', 2, 2.5, 200.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (3, 'Sales', '1980', 3, 3.5, 300.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (1, 'Alice', 'CA', 55.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (2, 'Bob', 'NY', 42.5);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (3, 'Charlie', 'TX', 60.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (4, 'David', 'FL', 38.0);
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (1, 1, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (2, 2, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (3, 3, 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "age" FROM (SELECT "LHS"."head_id" AS "head_id", "LHS"."name" AS "name", "LHS"."born_state" AS "born_state", "LHS"."age" AS "age", "RHS"."department_id" AS "department_id", "RHS"."temporary_acting" AS "temporary_acting" FROM "head" AS "LHS" INNER JOIN "management" AS "RHS" ON ("LHS"."head_id" = "RHS"."head_id")) WHERE ("temporary_acting" = 'Yes') ORDER BY age, "age" NULLS LAST;

/*
Gold Result:
(42.5,)
(55.0,)
*/

-- Prediction Query
SELECT DISTINCT T1.age FROM management AS T2 JOIN head AS T1 ON T1.head_id = T2.head_id WHERE T2.temporary_acting = 'Yes';

/*
Prediction Result:
(55.0,)
(42.5,)
*/