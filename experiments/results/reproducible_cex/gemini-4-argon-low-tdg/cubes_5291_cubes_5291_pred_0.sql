-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests multiple distinct count tiers (1, 1, 2, 2, 3), out-of-order names vs counts, DISTINCT requirement, and ORDER BY.
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Person 1', 180.0, 75.0, '1980-01-01');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (2, 'Person 2', 175.0, 70.0, '1985-05-05');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (1, 1, 'CompA', 100.0, 'Zack');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (2, 2, 'CompB', 200.0, 'Yan');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (3, 1, 'CompC', 150.0, 'Bob');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (4, 1, 'CompD', 250.0, 'Bob');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (5, 2, 'CompE', 300.0, 'Charlie');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (6, 2, 'CompF', 350.0, 'Charlie');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (7, 1, 'CompG', 400.0, 'Alice');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (8, 2, 'CompH', 450.0, 'Alice');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (9, 1, 'CompI', 500.0, 'Alice');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor_other AS investor FROM (SELECT LHS.investor AS investor, LHS.maxn AS maxn, RHS.investor AS investor_other, RHS.maxn AS maxn_other FROM (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS LHS CROSS JOIN (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS RHS) WHERE (maxn < maxn_other) ORDER BY investor;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/