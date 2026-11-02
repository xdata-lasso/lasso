-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, date_of_birth) VALUES (0, NULL, 0.0, 1.0, 'default2');
INSERT INTO entrepreneur (entrepreneur_id, people_id, company, money_requested, investor) VALUES (0, 0, NULL, NULL, NULL), (1, NULL, NULL, 1.0, 'default2'), (2, 0, NULL, 0.0, 'default2'), (3, 0, 'default1', 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM entrepreneur ORDER BY company, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT Company FROM entrepreneur ORDER BY Money_Requested DESC, entrepreneur.entrepreneur_id NULLS LAST;

/*
Prediction Result:
(None,)
('default1',)
(None,)
(None,)
*/