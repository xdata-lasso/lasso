-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, date_of_birth) VALUES (1, 'default2', 1.0, 1.0, 'default2'), (0, NULL, 2.0, NULL, 'default1'), (2, 'default2', 2.0, 0.0, 'default2'), (3, NULL, 2.0, 1.0, 'default1'), (4, 'default1', 2.0, 1.0, 'default2'), (5, 'default2', 0.0, 2.0, 'default2'), (6, NULL, 1.0, 2.0, NULL), (7, 'default1', 1.0, 2.0, 'default1');
INSERT INTO entrepreneur (entrepreneur_id, people_id, company, money_requested, investor) VALUES (0, 1, 'default1', NULL, 'default2'), (1, 7, 'default1', NULL, NULL), (2, 2, 'default1', 0.0, NULL), (3, 2, 'default2', 2.0, 'default2'), (4, 3, 'default1', 2.0, 'default1'), (5, NULL, NULL, 2.0, 'default2'), (6, 4, 'default2', 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM entrepreneur AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM entrepreneur);

/*
Prediction Result:
*/