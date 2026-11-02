-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (7, '12', '12', '12', 12);
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (9, '11', '12', -145, NULL);
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (8, '11', '12', -635, NULL);
INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (8, 7, 7, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organized_by, name FROM church WHERE (open_date < 1830 OR open_date <= 1840) ORDER BY organized_by, church.church_id NULLS LAST;

/*
Gold Result:
('12', '11')
('12', '11')
*/

-- Prediction Query
SELECT organized_by, name FROM church WHERE open_date BETWEEN 1830 AND 1840;

/*
Prediction Result:
*/