-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (1, 'John Doe', 'California', 45.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (2, 'Alice Smith', 'Texas', 50.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (3, 'Bob Jones', 'Alabama', 38.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (4, 'Alice Smith', 'New York', 60.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (5, 'Charlie Brown', NULL, 55.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "head" WHERE ("born_state" <> 'California') ORDER BY name, head.head_id NULLS LAST;

/*
Gold Result:
('Alice Smith',)
('Alice Smith',)
('Bob Jones',)
*/

-- Prediction Query
SELECT name FROM head WHERE born_state <> 'California';

/*
Prediction Result:
('Alice Smith',)
('Bob Jones',)
('Alice Smith',)
*/