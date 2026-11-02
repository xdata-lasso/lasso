-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (10, 'USA', 'Charlie', '1980-05-10', 190.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (20, 'Canada', 'Alice', '1990-01-15', 180.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (30, 'UK', 'Bob', '1985-11-20', 170.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (40, 'Germany', 'David', '1975-03-25', 175.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (50, 'France', 'Eve', '1992-07-30', 165.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (60, 'Italy', 'Frank', '1988-09-05', 185.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (40, 30, 5.0, 1.0, 10.0, 500000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (50, 20, 10.0, 2.0, 20.0, 400000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (60, 10, 15.0, 3.0, 30.0, 300000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (10, 40, 20.0, 1.0, 5.0, 299999.99);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (20, 50, 300000.0, 300000.0, 300000.0, 15000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.people_id AS people_id, LHS.nationality AS nationality, LHS.name AS name, LHS.birth_date AS birth_date, LHS.height AS height, RHS.poker_player_id AS poker_player_id, RHS.final_table_made AS final_table_made, RHS.best_finish AS best_finish, RHS.money_rank AS money_rank, RHS.earnings AS earnings FROM people AS LHS INNER JOIN (SELECT * FROM poker_player WHERE (earnings >= 300000.0)) AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T2.Earnings > 300000;

/*
Prediction Result:
('Bob',)
('Alice',)
*/