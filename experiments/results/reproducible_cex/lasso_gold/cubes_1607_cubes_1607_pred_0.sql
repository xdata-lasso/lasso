-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1006, 'Brandon Davis', 'Henderson, Ramirez and Lewis', 1007, 'fall');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1008, 'Alyssa Gonzalez', 'Miles, Barnes and Cole', 1008, 'source');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_date, organized_by FROM church ORDER BY name, church.church_id NULLS LAST;

/*
Gold Result:
('Alyssa Gonzalez', 1008, 'Miles, Barnes and Cole')
('Brandon Davis', 1007, 'Henderson, Ramirez and Lewis')
*/

-- Prediction Query
SELECT name, open_date, organized_by FROM Church;

/*
Prediction Result:
('Brandon Davis', 1007, 'Henderson, Ramirez and Lewis')
('Alyssa Gonzalez', 1008, 'Miles, Barnes and Cole')
*/