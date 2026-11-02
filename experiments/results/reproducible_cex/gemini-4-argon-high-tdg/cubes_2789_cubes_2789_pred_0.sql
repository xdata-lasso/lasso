-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Alice Smith', 1.65, 58.0, '1985-06-15');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (2, 'Charlie Brown', 1.88, 72.0, '1970-01-10');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (3, 'Bob Jones', 1.75, 85.0, '1995-12-01');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (4, 'Diana Prince', 1.78, 65.0, '1980-03-22');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (5, 'Evan Wright', 1.80, 78.0, '1965-11-05');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (1, 4, 'Wonder Corp', 120000.0, 'Duncan Bannatyne');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (2, 1, 'Alpha Tech', 250000.0, 'Simon Woodroffe');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (3, 3, 'Beta Solutions', 50000.0, 'Peter Jones');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (4, 2, 'Gamma Foods', 150000.0, 'Simon Woodroffe');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (5, 4, 'Delta Retail', 80000.0, 'Deborah Meaden');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_birth" FROM (SELECT "LHS"."entrepreneur_id" AS "entrepreneur_id", "LHS"."people_id" AS "people_id", "LHS"."company" AS "company", "LHS"."money_requested" AS "money_requested", "LHS"."investor" AS "investor", "LHS"."name" AS "name", "LHS"."height" AS "height", "LHS"."weight" AS "weight", "LHS"."date_of_birth" AS "date_of_birth" FROM (SELECT "LHS"."entrepreneur_id" AS "entrepreneur_id", "LHS"."people_id" AS "people_id", "LHS"."company" AS "company", "LHS"."money_requested" AS "money_requested", "LHS"."investor" AS "investor", "RHS"."name" AS "name", "RHS"."height" AS "height", "RHS"."weight" AS "weight", "RHS"."date_of_birth" AS "date_of_birth" FROM "entrepreneur" AS "LHS" INNER JOIN "people" AS "RHS" ON ("LHS"."people_id" = "RHS"."people_id")) AS "LHS" INNER JOIN (SELECT * FROM "entrepreneur" WHERE ("investor" = 'Simon Woodroffe' OR "investor" = 'Peter Jones')) AS RHS ON (LHS.entrepreneur_id = RHS.entrepreneur_id AND LHS.people_id = RHS.people_id AND LHS.company = RHS.company AND LHS.money_requested = RHS.money_requested AND LHS.investor = RHS.investor)) ORDER BY date_of_birth, "date_of_birth" NULLS LAST;

/*
Gold Result:
('1970-01-10',)
('1985-06-15',)
('1995-12-01',)
*/

-- Prediction Query
SELECT T2.Date_of_Birth FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Investor = 'Simon Woodroffe' OR T1.Investor = 'Peter Jones';

/*
Prediction Result:
('1985-06-15',)
('1995-12-01',)
('1970-01-10',)
*/