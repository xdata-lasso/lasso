-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1, '5k5swwqcgs', '9n8', '4', 249.706432);

-- Inserting into table: poker_player --
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1, 1, 1.0, 1.0, 1.0, 1.0);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483647, 1, 1.0, 1.0, 1.0, 1.0);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-1, 1, 520.784135, 86.520366, -7719.0, 65.761562);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (0, 1, 268.82475, 710.998147, 0.0, 945.642658);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483644, 1, 378.476082, 783.93201, 1.0, 718.397869);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483643, 1, 882.963176, 841.297061, 1.0, 294.861575);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT money_rank FROM (SELECT * FROM (SELECT * FROM poker_player ORDER BY money_rank, poker_player.poker_player_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(-7719.0,)
*/

-- Prediction Query
SELECT Money_Rank FROM poker_player ORDER BY Earnings DESC, poker_player.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0,)
*/