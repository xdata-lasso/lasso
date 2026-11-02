-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1, 'lhs_89e672', 'lhs_132b2e', 'lhs_19ef17', 1.0);

INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (-2147483648, 'lhs_2005a1', 'lhs_b659bd', 'lhs_81a9a1', 1.0);

-- Inserting into table: poker_player --
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483648, 1, 582.588439, 680.190136, 487.053947, 486.033807);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483647, 1, 345.329712, 833.684115, 261.897639, 97.952323);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483646, 1, 171.746906, 557.512061, 868.436572, 537.136345);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483645, 1, 38.937207, 249.706432, 99.523333, 314.813297);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483644, 1, 328.996339, 906.21648, 483.665643, 818.685402);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483643, 1, 804.971537, 119.752245, 134.487977, 941.961117);

INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (-2147483642, 1, 4.751658, 441.165949, 797.015047, 241.913711);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('lhs_132b2e',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('lhs_132b2e',)
('lhs_132b2e',)
('lhs_132b2e',)
('lhs_132b2e',)
('lhs_132b2e',)
('lhs_132b2e',)
('lhs_132b2e',)
*/