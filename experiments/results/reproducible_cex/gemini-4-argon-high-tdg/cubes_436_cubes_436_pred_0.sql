-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (1, 'USA', 'John Smith', '1980-01-15', 180.5);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (2, 'USA', 'Mike Johnson', '1982-05-20', 175.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (3, 'USA', 'Sarah Davis', '1990-11-03', 168.2);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (4, 'Brazil', 'Carlos Silva', '1985-03-12', 178.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (5, 'Brazil', 'Ana Santos', '1988-07-25', 165.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (6, 'Brazil', 'Pedro Oliveira', '1992-09-10', 182.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (7, 'Brazil', 'Lucas Costa', '1979-12-01', 174.5);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (8, 'Canada', 'David Brown', '1981-04-18', 185.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (9, 'Canada', 'Emily Wilson', '1986-08-30', 170.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (10, 'Canada', 'Chris Taylor', '1991-02-14', 179.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (11, 'Canada', 'Jessica Moore', '1993-06-22', 166.5);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (12, 'Canada', 'Daniel Anderson', '1977-10-05', 181.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (13, 'France', 'Pierre Dupont', '1984-01-09', 176.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (14, 'France', 'Marie Laurent', '1989-05-17', 164.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (15, 'Germany', 'Hans Mueller', '1983-09-28', 188.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (1, 1, 5.0, 1.0, 10.0, 500000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (2, 13, 3.0, 2.0, 25.0, 150000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (3, 13, 1.0, 5.0, 80.0, 40000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (4, 14, 4.0, 1.0, 15.0, 300000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (5, 15, 2.0, 3.0, 50.0, 90000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (6, 15, 6.0, 1.0, 5.0, 800000.0);
INSERT INTO poker_player (Poker_Player_ID, People_ID, Final_Table_Made, Best_Finish, Money_Rank, Earnings) VALUES (7, 15, 1.0, 8.0, 120.0, 20000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT nationality, COUNT(*) AS n FROM people GROUP BY nationality) WHERE (n > 2) ORDER BY nationality;

/*
Gold Result:
('Brazil',)
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Brazil',)
('Canada',)
('France',)
('USA',)
*/