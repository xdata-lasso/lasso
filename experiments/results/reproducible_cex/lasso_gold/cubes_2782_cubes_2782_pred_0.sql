-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1001, 'Allison Hill', 1002.5, 1003.5, 'dog');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1004, 1001, 'Doyle Ltd', 140000.0, 'sit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT investor FROM entrepreneur WHERE (money_requested >= 140000.0 AND money_requested <> 120000.0) ORDER BY investor, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('sit',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur WHERE Money_Requested > 140000 INTERSECT SELECT Investor FROM entrepreneur WHERE Money_Requested < 120000;

/*
Prediction Result:
*/