-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, date_of_birth) VALUES (1, NULL, 2.0, NULL, NULL), (0, 'default2', 0.0, 0.0, NULL);
INSERT INTO entrepreneur (entrepreneur_id, people_id, company, money_requested, investor) VALUES (1, NULL, NULL, 1.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.people_id AS people_id_other FROM entrepreneur AS LHS INNER JOIN (SELECT people_id, COUNT(*) AS n FROM entrepreneur GROUP BY people_id) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY investor;

/*
Gold Result:
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/