-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Alice Smith', 165.5, 60.0, '1985-04-12');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Bob Jones', 180.0, 82.5, '1978-09-23');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (3, 'Charlie Brown', 172.0, 70.0, '1990-01-15');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (4, 'Diana Prince', 175.0, 65.0, '1988-11-03');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (5, 'Evan Wright', 168.0, 68.0, '1992-06-30');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (6, 'Fiona Gallagher', 160.0, 55.0, '1995-03-19');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 1, 'TechCorp', 150000.0, 'Zeta Ventures');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 2, 'BioHealth', 140000.0, 'Alpha Capital');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (3, 3, 'GreenEnergy', 200000.0, 'Alpha Capital');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (4, 4, 'EduSoft', 139999.99, 'Beta Partners');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (5, 5, 'FinServe', 120000.0, 'Gamma Fund');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (6, 6, 'RetailHub', 100000.0, 'Delta Group');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT investor FROM entrepreneur WHERE (money_requested >= 140000.0 AND money_requested <> 120000.0) ORDER BY investor, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('Alpha Capital',)
('Alpha Capital',)
('Zeta Ventures',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur WHERE Money_Requested > 140000 INTERSECT SELECT Investor FROM entrepreneur WHERE Money_Requested < 120000;

/*
Prediction Result:
*/