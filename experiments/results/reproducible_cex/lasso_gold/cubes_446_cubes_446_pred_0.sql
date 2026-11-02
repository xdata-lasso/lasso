-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1126, 'Ethiopia', 'Thomas Bradley', 'serious', 1127.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1140, 'Kuwait', 'Charles Mcgee', 'nothing', 1141.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1128, 1126, 1129.5, 1130.5, 1131.5, 1132.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1135, 1126, 1136.5, 1137.5, 1138.5, 1139.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1142, 1140, 1143.5, 1144.5, 1145.5, 1146.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT money_rank FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.poker_player_id AS poker_player_id, LHS.people_id AS people_id, LHS.final_table_made AS final_table_made, LHS.best_finish AS best_finish, LHS.money_rank AS money_rank, LHS.earnings AS earnings, RHS.nationality AS nationality, RHS.name AS name, RHS.birth_date AS birth_date, RHS.height AS height FROM poker_player AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY poker_player_id) LIMIT 1);

/*
Gold Result:
(1131.5,)
*/

-- Prediction Query
SELECT T2.Money_Rank FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Height DESC, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1145.5,)
*/