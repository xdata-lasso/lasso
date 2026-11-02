-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (3, NULL, 'Founder A', 2000, 'Cont A');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, NULL, 'Founder B', 1995, 'Cont B');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'Beta Church', NULL, NULL, NULL);
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (4, 'Alpha Church', 'Founder C', 0, '');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_date, organized_by FROM church ORDER BY name, church.church_id NULLS LAST;

/*
Gold Result:
(None, 1995, 'Founder B')
(None, 2000, 'Founder A')
('Alpha Church', 0, 'Founder C')
('Beta Church', None, None)
*/

-- Prediction Query
SELECT name, open_date, organized_by FROM Church;

/*
Prediction Result:
(None, 1995, 'Founder B')
('Beta Church', None, None)
(None, 2000, 'Founder A')
('Alpha Church', 0, 'Founder C')
*/