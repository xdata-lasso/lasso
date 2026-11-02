-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE boundary conditions (1829, 1830, 1835, 1840, 1841, NULL) and primary ORDER BY
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, 'First Parish', 'Smith', 1829, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'Second Parish', 'Adams', 1830, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (3, 'Third Parish', 'Baker', 1835, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (4, 'Fourth Parish', 'Clark', 1840, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (5, 'Fifth Parish', 'Davis', 1841, 'None');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (6, 'Sixth Parish', 'Evans', NULL, 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organized_by, name FROM church WHERE (open_date < 1830 OR open_date <= 1840) ORDER BY organized_by, church.church_id NULLS LAST;

/*
Gold Result:
('Adams', 'Second Parish')
('Baker', 'Third Parish')
('Clark', 'Fourth Parish')
('Smith', 'First Parish')
*/

-- Prediction Query
SELECT organized_by, name FROM church WHERE open_date BETWEEN 1830 AND 1840;

/*
Prediction Result:
('Adams', 'Second Parish')
('Baker', 'Third Parish')
('Clark', 'Fourth Parish')
*/