-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (1, 'John', 'USA', 'T', 30);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (2, 'Jane', 'USA', 'F', 28);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (3, 'Mark', 'UK', 'T', 35);
INSERT INTO "people" ("People_ID", "Name", "Country", "Is_Male", "Age") VALUES (4, 'Mary', 'UK', 'F', 32);
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (1, 'St. Mary', 'Father John', 1849, 'Old Parish');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (2, 'St. Mary', 'Father John', 1849, 'Old Parish');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (3, 'St. Paul', 'Bishop Smith', 1850, 'Ancient Church');
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (4, 'St. Peter', 'Father Luke', 1851, NULL);
INSERT INTO "church" ("Church_ID", "Name", "Organized_by", "Open_Date", "Continuation_of") VALUES (5, 'St. John', 'Father Mark', NULL, 'First Church');
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (1, 1, 2, 1850);
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (1, 3, 4, 1855);
INSERT INTO "wedding" ("Church_ID", "Male_ID", "Female_ID", "Year") VALUES (3, 1, 4, 1860);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM church WHERE (open_date <> 1850))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Church WHERE Open_Date < 1850;

/*
Prediction Result:
(2,)
*/