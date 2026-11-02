-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Alice', 165.0, 75.5, '1980-01-01');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (2, 'Bob', 180.0, 62.0, '1985-05-12');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (3, 'Charlie', 175.0, 88.0, '1990-03-15');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (4, 'Diana', 160.0, 55.0, '1992-07-20');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (10, 1, 'TechCorp', 100000.0, 'InvA');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (20, 2, 'BioHealth', 250000.0, 'InvB');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (30, 1, 'AIStartup', 500000.0, 'InvC');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (40, NULL, 'StealthCo', 50000.0, 'InvD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM entrepreneur AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY weight;

/*
Gold Result:
(62.0,)
(75.5,)
(75.5,)
*/

-- Prediction Query
SELECT T2.Weight FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Money_Requested DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
(75.5,)
(62.0,)
(75.5,)
*/