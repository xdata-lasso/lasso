-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (10, 'USA', 'Alice', '1980-01-01', 170.5);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (20, 'UK', 'Bob', '1985-05-12', 180.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (30, 'Canada', 'Charlie', '1990-09-23', 175.2);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (2, 30, 10.0, 8.0, 2.0, 2000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (5, 10, 10.0, 2.0, 3.0, 3000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (8, 20, 4.0, 12.0, 1.0, 5000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT final_table_made, best_finish FROM poker_player ORDER BY final_table_made, poker_player.poker_player_id NULLS LAST;

/*
Gold Result:
(4.0, 12.0)
(10.0, 8.0)
(10.0, 2.0)
*/

-- Prediction Query
SELECT Final_Table_Made, Best_Finish FROM poker_player;

/*
Prediction Result:
(10.0, 8.0)
(10.0, 2.0)
(4.0, 12.0)
*/