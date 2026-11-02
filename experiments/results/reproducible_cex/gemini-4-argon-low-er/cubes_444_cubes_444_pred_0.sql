-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (1, 'USA', 'John Doe', '1980-01-01', 180.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (1, 1, 300000.0, 1.0, 1.0, 300000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(final_table_made) OVER () AS max_final_table_made_ FROM poker_player WHERE (earnings < 200000.0 OR earnings = final_table_made) ORDER BY max_final_table_made_;

/*
Gold Result:
(300000.0,)
*/

-- Prediction Query
SELECT MAX(Final_Table_Made) FROM poker_player WHERE Earnings < 200000;

/*
Prediction Result:
(None,)
*/