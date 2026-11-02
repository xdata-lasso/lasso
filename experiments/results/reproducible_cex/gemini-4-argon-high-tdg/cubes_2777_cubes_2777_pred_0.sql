-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (10, 'Dan', 172.0, 70.0, '1988-04-12');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (20, 'erin', 168.0, 85.0, '1992-07-23');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (30, 'Frank', 182.0, 85.0, '1984-12-05');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (40, 'Grace', 158.0, 60.0, '1998-01-30');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 10, 'VentureOne', 20000.0, 'SeedFund');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 10, 'VentureTwo', 80000.0, 'GrowthCap');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (3, 20, 'CloudNet', 45000.0, 'AngelGroup');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (4, 30, 'DataWorks', 60000.0, 'PrimeVC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM entrepreneur AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY weight;

/*
Gold Result:
(70.0,)
(70.0,)
(85.0,)
(85.0,)
*/

-- Prediction Query
SELECT T2.Weight FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Money_Requested DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
(70.0,)
(85.0,)
(85.0,)
(70.0,)
*/