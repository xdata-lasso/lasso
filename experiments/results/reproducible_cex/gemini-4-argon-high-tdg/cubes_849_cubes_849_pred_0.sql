-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Alice Smith', 185.5, 80.0, 'Boston');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Bob Jones', 170.0, 70.0, 'Seattle');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (3, 'Charlie Brown', 170.0, 65.0, 'Austin');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (4, 'Diana Prince', 160.0, 90.0, 'Miami');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (4, 1, '10-May', 2005.0, 'Mall', 'USA', 2, 5);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (10, 1, '12-Jun', 2008.0, 'Station', 'USA', 1, 3);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (11, 2, '03-Sep', 2010.0, 'Square', 'UK', 4, 10);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (12, 3, '21-Nov', 2012.0, 'Park', 'Canada', 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY height;

/*
Gold Result:
(170.0,)
(170.0,)
(185.5,)
*/

-- Prediction Query
SELECT T1.Height FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Injured DESC, T1.people_id NULLS LAST, T2.perpetrator_id NULLS LAST;

/*
Prediction Result:
(170.0,)
(185.5,)
(185.5,)
(170.0,)
*/