-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (7, '11', '11', '11', 11);
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (6, '11', '11', '11', 11);
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (9, '11', '11', 11, '11');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (8, '11', '11', 11, '11');
INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (9, 6, 6, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_date, n AS count___ FROM (SELECT church_id, open_date, COUNT(*) AS n FROM church GROUP BY church_id, open_date) ORDER BY open_date, count___ NULLS LAST;

/*
Gold Result:
(11, 1)
(11, 1)
*/

-- Prediction Query
SELECT open_date, COUNT(*) FROM church GROUP BY open_date;

/*
Prediction Result:
(11, 2)
*/