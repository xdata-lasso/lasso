-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic MAX(height) filtering, tie-breaking for MAX(height), duplicate company names (DISTINCT vs ALL), and ORDER BY company.
-- Also includes a person with shorter height and NULL height to catch MIN, AVG, or IS NULL mutations.
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Alice', 190.5, 65.0, '1990-01-01');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (2, 'Bob', 190.5, 95.0, '1985-05-05');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (3, 'Charlie', 175.0, 110.0, '1992-03-03');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (4, 'David', 160.0, 50.0, '1980-08-08');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (5, 'Eve', NULL, 70.0, '1995-12-12');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (10, 1, 'Zeta Corp', 100000.0, 'InvA');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (20, 2, 'Alpha Inc', 500000.0, 'InvB');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (30, 1, 'Alpha Inc', 250000.0, 'InvC');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (40, 3, 'Beta LLC', 1000000.0, 'InvD');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (50, 4, 'Gamma Co', 50000.0, 'InvE');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (60, 5, 'Delta Ltd', 75000.0, 'InvF');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, LHS.name AS name, LHS.height AS height, LHS.weight AS weight, LHS.date_of_birth AS date_of_birth FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM entrepreneur AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) AS LHS INNER JOIN (SELECT MAX(height) AS height FROM people) AS RHS ON (LHS.height = RHS.height)) ORDER BY company;

/*
Gold Result:
('Alpha Inc',)
('Alpha Inc',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Corp',)
*/