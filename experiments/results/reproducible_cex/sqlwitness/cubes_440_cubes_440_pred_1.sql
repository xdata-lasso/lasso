-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, nationality, name, birth_date, height) VALUES (1, 'default1', 'default2', 'default1', 0.0);
INSERT INTO poker_player (poker_player_id, people_id, final_table_made, best_finish, money_rank, earnings) VALUES (1, NULL, 0.0, 1.0, 2.0, NULL), (2, 1, NULL, NULL, 1.0, 1.0), (0, NULL, 1.0, 2.0, 0.0, 0.0), (3, NULL, 1.0, 2.0, 2.0, 0.0), (4, 1, 2.0, 1.0, NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings DESC, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST;

/*
Prediction Result:
('default2',)
('default2',)
*/