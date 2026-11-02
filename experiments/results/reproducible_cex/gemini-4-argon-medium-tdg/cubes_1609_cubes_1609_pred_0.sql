-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. Empty result set from wedding when all rows fail the WHERE condition.
-- 2. Kills mutations like Year <= 2016, n < 2016, n <= 2016, or removing the WHERE clause entirely.
-- 3. Unreferenced rows in people and church (kills INNER JOIN to people/church if mutated in strange ways, or tests orphan handling).
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (1, 'Bob', 'USA', 'T', 40);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (2, 'Alice', 'USA', 'F', 38);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (3, 'Unmarried', 'USA', 'T', 20);
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, 'First Church', 'State', 1980, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'Empty Church', 'State', 1985, 'None');
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (1, 1, 2, 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT YEAR, COUNT(*) AS n FROM wedding GROUP BY YEAR) WHERE (YEAR >= 2016 OR n > 2016) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(0,)
*/