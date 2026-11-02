-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (1, 'USA', 'Dan Miller', '1990-01-15', 182.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (2, 'Germany', 'Eva Weber', '1983-04-19', 168.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (3, 'France', 'Frank Martin', '1975-09-30', 177.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (1, 1, 30.0, 4.0, 20.0, 120000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (2, 2, 250000.0, 1.0, 2.0, 250000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (3, 3, 300000.0, 1.0, 1.0, 400000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(final_table_made) OVER () AS max_final_table_made_ FROM poker_player WHERE (earnings < 200000.0 OR earnings = final_table_made) ORDER BY max_final_table_made_;

/*
Gold Result:
(250000.0,)
*/

-- Prediction Query
SELECT MAX(Final_Table_Made) FROM poker_player WHERE Earnings < 200000;

/*
Prediction Result:
(30.0,)
*/