-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Alice', 160.5, 65.0, '1990-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Bob', 150.0, 80.5, '1985-05-12');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (3, 'Charlie', 150.0, 55.2, '1992-07-23');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (4, 'David', 150.0, 55.2, '1988-11-30');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (5, 'Eve', 180.0, 45.0, '1995-03-15');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (6, 'Frank', NULL, 70.0, '1980-09-09');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 1, 'TechCorp', 100000.0, 'Investor A');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 2, 'BioHealth', 250000.0, 'Investor B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight FROM (SELECT LHS.height AS height, RHS.people_id AS people_id, RHS.name AS name, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM (SELECT MIN(height) AS height FROM people) AS LHS LEFT JOIN people AS RHS ON (LHS.height = RHS.height)) ORDER BY weight;

/*
Gold Result:
(55.2,)
(55.2,)
(80.5,)
*/

-- Prediction Query
SELECT Weight FROM people ORDER BY Height ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(70.0,)
*/