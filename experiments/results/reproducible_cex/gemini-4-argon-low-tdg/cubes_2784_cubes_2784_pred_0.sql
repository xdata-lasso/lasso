-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Person1', 160.0, 50.0, '1990-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Person2', 170.0, 60.0, '1991-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (3, 'Person3', 180.0, 70.0, '1992-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (4, 'Person4', 190.0, 80.0, '1993-01-01');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 4, 'C1', 10.0, 'Z_Inv');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 1, 'C2', 20.0, 'B_Inv');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (3, 1, 'C3', 30.0, 'A_Inv');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (4, 2, 'C4', 40.0, 'B_Inv');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (5, 2, 'C5', 50.0, 'C_Inv');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (6, 2, 'C6', 60.0, 'C_Inv');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (7, 3, 'C7', 70.0, 'A_Inv');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.people_id AS people_id_other FROM entrepreneur AS LHS INNER JOIN (SELECT people_id, COUNT(*) AS n FROM entrepreneur GROUP BY people_id) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY investor;

/*
Gold Result:
('A_Inv',)
('B_Inv',)
('C_Inv',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_Inv',)
*/