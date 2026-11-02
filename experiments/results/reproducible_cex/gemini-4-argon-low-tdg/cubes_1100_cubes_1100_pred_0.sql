-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by name ASC, secondary ordering by head_ID ASC, and exact duplicates across selected columns to catch DISTINCT or wrong ORDER BY direction.
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (10, 'Charlie', 'TX', 50.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (2, 'Alice', 'NY', 45.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (1, 'Alice', 'CA', 60.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (3, 'Alice', 'CA', 60.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (5, 'Bob', 'FL', 35.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, born_state, age FROM head ORDER BY name, head.head_id NULLS LAST;

/*
Gold Result:
('Alice', 'CA', 60.0)
('Alice', 'NY', 45.0)
('Alice', 'CA', 60.0)
('Bob', 'FL', 35.0)
('Charlie', 'TX', 50.0)
*/

-- Prediction Query
SELECT name, born_state, age FROM head ORDER BY age, head.head_id NULLS LAST;

/*
Prediction Result:
('Bob', 'FL', 35.0)
('Alice', 'NY', 45.0)
('Charlie', 'TX', 50.0)
('Alice', 'CA', 60.0)
('Alice', 'CA', 60.0)
*/