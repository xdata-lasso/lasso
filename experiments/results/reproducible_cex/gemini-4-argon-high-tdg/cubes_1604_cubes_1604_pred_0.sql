-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (10, 'Zane', 'USA', 'T', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (15, 'Yara', 'Canada', 'F', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (20, 'Xander', 'Mexico', 'T', 29);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (25, 'Will', 'Brazil', 'T', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (30, 'Vera', 'UK', 'T', 31);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (35, 'Uma', 'France', NULL, 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (40, 'Adam', 'Argentina', 'T', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (45, 'Bella', 'Spain', 'T', NULL);
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, 'St. Mary', 'Diocese', 1990, NULL);
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'Grace Chapel', 'Parish', 2005, 'St. Mary');
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (1, 10, 15, 2015);
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (2, 10, 15, 2020);
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (1, 25, 15, 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "people_id" AS "count___" FROM (SELECT "people_id", "name", "country", "is_male", "age", COUNT(*) OVER () AS "n" FROM "people") WHERE ("is_male" <> 'F' AND age = 30) ORDER BY count___;

/*
Gold Result:
(10,)
(25,)
(40,)
*/

-- Prediction Query
SELECT COUNT(*) FROM people WHERE is_male = 'F' AND age > 30;

/*
Prediction Result:
(0,)
*/