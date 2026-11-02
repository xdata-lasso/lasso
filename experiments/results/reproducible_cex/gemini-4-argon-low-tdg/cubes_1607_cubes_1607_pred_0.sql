-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'Grace Chapel', 'John Doe', 1990, 'Old Grace');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'St. Mary', 'Jane Smith', 1980, 'St. Anne');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (3, 'Grace Chapel', 'John Doe', 1990, 'First Grace');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (4, 'Alpha Ministry', 'Bob Vance', 2005, 'Beta Ministry');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_date, organized_by FROM church ORDER BY name, church.church_id NULLS LAST;

/*
Gold Result:
('Alpha Ministry', 2005, 'Bob Vance')
('Grace Chapel', 1990, 'John Doe')
('Grace Chapel', 1990, 'John Doe')
('St. Mary', 1980, 'Jane Smith')
*/

-- Prediction Query
SELECT name, open_date, organized_by FROM Church;

/*
Prediction Result:
('Grace Chapel', 1990, 'John Doe')
('St. Mary', 1980, 'Jane Smith')
('Grace Chapel', 1990, 'John Doe')
('Alpha Ministry', 2005, 'Bob Vance')
*/