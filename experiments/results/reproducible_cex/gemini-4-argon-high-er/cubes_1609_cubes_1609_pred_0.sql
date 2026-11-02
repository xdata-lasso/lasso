-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (1, 'John', 'USA', 'T', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (2, 'Jane', 'USA', 'F', 28);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'St. Mary', 'Org', 1990, 'None');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 2, 2017);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT YEAR, COUNT(*) AS n FROM wedding GROUP BY YEAR) WHERE (YEAR >= 2016 OR n > 2016) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(0,)
*/