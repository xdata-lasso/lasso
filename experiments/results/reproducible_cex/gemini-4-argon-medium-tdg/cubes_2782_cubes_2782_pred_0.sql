-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'John Doe', 180.0, 75.0, '1980-01-01');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 1, 'CompA', 140000.0, 'Investor Exact');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 1, 'CompB', 139999.99, 'Investor Below');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (3, 1, 'CompC', 140000.01, 'Investor Above');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (4, 1, 'CompD', 120000.0, 'Investor 120k');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (5, 1, 'CompE', 100000.0, 'Investor Low');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (6, 1, 'CompF', NULL, 'Investor NullMoney');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT investor FROM entrepreneur WHERE (money_requested >= 140000.0 AND money_requested <> 120000.0) ORDER BY investor, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('Investor Above',)
('Investor Exact',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur WHERE Money_Requested > 140000 INTERSECT SELECT Investor FROM entrepreneur WHERE Money_Requested < 120000;

/*
Prediction Result:
*/