-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by final_table_made (ASC vs DESC), duplicate projected rows (SELECT vs SELECT DISTINCT),
-- and primary key vs foreign key / other columns in tie-breaking.
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (1, 'USA', 'Alice', '1980-01-01', 170.5);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (2, 'UK', 'Bob', '1985-05-05', 180.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (3, 'Canada', 'Charlie', '1990-10-10', 175.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (10, 3, 5.0, 2.0, 10.0, 50000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (20, 1, 2.0, 1.0, 5.0, 100000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (30, 2, 2.0, 1.0, 5.0, 100000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT final_table_made, best_finish FROM poker_player ORDER BY final_table_made, poker_player.poker_player_id NULLS LAST;

/*
Gold Result:
(2.0, 1.0)
(2.0, 1.0)
(5.0, 2.0)
*/

-- Prediction Query
SELECT Final_Table_Made, Best_Finish FROM poker_player;

/*
Prediction Result:
(5.0, 2.0)
(2.0, 1.0)
(2.0, 1.0)
*/