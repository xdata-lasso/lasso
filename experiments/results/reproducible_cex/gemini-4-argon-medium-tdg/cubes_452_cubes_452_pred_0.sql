-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (10, 'USA', 'Dave', '1975-03-15', 182.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (20, 'France', 'Eve', '1992-07-20', 165.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (1, 10, 3.0, 4.0, NULL, 50000.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (2, 20, 8.0, 1.0, 5.0, 900000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT money_rank FROM (SELECT * FROM (SELECT * FROM poker_player ORDER BY money_rank, poker_player.poker_player_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Money_Rank FROM poker_player ORDER BY Earnings DESC, poker_player.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(5.0,)
*/