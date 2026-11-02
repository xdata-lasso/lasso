-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (1, 'USA', 'Bob', '1980-01-01', 180.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (2, 'USA', 'Alice', '1985-01-01', 165.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (1, NULL, 1.0, 1.0, 1.0, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM poker_player);

/*
Prediction Result:
*/