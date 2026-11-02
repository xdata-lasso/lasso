-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, nationality, name, birth_date, height) VALUES (1, 'default2', NULL, 'default1', 0.0), (0, 'default2', 'default1', NULL, 300000.0), (300001, 'default2', 'default1', 'default1', 300000.0), (299999, 'default2', 'default2', 'default1', NULL), (300000, 'default2', NULL, 'default1', 300001.0);
INSERT INTO poker_player (poker_player_id, people_id, final_table_made, best_finish, money_rank, earnings) VALUES (300001, 0, 300001.0, 299999.0, 300001.0, 300000.0), (1, 1, 300001.0, 300001.0, 1.0, 1.0), (300000, 300001, 0.0, 300001.0, 300001.0, 1.0), (299999, 1, 299999.0, 300000.0, 300000.0, 299999.0), (0, 1, 300000.0, 1.0, 1.0, 299999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.people_id AS people_id, LHS.nationality AS nationality, LHS.name AS name, LHS.birth_date AS birth_date, LHS.height AS height, RHS.poker_player_id AS poker_player_id, RHS.final_table_made AS final_table_made, RHS.best_finish AS best_finish, RHS.money_rank AS money_rank, RHS.earnings AS earnings FROM people AS LHS INNER JOIN (SELECT * FROM poker_player WHERE (earnings >= 300000.0)) AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T2.Earnings > 300000;

/*
Prediction Result:
*/