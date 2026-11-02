-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 8
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Henry', 178.0, 77.0, '1987-04-04');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 1, '20 Days Media', 500.0, 'Seed');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 1, '100 Days Media', 1500.0, 'Series A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM entrepreneur AS LHS WHERE EXISTS(SELECT 1 FROM people AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY company) LIMIT 1);

/*
Gold Result:
('100 Days Media',)
*/

-- Prediction Query
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('20 Days Media',)
*/