-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality boundary (< 1850, = 1850, > 1850) and NULL Open_Date handling.
-- Also tests DISTINCT vs ALL on other columns, and extraneous joins with wedding/people.
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (1, 'John', 'USA', 'T', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (2, 'Jane', 'USA', 'F', 28);
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, 'St. Paul', 'John', 1849, 'Old Paul');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'St. Paul', 'John', 1850, 'Old Paul');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (3, 'St. Paul', 'John', 1851, 'Old Paul');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (4, 'St. Mary', 'Peter', 1851, NULL);
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (5, 'St. Luke', NULL, NULL, 'None');
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (1, 1, 2, 1850);
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (2, 1, 2, 1855);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM church WHERE (open_date <> 1850))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Church WHERE Open_Date < 1850;

/*
Prediction Result:
(1,)
*/