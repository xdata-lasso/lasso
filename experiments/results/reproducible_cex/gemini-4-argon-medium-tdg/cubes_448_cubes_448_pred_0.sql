-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (1, 'USA', 'Charlie', '1980-01-01', 180.5);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (2, 'UK', 'Alice', '1985-05-12', 165.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (3, 'Canada', 'Bob', '1990-07-23', 175.2);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (4, 'France', 'David', '1975-11-30', 182.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (5, 'Germany', 'Eve', '1992-03-15', 170.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (101, 1, 5.0, 1.0, 10.0, 300000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (102, 2, 10.0, 1.0, 5.0, 500000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (103, 3, 2.0, 3.0, 50.0, 299999.9);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (104, 4, 1.0, 5.0, 100.0, 150000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.people_id AS people_id, LHS.nationality AS nationality, LHS.name AS name, LHS.birth_date AS birth_date, LHS.height AS height, RHS.poker_player_id AS poker_player_id, RHS.final_table_made AS final_table_made, RHS.best_finish AS best_finish, RHS.money_rank AS money_rank, RHS.earnings AS earnings FROM people AS LHS INNER JOIN (SELECT * FROM poker_player WHERE (earnings >= 300000.0)) AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T2.Earnings > 300000;

/*
Prediction Result:
('Alice',)
*/