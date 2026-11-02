-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1054, 'Jessica Silva', 1055.5, 1056.5, 'chair');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1059, 'Ethan Adams', 1056.5, 1057.5, 'development');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1057, 1054, 'Robinson-Bright', 1058.5, 'individual');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1062, 1059, 'Walter, Edwards and Rios', 1063.5, 'everyone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, company FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.height AS height, LHS.weight AS weight, LHS.date_of_birth AS date_of_birth, RHS.entrepreneur_id AS entrepreneur_id, RHS.people_id AS people_id_other, RHS.company AS company, RHS.money_requested AS money_requested, RHS.investor AS investor FROM people AS LHS CROSS JOIN entrepreneur AS RHS) WHERE (people_id = people_id_other) ORDER BY name, company NULLS LAST;

/*
Gold Result:
('Ethan Adams', 'Walter, Edwards and Rios')
('Jessica Silva', 'Robinson-Bright')
*/

-- Prediction Query
SELECT T2.Name, T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Money_Requested, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
('Jessica Silva', 'Robinson-Bright')
('Ethan Adams', 'Walter, Edwards and Rios')
*/