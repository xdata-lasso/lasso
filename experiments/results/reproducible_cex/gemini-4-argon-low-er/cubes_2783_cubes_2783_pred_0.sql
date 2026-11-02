-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Alice', 170.0, 60.0, '1990-01-01');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (1, 1, 'Alpha', 100.0, 'InvA');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (2, 1, 'Beta', 200.0, 'InvB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM entrepreneur ORDER BY company, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
*/

-- Prediction Query
SELECT Company FROM entrepreneur ORDER BY Money_Requested DESC, entrepreneur.entrepreneur_id NULLS LAST;

/*
Prediction Result:
('Beta',)
('Alpha',)
*/