-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Alice', 170.0, 65.0, '1980-01-01');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (1, 1, 'CompA', 120000.0, 'Inv_120k');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (2, 1, 'CompB', 139999.9, 'Inv_JustBelow');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (3, 1, 'CompC', 140000.0, 'Inv_Exact');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (4, 1, 'CompD', 150000.0, 'Inv_Above');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (5, 1, 'CompE', NULL, 'Inv_NullMoney');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT investor FROM entrepreneur WHERE (money_requested >= 140000.0 AND money_requested <> 120000.0) ORDER BY investor, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('Inv_Above',)
('Inv_Exact',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur WHERE Money_Requested > 140000 INTERSECT SELECT Investor FROM entrepreneur WHERE Money_Requested < 120000;

/*
Prediction Result:
*/