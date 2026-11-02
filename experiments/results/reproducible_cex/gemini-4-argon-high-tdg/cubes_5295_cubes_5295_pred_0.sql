-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Charlie', 180.5, 75.0, '1990-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Bob', 175.0, 70.2, '1985-05-12');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (3, 'Alice', 165.3, 60.1, '1992-11-23');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 2, 'Zeta', 50000.0, 'InvA');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, NULL, 'OrphanCo', 10000.0, 'InvB');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (10, 3, 'Alpha', 75000.0, 'InvC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, company FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.height AS height, LHS.weight AS weight, LHS.date_of_birth AS date_of_birth, RHS.entrepreneur_id AS entrepreneur_id, RHS.people_id AS people_id_other, RHS.company AS company, RHS.money_requested AS money_requested, RHS.investor AS investor FROM people AS LHS CROSS JOIN entrepreneur AS RHS) WHERE (people_id = people_id_other) ORDER BY name, company NULLS LAST;

/*
Gold Result:
('Alice', 'Alpha')
('Bob', 'Zeta')
*/

-- Prediction Query
SELECT T2.Name, T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Money_Requested, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
('Bob', 'Zeta')
('Alice', 'Alpha')
*/