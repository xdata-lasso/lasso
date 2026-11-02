-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1003, 'Kimberly Garza', 'Johnson and Sons', 1004, 'early');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1005, NULL, 'Miles, Barnes and Cole', 1006, 'fall');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1007, 'Abigail Shaffer', 'Henderson, Ramirez and Lewis', 1006, 'source');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_date, n AS count___ FROM (SELECT church_id, open_date, COUNT(*) AS n FROM church GROUP BY church_id, open_date) ORDER BY open_date, count___ NULLS LAST;

/*
Gold Result:
(1004, 1)
(1006, 1)
(1006, 1)
*/

-- Prediction Query
SELECT open_date, COUNT(*) FROM church GROUP BY open_date;

/*
Prediction Result:
(1004, 1)
(1006, 2)
*/