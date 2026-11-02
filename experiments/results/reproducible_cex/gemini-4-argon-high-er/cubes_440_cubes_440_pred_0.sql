-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Name) VALUES (1, 'B');
INSERT INTO people (People_ID, Name) VALUES (2, 'A');
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made) VALUES (1, 1, 1.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made) VALUES (2, 1, 2.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made) VALUES (3, 2, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Final_Table_Made, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST;

/*
Prediction Result:
('B',)
('B',)
('A',)
*/