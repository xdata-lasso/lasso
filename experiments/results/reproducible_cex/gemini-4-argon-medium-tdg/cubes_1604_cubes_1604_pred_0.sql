-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (10, 'John', 'USA', 'T', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (2, 'Bob', 'UK', 'T', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (5, 'Alice', 'Canada', 'F', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (8, 'Charlie', 'USA', 'T', 29);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (9, 'Dave', 'USA', 'T', 31);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (12, 'Eve', 'UK', 'F', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "people_id" AS "count___" FROM (SELECT "people_id", "name", "country", "is_male", "age", COUNT(*) OVER () AS "n" FROM "people") WHERE ("is_male" <> 'F' AND age = 30) ORDER BY count___;

/*
Gold Result:
(2,)
(10,)
*/

-- Prediction Query
SELECT COUNT(*) FROM people WHERE is_male = 'F' AND age > 30;

/*
Prediction Result:
(0,)
*/