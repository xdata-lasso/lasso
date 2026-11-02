-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic count boundary conditions (n=1, n=2, n=3, n=4) and alphabetical ordering vs insertion order vs count ordering.
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (1, 'USA', 'Alice', '1980-01-01', 170.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (2, 'USA', 'Bob', '1981-02-02', 175.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (3, 'USA', 'Charlie', '1982-03-03', 180.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (4, 'Canada', 'David', '1983-04-04', 165.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (5, 'Canada', 'Eve', '1984-05-05', 160.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (6, 'Canada', 'Frank', '1985-06-06', 185.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (7, 'Canada', 'Grace', '1986-07-07', 172.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (8, 'UK', 'Heidi', '1987-08-08', 168.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (9, 'UK', 'Ivan', '1988-09-09', 177.0);
INSERT INTO people (People_ID, Nationality, Name, Birth_Date, Height) VALUES (10, 'Germany', 'Judy', '1989-10-10', 169.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT nationality, COUNT(*) AS n FROM people GROUP BY nationality) WHERE (n > 2) ORDER BY nationality;

/*
Gold Result:
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Canada',)
('UK',)
('USA',)
*/