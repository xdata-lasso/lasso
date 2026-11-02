-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests the case where multiple visitors each have exactly 1 visit (total joined rows n = 2, per-visitor visits = 1).
-- This specifically kills mutants that replace the global window function COUNT(*) OVER () with a partitioned window
-- COUNT(*) OVER (PARTITION BY id) or a GROUP BY id HAVING COUNT(*) <> 1.
-- Also tests ORDER BY id and ensures visitor.Name is selected rather than museum.Name.
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (1, 'M_One', 100, '1900');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (2, 'M_Two', 150, '1950');
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (5, 'Zack', 2, 22);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (15, 'Aaron', 1, 35);
INSERT INTO "visit" ("Museum_ID", "visitor_ID", "Num_of_Ticket", "Total_spent") VALUES (2, '15', 1, 15.0);
INSERT INTO "visit" ("Museum_ID", "visitor_ID", "Num_of_Ticket", "Total_spent") VALUES (1, '5', 2, 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name, age FROM (SELECT id, name, level_of_membership, age, museum_id, num_of_ticket, total_spent, visitor_id, COUNT(*) OVER () AS n FROM (SELECT id, name, level_of_membership, age, museum_id, num_of_ticket, total_spent, id AS visitor_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.level_of_membership AS level_of_membership, LHS.age AS age, RHS.museum_id AS museum_id, RHS.num_of_ticket AS num_of_ticket, RHS.total_spent AS total_spent FROM visitor AS LHS INNER JOIN visit AS RHS ON (LHS.id = RHS.visitor_id)))) WHERE (n <> 1) ORDER BY id, name NULLS LAST, age NULLS LAST;

/*
Gold Result:
(5, 'Zack', 22)
(15, 'Aaron', 35)
*/

-- Prediction Query
SELECT t1.id, t1.name, t1.age FROM visitor AS t1 JOIN visit AS t2 ON t1.id = t2.visitor_id GROUP BY t1.id HAVING COUNT(*) > 1;

/*
Prediction Result:
*/