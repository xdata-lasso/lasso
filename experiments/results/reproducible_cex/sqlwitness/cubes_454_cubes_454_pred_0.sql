-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, nationality, name, birth_date, height) VALUES (1, 'default2', NULL, 'default2', 1.0), (2, 'default2', NULL, NULL, 0.0), (0, NULL, NULL, NULL, 1.0), (3, 'default2', NULL, 'default2', NULL), (4, 'default2', 'default1', NULL, NULL), (5, 'default1', 'default2', NULL, 0.0), (6, 'default2', NULL, NULL, NULL);
INSERT INTO poker_player (poker_player_id, people_id, final_table_made, best_finish, money_rank, earnings) VALUES (2, NULL, NULL, NULL, 0.0, 1.0), (1, NULL, 1.0, 0.0, 1.0, NULL), (0, 5, NULL, 2.0, 2.0, 1.0), (3, 6, NULL, 1.0, 1.0, 0.0), (4, 1, 1.0, 1.0, 0.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM poker_player);

/*
Prediction Result:
*/