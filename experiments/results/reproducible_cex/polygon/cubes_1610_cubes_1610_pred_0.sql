-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (13, '1', '1', '1', 1);
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (1, '1', '1', '1', 1);
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1, '1', '1', 1, '1');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (8, '1', '1', 1, '1');
INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, 1, 13, 2016);
INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, 1, 1, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT female_id AS count__distinct_church_id_ FROM (SELECT church_id, female_id, COUNT(DISTINCT church_id) AS n_distinct FROM wedding GROUP BY church_id, female_id) WHERE (church_id <> 2016 AND n_distinct = church_id) ORDER BY count__distinct_church_id_;

/*
Gold Result:
(1,)
(13,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT church_id) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(1,)
*/