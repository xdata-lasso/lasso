-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1044, 'Timothy Wong', 1045.5, 1046.5, 'politics');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1054, NULL, NULL, NULL, NULL);
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1047, 1044, 'Jackson, Daniel and Martin', 1048.5, 'hundred');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1049, 1054, 'Jackson, Daniel and Martin', 1048.5, 'hundred');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM entrepreneur AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
(None,)
('Timothy Wong',)
*/

-- Prediction Query
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('Timothy Wong',)
(None,)
*/