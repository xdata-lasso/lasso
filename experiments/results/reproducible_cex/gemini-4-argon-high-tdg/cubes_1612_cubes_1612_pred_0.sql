-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (1, 'John', 'USA', 'T', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (2, 'Mary', 'USA', 'F', 28);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (3, 'Paul', 'UK', 'T', 35);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (4, 'Anna', 'UK', 'F', 32);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'Grace Church', 'Founder A', 1950, 'Old Grace');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'Grace Church', 'Founder A', 1850, 'Old Grace');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (3, 'Grace Church', 'Founder A', 1850, 'Old Grace');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 2, 2010);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 3, 4, 2012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_date, n AS count___ FROM (SELECT church_id, open_date, COUNT(*) AS n FROM church GROUP BY church_id, open_date) ORDER BY open_date, count___ NULLS LAST;

/*
Gold Result:
(1850, 1)
(1850, 1)
(1950, 1)
*/

-- Prediction Query
SELECT open_date, COUNT(*) FROM church GROUP BY open_date;

/*
Prediction Result:
(1850, 2)
(1950, 1)
*/