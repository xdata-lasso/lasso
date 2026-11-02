-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (1, 'M1', 10, '2000');
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (1, 'Alice', 1, 25);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (2, 'Bob', 1, 30);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (1, '1', 1, 10.0);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (1, '2', 1, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name, age FROM (SELECT id, name, level_of_membership, age, museum_id, num_of_ticket, total_spent, visitor_id, COUNT(*) OVER () AS n FROM (SELECT id, name, level_of_membership, age, museum_id, num_of_ticket, total_spent, id AS visitor_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.level_of_membership AS level_of_membership, LHS.age AS age, RHS.museum_id AS museum_id, RHS.num_of_ticket AS num_of_ticket, RHS.total_spent AS total_spent FROM visitor AS LHS INNER JOIN visit AS RHS ON (LHS.id = RHS.visitor_id)))) WHERE (n <> 1) ORDER BY id, name NULLS LAST, age NULLS LAST;

/*
Gold Result:
(1, 'Alice', 25)
(2, 'Bob', 30)
*/

-- Prediction Query
SELECT t1.id, t1.name, t1.age FROM visitor AS t1 JOIN visit AS t2 ON t1.id = t2.visitor_id GROUP BY t1.id HAVING COUNT(*) > 1;

/*
Prediction Result:
*/