-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Alice', 170.0, 65.0, '1980-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Bob', 180.0, 80.0, '1985-05-12');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (3, 'Charlie', 175.0, 70.0, '1990-09-23');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (10, 1, 'Zeta Corp', 100000.0, 'InvA');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (20, 2, 'Alpha Inc', 50000.0, 'InvB');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (30, 3, 'Alpha Inc', 75000.0, 'InvC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM entrepreneur ORDER BY company, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Alpha Inc',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT Company FROM entrepreneur ORDER BY Money_Requested DESC, entrepreneur.entrepreneur_id NULLS LAST;

/*
Prediction Result:
('Zeta Corp',)
('Alpha Inc',)
('Alpha Inc',)
*/