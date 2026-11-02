-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, nationality, name, birth_date, height) VALUES (1, 'default1', 'default2', 'default2', 1.0), (0, 'default1', 'default1', 'default1', NULL), (2, NULL, NULL, 'default2', 1.0), (3, 'default2', 'default1', 'default1', 2.0), (4, 'default1', 'default1', 'default1', 0.0), (5, 'default2', NULL, 'default1', 1.0), (6, 'default1', 'default1', NULL, NULL);
INSERT INTO poker_player (poker_player_id, people_id, final_table_made, best_finish, money_rank, earnings) VALUES (0, 0, 1.0, 0.0, 1.0, NULL), (2, 0, 2.0, 1.0, 1.0, 0.0), (1, 3, NULL, NULL, 0.0, 0.0), (3, 5, 0.0, 2.0, 2.0, 0.0), (4, 3, NULL, 0.0, 0.0, 2.0), (5, 6, 2.0, 0.0, NULL, 2.0), (6, NULL, NULL, 0.0, 1.0, 1.0), (7, 0, NULL, 2.0, 0.0, NULL), (8, 4, 1.0, 2.0, 2.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT money_rank FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.poker_player_id AS poker_player_id, LHS.people_id AS people_id, LHS.final_table_made AS final_table_made, LHS.best_finish AS best_finish, LHS.money_rank AS money_rank, LHS.earnings AS earnings, RHS.nationality AS nationality, RHS.name AS name, RHS.birth_date AS birth_date, RHS.height AS height FROM poker_player AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY poker_player_id) LIMIT 1);

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT T2.Money_Rank FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Height DESC, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0,)
*/