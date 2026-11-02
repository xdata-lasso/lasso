-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (10, 'USA', 'Alice Smith', '1980-01-15', 170.5);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (20, 'UK', 'Bob Jones', '1975-06-20', 182.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (30, 'Canada', 'Charlie Brown', '1990-11-05', 175.2);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (40, 'Germany', 'Diana Prince', '1985-03-30', 168.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (50, 'France', 'Eve Adams', '1992-07-12', 165.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (1, 10, 4.0, 3.0, 2.0, 500.5);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (2, 20, 2.0, 1.0, 5.0, -100.25);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (3, 30, 3.0, 5.0, 1.0, 0.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (4, 40, 5.0, 2.0, 4.0, 500.5);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (5, 10, 1.0, 4.0, 3.0, 120.75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT earnings FROM poker_player ORDER BY earnings, poker_player.poker_player_id NULLS LAST;

/*
Gold Result:
(-100.25,)
(0.0,)
(120.75,)
(500.5,)
(500.5,)
*/

-- Prediction Query
SELECT Earnings FROM poker_player ORDER BY Earnings DESC, poker_player.poker_player_id NULLS LAST;

/*
Prediction Result:
(500.5,)
(500.5,)
(120.75,)
(0.0,)
(-100.25,)
*/