-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1066, 'Niue', 'Shannon Ray', 'sea', 1067.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1068, 1066, 200000, 1069.5, 1070.5, 200000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(final_table_made) OVER () AS max_final_table_made_ FROM poker_player WHERE (earnings < 200000.0 OR earnings = final_table_made) ORDER BY max_final_table_made_;

/*
Gold Result:
(200000.0,)
*/

-- Prediction Query
SELECT MAX(Final_Table_Made) FROM poker_player WHERE Earnings < 200000;

/*
Prediction Result:
(None,)
*/