-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO entrepreneur (entrepreneur_id, people_id, company, money_requested, investor) VALUES (1, NULL, 'default2', 0.0, 'default1'), (0, NULL, 'default1', NULL, 'default2'), (2, NULL, NULL, NULL, NULL), (3, NULL, 'default1', 0.0, NULL), (4, NULL, 'default1', 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, investor FROM entrepreneur ORDER BY company, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
(None, None)
('default1', 'default2')
('default1', None)
('default1', 'default1')
('default2', 'default1')
*/

-- Prediction Query
SELECT Company, Investor FROM entrepreneur;

/*
Prediction Result:
('default1', 'default2')
('default2', 'default1')
(None, None)
('default1', None)
('default1', 'default1')
*/