-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (1, 'USA', 'Alice', '1980-01-01', 170.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (2, 'UK', 'Bob', '1985-02-02', 180.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (3, 'CAN', 'Charlie', '1990-03-03', 175.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (4, 'AUS', 'David', '1995-04-04', 185.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (1, 1, 10.0, 1.0, 5.0, 150000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (2, 2, 20.0, 2.0, 10.0, 200000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (3, 3, 250000.0, 1.0, 1.0, 250000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (4, 4, 300000.0, 3.0, 2.0, 400000.0);
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
(10.0,)
*/