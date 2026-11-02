-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), DISTINCT vs ALL (duplicate earnings), and out-of-order insertion.
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (1, 'USA', 'Alice', '1980-01-01', 170.5);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (2, 'UK', 'Bob', '1985-02-02', 180.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (3, 'Canada', 'Charlie', '1990-03-03', 175.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (10, 1, 5.0, 1.0, 10.0, 5000.50);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (5, 2, 2.0, 3.0, 20.0, 1000.00);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (8, 3, 2.0, 3.0, 20.0, 1000.00);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (1, 1, 10.0, 1.0, 1.0, 25000.75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT earnings FROM poker_player ORDER BY earnings, poker_player.poker_player_id NULLS LAST;

/*
Gold Result:
(1000.0,)
(1000.0,)
(5000.5,)
(25000.75,)
*/

-- Prediction Query
SELECT Earnings FROM poker_player ORDER BY Earnings DESC, poker_player.poker_player_id NULLS LAST;

/*
Prediction Result:
(25000.75,)
(5000.5,)
(1000.0,)
(1000.0,)
*/