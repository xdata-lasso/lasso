-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, 'First Parish', 'Founder A', 1900, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'Second Parish', 'Founder B', 1900, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (3, 'Third Parish', 'Founder C', 1850, 'First Parish');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (4, 'Fourth Parish', 'Founder D', 1950, 'Second Parish');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_date, n AS count___ FROM (SELECT church_id, open_date, COUNT(*) AS n FROM church GROUP BY church_id, open_date) ORDER BY open_date, count___ NULLS LAST;

/*
Gold Result:
(1850, 1)
(1900, 1)
(1900, 1)
(1950, 1)
*/

-- Prediction Query
SELECT open_date, COUNT(*) FROM church GROUP BY open_date;

/*
Prediction Result:
(1850, 1)
(1900, 2)
(1950, 1)
*/