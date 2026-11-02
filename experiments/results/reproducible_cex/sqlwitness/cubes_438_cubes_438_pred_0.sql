-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, nationality, name, birth_date, height) VALUES (0, NULL, 'default2', NULL, 0.0);
INSERT INTO poker_player (poker_player_id, people_id, final_table_made, best_finish, money_rank, earnings) VALUES (1, NULL, NULL, 1.0, 0.0, 1.0), (0, NULL, 0.0, 1.0, 1.0, NULL), (2, 0, NULL, 1.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT final_table_made, best_finish FROM poker_player ORDER BY final_table_made, poker_player.poker_player_id NULLS LAST;

/*
Gold Result:
(None, 1.0)
(None, 1.0)
(0.0, 1.0)
*/

-- Prediction Query
SELECT Final_Table_Made, Best_Finish FROM poker_player;

/*
Prediction Result:
(0.0, 1.0)
(None, 1.0)
(None, 1.0)
*/