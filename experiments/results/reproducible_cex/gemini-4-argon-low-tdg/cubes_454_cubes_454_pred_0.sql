-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join, ordering (desc vs asc, insertion order), duplicates (DISTINCT vs ALL), and mismatched PK/FK IDs (Poker_Player_ID vs People_ID).
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (1, 'USA', 'Charlie', '1980-01-01', 180.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (2, 'UK', 'Alice', '1985-05-05', 165.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (3, 'Canada', 'Bob', '1990-10-10', 175.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (4, 'USA', 'Alice', '1992-02-02', 170.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (5, 'France', 'David', '1988-08-08', 182.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (2, 3, 5.0, 1.0, 10.0, 50000.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (3, 5, 2.0, 3.0, 20.0, 15000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM poker_player);

/*
Prediction Result:
('Charlie',)
('Alice',)
('Alice',)
*/