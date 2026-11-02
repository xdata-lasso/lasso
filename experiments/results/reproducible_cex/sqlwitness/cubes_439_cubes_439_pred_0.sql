-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, nationality, name, birth_date, height) VALUES (0, 'default1', NULL, 'default1', 0.0), (1, 'default2', NULL, 'default1', 1.0);
INSERT INTO poker_player (poker_player_id, people_id, final_table_made, best_finish, money_rank, earnings) VALUES (0, NULL, 1.0, 0.0, 1.0, 0.0), (1, NULL, NULL, NULL, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT earnings FROM poker_player ORDER BY earnings, poker_player.poker_player_id NULLS LAST;

/*
Gold Result:
(0.0,)
(1.0,)
*/

-- Prediction Query
SELECT Earnings FROM poker_player ORDER BY Earnings DESC, poker_player.poker_player_id NULLS LAST;

/*
Prediction Result:
(1.0,)
(0.0,)
*/