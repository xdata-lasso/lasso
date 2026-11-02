-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Bob', 180.0, 75.0, '1990-01-01');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (2, 'Alice', 165.0, 60.0, '1992-02-02');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (1, NULL, 'TechCorp', 10000.0, 'InvestorA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM entrepreneur AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM entrepreneur);

/*
Prediction Result:
*/