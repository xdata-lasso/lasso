-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (9, '1', '1', '1', 1);
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (8, '1', '1', '1', 1);
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (11, '1', '1', 1, '1');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (10, '1', '1', 1, '1');
INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (10, 8, 9, 2018);
INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (10, 8, 8, 2017);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT YEAR, COUNT(*) AS n FROM wedding GROUP BY YEAR) WHERE (YEAR >= 2016 OR n > 2016) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(0,)
*/