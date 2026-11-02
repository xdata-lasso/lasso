-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO head (head_id, name, born_state, age) VALUES (0, 'default1', 'default2', NULL), (1, 'default2', 'default2', 0.0), (2, 'default2', 'default2', 1.0), (3, 'default2', 'default1', 0.0), (4, 'default2', NULL, 0.0), (5, 'default1', NULL, 0.0), (6, 'default2', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, born_state, age FROM head ORDER BY name, head.head_id NULLS LAST;

/*
Gold Result:
('default1', 'default2', None)
('default1', None, 0.0)
('default2', 'default2', 0.0)
('default2', 'default2', 1.0)
('default2', 'default1', 0.0)
('default2', None, 0.0)
('default2', 'default2', None)
*/

-- Prediction Query
SELECT name, born_state, age FROM head ORDER BY age, head.head_id NULLS LAST;

/*
Prediction Result:
('default1', 'default2', None)
('default2', 'default2', None)
('default2', 'default2', 0.0)
('default2', 'default1', 0.0)
('default2', None, 0.0)
('default1', None, 0.0)
('default2', 'default2', 1.0)
*/