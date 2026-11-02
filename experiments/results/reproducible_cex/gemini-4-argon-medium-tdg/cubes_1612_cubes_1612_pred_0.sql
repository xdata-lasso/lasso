-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, 'Grace Church', 'John', 1950, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'St. Mary', 'Peter', 1950, 'Grace Church');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (3, 'Trinity', 'Paul', 1920, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (4, 'Hope Chapel', 'Luke', 1980, 'Trinity');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_date, n AS count___ FROM (SELECT church_id, open_date, COUNT(*) AS n FROM church GROUP BY church_id, open_date) ORDER BY open_date, count___ NULLS LAST;

/*
Gold Result:
(1920, 1)
(1950, 1)
(1950, 1)
(1980, 1)
*/

-- Prediction Query
SELECT open_date, COUNT(*) FROM church GROUP BY open_date;

/*
Prediction Result:
(1920, 1)
(1950, 2)
(1980, 1)
*/