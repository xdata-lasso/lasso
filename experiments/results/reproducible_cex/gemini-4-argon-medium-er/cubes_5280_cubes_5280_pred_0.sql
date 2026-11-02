-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Alice', 170.0, 100.0, '1990-01-01');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (2, 'Bob', 180.0, 200.0, '1990-01-01');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (1, 1, 'CompanyA', 1000.0, 'InvestorA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, LHS.name AS name, LHS.height AS height, LHS.weight AS weight, LHS.date_of_birth AS date_of_birth FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM entrepreneur AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) AS LHS INNER JOIN (SELECT MAX(weight) AS weight FROM people) AS RHS ON (LHS.weight = RHS.weight)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Weight DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/