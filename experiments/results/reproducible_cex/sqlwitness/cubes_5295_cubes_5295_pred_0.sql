-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, date_of_birth) VALUES (1, 'default2', 1.0, 1.0, 'default1'), (0, 'default1', 1.0, 0.0, NULL), (2, NULL, 1.0, NULL, 'default1'), (3, 'default1', 1.0, 1.0, NULL), (4, 'default1', 1.0, NULL, 'default1'), (5, 'default1', 1.0, NULL, 'default1'), (6, NULL, 0.0, 1.0, 'default2');
INSERT INTO entrepreneur (entrepreneur_id, people_id, company, money_requested, investor) VALUES (1, 0, 'default2', NULL, 'default1'), (0, 2, NULL, 1.0, NULL), (2, 6, 'default1', NULL, NULL), (3, 1, 'default2', NULL, NULL), (4, NULL, 'default1', 0.0, NULL), (5, 5, 'default2', 0.0, 'default2'), (6, 2, NULL, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, company FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.height AS height, LHS.weight AS weight, LHS.date_of_birth AS date_of_birth, RHS.entrepreneur_id AS entrepreneur_id, RHS.people_id AS people_id_other, RHS.company AS company, RHS.money_requested AS money_requested, RHS.investor AS investor FROM people AS LHS CROSS JOIN entrepreneur AS RHS) WHERE (people_id = people_id_other) ORDER BY name, company NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, None)
(None, None)
('default1', 'default2')
('default1', 'default2')
('default2', 'default2')
*/

-- Prediction Query
SELECT T2.Name, T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Money_Requested, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
('default1', 'default2')
(None, 'default1')
('default2', 'default2')
('default1', 'default2')
(None, None)
(None, None)
*/