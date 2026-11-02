-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, date_of_birth) VALUES (2, NULL, 0.0, NULL, NULL);
INSERT INTO entrepreneur (entrepreneur_id, people_id, company, money_requested, investor) VALUES (0, 2, 'default2', 1.0, 'default1'), (2, 2, 'default2', 1.0, 'default2'), (1, NULL, NULL, 0.0, 'default2'), (3, NULL, NULL, NULL, 'default1'), (4, NULL, 'default1', 2.0, 'default1'), (5, NULL, NULL, 0.0, 'default1'), (6, NULL, 'default2', 1.0, 'default2'), (7, NULL, 'default2', NULL, NULL), (8, NULL, 'default2', 1.0, 'default2'), (9, 2, NULL, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor_other AS investor FROM (SELECT LHS.investor AS investor, LHS.maxn AS maxn, RHS.investor AS investor_other, RHS.maxn AS maxn_other FROM (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS LHS CROSS JOIN (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS RHS) WHERE (maxn < maxn_other) ORDER BY investor;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/