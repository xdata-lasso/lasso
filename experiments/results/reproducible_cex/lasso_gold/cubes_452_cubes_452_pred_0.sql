-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1001, 'Northern Mariana Islands', 'Daniel Doyle', 'rate', 1005.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1002, 'Bouvet Island (Bouvetoya)', 'Stephanie Miller', 'science', 1016.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1003, 'Anguilla', 'Allen Robinson', 'offer', 1027.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1004, 'Saint Vincent and the Grenadines', 'Alyssa Gonzalez', 'kind', 1038.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1009, 1001, 1013.5, 1017.5, 1021.5, 1025.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1010, 1001, 1020.5, 1026.5, 1032.5, 1038.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1011, 1001, 1027.5, 1035.5, 1043.5, 1051.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1012, 1001, 1034.5, 1044.5, 1054.5, 1064.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT money_rank FROM (SELECT * FROM (SELECT * FROM poker_player ORDER BY money_rank, poker_player.poker_player_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(1021.5,)
*/

-- Prediction Query
SELECT Money_Rank FROM poker_player ORDER BY Earnings DESC, poker_player.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1054.5,)
*/