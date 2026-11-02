-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1, '5k5swwqcgs', '9n8', 't1__ac4192', 874.871895);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (-2147483647, 'e4', 'hria2ypuzhs', 't1__ac4192', 663.049759);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (0, 'luhvdltti', 'bnp', 't1__500ef0', 787.938887);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (4, 'dpos', 'ie5', 'nw6klf', 741.842896);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (-2147483644, '0t5c4ec', 'gce', 't1__500ef0', 467.07027);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (-2147483643, '52zbuo4nrq', 'rofqyp5s5b', 't1__500ef0', 22.720462);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (-2147483642, 'l7', 'klex14ji', 't1__500ef0', 598.409165);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (-2147483641, 'dwyrq13p', 'u78d99r', 't1__500ef0', 182.777264);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (-2147483640, 'yp5qi2rk', '9v', 't1__500ef0', 263.638479);

-- Inserting into table: poker_player --
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1, 1, 475.173408, 935.695299, 688.4027, 520.784135);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483647, 1, 711.020062, 944.247544, 994.117864, 749.826493);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483646, 4, 587.783596, 558.971814, 406.809007, 0.0);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483645, 4, 875.837169, 893.977471, 502.947917, 0.0);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483644, 4, 206.591836, 130.961286, 191.847248, 0.5);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483643, 4, 990.777211, 705.580387, 673.065986, 0.0);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483642, 1, 825.231787, 75.551482, 297.722676, 138.017996);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483641, 1, 251.267403, 427.383654, 426.853398, 997.73177);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483640, 1, 881.232072, 377.535852, 668.928822, 942.030111);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483639, 1, 937.856955, 645.419272, 882.985782, 228.583847);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483638, 1, 394.443388, 612.02959, 313.384575, 0.0);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483637, 1, 943.791649, 289.326855, 419.361606, 0.5);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483636, 1, 778.01524, 629.623334, 860.770887, 0.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT birth_date FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY birth_date;

/*
Gold Result:
('nw6klf',)
('t1__ac4192',)
*/

-- Prediction Query
SELECT T1.Birth_Date FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings ASC, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__ac4192',)
*/