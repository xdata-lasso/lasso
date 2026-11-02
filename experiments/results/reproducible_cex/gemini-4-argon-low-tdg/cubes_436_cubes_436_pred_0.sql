-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic threshold boundary conditions (count = 1, 2, 3, 4) and ORDER BY
-- Also tests joins against poker_player (some people are not poker players, some have multiple poker_player entries)
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (1, 'Canada', 'Alice', '1980-01-01', 170.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (2, 'UK', 'Bob', '1981-02-02', 175.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (3, 'UK', 'Charlie', '1982-03-03', 180.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (4, 'USA', 'David', '1983-04-04', 185.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (5, 'USA', 'Eve', '1984-05-05', 165.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (6, 'USA', 'Frank', '1985-06-06', 190.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (7, 'Brazil', 'Grace', '1986-07-07', 160.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (8, 'Brazil', 'Heidi', '1987-08-08', 162.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (9, 'Brazil', 'Ivan', '1988-09-09', 178.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (10, 'Brazil', 'Judy', '1989-10-10', 172.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (101, 1, 5.0, 1.0, 10.0, 50000.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (102, 1, 2.0, 3.0, 20.0, 20000.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (103, 1, 1.0, 5.0, 30.0, 10000.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (104, 2, 3.0, 2.0, 15.0, 30000.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (105, 4, 4.0, 1.0, 12.0, 40000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT nationality, COUNT(*) AS n FROM people GROUP BY nationality) WHERE (n > 2) ORDER BY nationality;

/*
Gold Result:
('Brazil',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Brazil',)
('UK',)
('USA',)
*/