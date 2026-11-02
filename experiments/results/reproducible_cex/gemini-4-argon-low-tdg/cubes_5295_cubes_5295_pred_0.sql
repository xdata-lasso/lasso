-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests 1-to-many relationships, duplicate output rows (catching DISTINCT mutants), and duplicate names across different people
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Alice', 165.0, 60.0, '1990-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Alice', 170.0, 65.0, '1991-02-02');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (101, 1, 'Alpha', 10000.0, 'Inv1');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (102, 1, 'Alpha', 20000.0, 'Inv2');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (103, 1, 'Beta', 15000.0, 'Inv3');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (104, 2, 'Alpha', 30000.0, 'Inv4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, company FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.height AS height, LHS.weight AS weight, LHS.date_of_birth AS date_of_birth, RHS.entrepreneur_id AS entrepreneur_id, RHS.people_id AS people_id_other, RHS.company AS company, RHS.money_requested AS money_requested, RHS.investor AS investor FROM people AS LHS CROSS JOIN entrepreneur AS RHS) WHERE (people_id = people_id_other) ORDER BY name, company NULLS LAST;

/*
Gold Result:
('Alice', 'Alpha')
('Alice', 'Alpha')
('Alice', 'Alpha')
('Alice', 'Beta')
*/

-- Prediction Query
SELECT T2.Name, T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Money_Requested, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
('Alice', 'Alpha')
('Alice', 'Beta')
('Alice', 'Alpha')
('Alice', 'Alpha')
*/