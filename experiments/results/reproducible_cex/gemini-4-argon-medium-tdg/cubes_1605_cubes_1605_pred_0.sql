-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (3, 'Grace Chapel', 'Pastor John', 1980, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, 'Beta Church', 'Rev. Smith', 1950, 'Alpha Church');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'Alpha Church', 'Bishop Brown', 1920, 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM church ORDER BY name, church.church_id NULLS LAST;

/*
Gold Result:
('Alpha Church',)
('Beta Church',)
('Grace Chapel',)
*/

-- Prediction Query
SELECT name FROM church ORDER BY open_date DESC, church.church_id NULLS LAST;

/*
Prediction Result:
('Grace Chapel',)
('Beta Church',)
('Alpha Church',)
*/