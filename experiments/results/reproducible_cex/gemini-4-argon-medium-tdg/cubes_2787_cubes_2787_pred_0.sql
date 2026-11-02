-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'John Doe', 180.0, 75.0, '1980-01-01');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Jane Smith', 165.0, 60.0, '1985-05-05');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 1, 'Zeta Corp', 500000.0, 'Investor X');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 2, 'Beta LLC', 250000.0, 'Investor A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM entrepreneur AS LHS WHERE EXISTS(SELECT 1 FROM people AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY company) LIMIT 1);

/*
Gold Result:
('Beta LLC',)
*/

-- Prediction Query
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Corp',)
*/