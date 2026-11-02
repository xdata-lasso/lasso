-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Edge case: empty visit table (tests aggregate vs window function behavior on empty set)
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (1, 'Louvre', 100, '1793');
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (1, 'Alice', 1, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(num_of_ticket) OVER () AS avg_num_of_ticket_, maxnum_of_ticket AS max_num_of_ticket_ FROM (SELECT museum_id, visitor_id, num_of_ticket, total_spent, MAX(num_of_ticket) OVER () AS maxnum_of_ticket FROM visit) ORDER BY avg_num_of_ticket_, max_num_of_ticket_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(num_of_ticket), MAX(num_of_ticket) FROM visit;

/*
Prediction Result:
(None, None)
*/