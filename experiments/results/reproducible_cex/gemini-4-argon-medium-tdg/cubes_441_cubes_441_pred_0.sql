-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (1, 'USA', 'Alice', '1990-05-15', 170.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (2, 'UK', 'Bob', '1985-10-20', 180.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (3, 'Canada', 'Charlie', '1970-01-01', 175.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (10, 1, 5.0, 1.0, 10.0, 50000.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (20, 2, 2.0, 3.0, 50.0, 10000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT birth_date FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY birth_date;

/*
Gold Result:
('1985-10-20',)
('1990-05-15',)
*/

-- Prediction Query
SELECT T1.Birth_Date FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings ASC, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1985-10-20',)
*/