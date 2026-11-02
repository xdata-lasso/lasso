-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Person 1', 170.0, 65.0, '1980-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Person 2', 175.0, 70.0, '1982-02-02');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (3, 'Person 3', 180.0, 75.0, '1984-03-03');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (4, 'Person 4', 165.0, 60.0, '1986-04-04');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (5, 'Person 5', 168.0, 62.0, '1988-05-05');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (6, 'Person 6', 172.0, 68.0, '1990-06-06');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (7, 'Person 7', 178.0, 74.0, '1992-07-07');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (8, 'Person 8', 182.0, 80.0, '1994-08-08');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (9, 'Person 9', 160.0, 55.0, '1996-09-09');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (10, 'Person 10', 185.0, 85.0, '1998-10-10');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 1, 'Comp D1', 10000.0, 'Delta');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 2, 'Comp C1', 500.0, 'Charlie');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (3, 3, 'Comp C2', 500.0, 'Charlie');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (4, 4, 'Comp A1', 100.0, 'Alpha');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (5, 5, 'Comp A2', 100.0, 'Alpha');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (6, 6, 'Comp A3', 100.0, 'Alpha');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (7, 7, 'Comp B1', 10.0, 'Bravo');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (8, 8, 'Comp B2', 10.0, 'Bravo');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (9, 9, 'Comp B3', 10.0, 'Bravo');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (10, 10, 'Comp B4', 10.0, 'Bravo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor_other AS investor FROM (SELECT LHS.investor AS investor, LHS.maxn AS maxn, RHS.investor AS investor_other, RHS.maxn AS maxn_other FROM (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS LHS CROSS JOIN (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS RHS) WHERE (maxn < maxn_other) ORDER BY investor;

/*
Gold Result:
('Alpha',)
('Bravo',)
('Charlie',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bravo',)
*/