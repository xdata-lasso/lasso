-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (7, '911', 911, '911');
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (9, '911', 911, '911');
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (10, '911', 911, 911);
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (8, '911', 911, 911);
INSERT INTO "visit" ("museum_id", "visitor_id", "num_of_ticket", "total_spent") VALUES (9, '10', 908, 11);
INSERT INTO "visit" ("museum_id", "visitor_id", "num_of_ticket", "total_spent") VALUES (7, '8', 911, 911);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(num_of_ticket) OVER () AS avg_num_of_ticket_, maxnum_of_ticket AS max_num_of_ticket_ FROM (SELECT museum_id, visitor_id, num_of_ticket, total_spent, MAX(num_of_ticket) OVER () AS maxnum_of_ticket FROM visit) ORDER BY avg_num_of_ticket_, max_num_of_ticket_ NULLS LAST;

/*
Gold Result:
(909.5, 911)
*/

-- Prediction Query
SELECT AVG(num_of_ticket), MAX(num_of_ticket) FROM visit;

/*
Prediction Result:
(909.5, 911)
*/