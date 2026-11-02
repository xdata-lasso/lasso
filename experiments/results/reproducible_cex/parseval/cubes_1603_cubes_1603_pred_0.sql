-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: church --
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1, 'chu_88828e', 'chu_35ebc6', 0, '5k5swwqcgs');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (2, 'chu_88828e', 'chu_35ebc6', 0, '9n8');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (3, 'chu_88828e', 'chu_35ebc6', 0, '4');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (4, '5k5swwqcgs', '9n8', 1830, '4');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (5, 'gu7v', 'e4', 1841, 'hria2ypuzhs');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (6, 'rwbbp6luhvd', 'tti', NULL, 'bnp');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (7, 'mdpos', 'ie5', NULL, 'nw6klf');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (8, 'a9000t5c4eci', 'gce376nium52', NULL, 'zbuo4nrqrof');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (9, 'qyp5s5bbp0', '2eutliqa11r', NULL, 'ytoo3o9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organized_by, name FROM church WHERE (open_date < 1830 OR open_date <= 1840) ORDER BY organized_by, church.church_id NULLS LAST;

/*
Gold Result:
('9n8', '5k5swwqcgs')
('chu_35ebc6', 'chu_88828e')
('chu_35ebc6', 'chu_88828e')
('chu_35ebc6', 'chu_88828e')
*/

-- Prediction Query
SELECT organized_by, name FROM church WHERE open_date BETWEEN 1830 AND 1840;

/*
Prediction Result:
('9n8', '5k5swwqcgs')
*/