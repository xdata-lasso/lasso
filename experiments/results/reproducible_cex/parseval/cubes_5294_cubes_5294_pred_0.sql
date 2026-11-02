-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483647, 'hria2ypu', 882.963176, 841.297061, 'rwbbp');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (2, 'rhs_715289', 1.0, 1.0, 'rhs_145b4e');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (3, 'luhvdltti', 182.319045, 998.421621, 'prmd');

-- Inserting into table: entrepreneur --
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1, 1, 'lhs_5dcabe', 1.0, 'lhs_def698');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483647, 1, 'lhs_e5313f', 1.0, 'lhs_526618');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (3, 1, 'lhs_e5313f', 1.0, 'lhs_526618');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, LHS.name AS name, LHS.height AS height, LHS.weight AS weight, LHS.date_of_birth AS date_of_birth FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM entrepreneur AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) AS LHS INNER JOIN (SELECT MAX(height) AS height FROM people) AS RHS ON (LHS.height = RHS.height)) ORDER BY company;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('lhs_e5313f',)
*/