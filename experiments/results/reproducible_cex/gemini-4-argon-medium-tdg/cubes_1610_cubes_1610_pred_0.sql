-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (1, 'M1', 'US', 'T', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (2, 'M2', 'US', 'T', 35);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (10, 'F10', 'US', 'F', 28);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (20, 'F20', 'US', 'F', 25);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (30, 'F30', 'US', 'F', 22);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'C1', 'Org1', 1990, 'None');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'C2', 'Org2', 2000, 'None');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2016, 'C2016', 'Org3', 2016, 'None');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 20, 2020);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 2, 20, 2021);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 10, 2020);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 1, 30, 2020);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2016, 1, 10, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT female_id AS count__distinct_church_id_ FROM (SELECT church_id, female_id, COUNT(DISTINCT church_id) AS n_distinct FROM wedding GROUP BY church_id, female_id) WHERE (church_id <> 2016 AND n_distinct = church_id) ORDER BY count__distinct_church_id_;

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT church_id) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(0,)
*/