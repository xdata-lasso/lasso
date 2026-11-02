-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1024, 'Victoria Wyatt', 'Mississippi', 1025.5);
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1026, 'Edward Fuller', 'Iowa', 1026.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "head" WHERE ("born_state" <> 'California') ORDER BY name, head.head_id NULLS LAST;

/*
Gold Result:
('Edward Fuller',)
('Victoria Wyatt',)
*/

-- Prediction Query
SELECT name FROM head WHERE born_state <> 'California';

/*
Prediction Result:
('Victoria Wyatt',)
('Edward Fuller',)
*/