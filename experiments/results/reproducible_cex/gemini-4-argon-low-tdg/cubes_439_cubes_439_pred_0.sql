-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (1, 'USA', 'John Doe', '1980-01-01', 180.5);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (2, 'UK', 'Jane Smith', '1985-05-12', 165.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (3, 'Canada', 'Bob Brown', '1990-07-23', 175.2);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (1, 1, 5.0, 1.0, 10.0, 50000.5);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (2, 2, 2.0, 3.0, 50.0, 10000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (3, 3, 10.0, 1.0, 1.0, 50000.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT earnings FROM poker_player ORDER BY earnings, poker_player.poker_player_id NULLS LAST;

/*
Gold Result:
(10000.0,)
(50000.5,)
(50000.5,)
*/

-- Prediction Query
SELECT Earnings FROM poker_player ORDER BY Earnings DESC, poker_player.poker_player_id NULLS LAST;

/*
Prediction Result:
(50000.5,)
(50000.5,)
(10000.0,)
*/