-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1001, 'Allison Hill', 1004, 'all');
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1002, 'Noah Rhodes', 1011.0, 'better');
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1003, 'Angie Henderson', 1018.0, 'discover');
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (1007, 'Lance Hoffman', 1010, 1013);
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (1008, 'Meredith Barnes', 1017.0, 1022.0);
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (1009, 'Donald Booth', 1024.0, 1031.0);
INSERT INTO "visit" ("museum_id", "visitor_id", "num_of_ticket", "total_spent") VALUES (1001, 1007, 1016, 1019.5);
INSERT INTO "visit" ("museum_id", "visitor_id", "num_of_ticket", "total_spent") VALUES (1001, 1008, 1023.0, 1028.5);
INSERT INTO "visit" ("museum_id", "visitor_id", "num_of_ticket", "total_spent") VALUES (1001, 1009, 1030.0, 1037.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name, age FROM (SELECT id, name, level_of_membership, age, museum_id, num_of_ticket, total_spent, visitor_id, COUNT(*) OVER () AS n FROM (SELECT id, name, level_of_membership, age, museum_id, num_of_ticket, total_spent, id AS visitor_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.level_of_membership AS level_of_membership, LHS.age AS age, RHS.museum_id AS museum_id, RHS.num_of_ticket AS num_of_ticket, RHS.total_spent AS total_spent FROM visitor AS LHS INNER JOIN visit AS RHS ON (LHS.id = RHS.visitor_id)))) WHERE (n <> 1) ORDER BY id, name NULLS LAST, age NULLS LAST;

/*
Gold Result:
(1007, 'Lance Hoffman', 1013)
(1008, 'Meredith Barnes', 1022)
(1009, 'Donald Booth', 1031)
*/

-- Prediction Query
SELECT t1.id, t1.name, t1.age FROM visitor AS t1 JOIN visit AS t2 ON t1.id = t2.visitor_id GROUP BY t1.id HAVING COUNT(*) > 1;

/*
Prediction Result:
*/