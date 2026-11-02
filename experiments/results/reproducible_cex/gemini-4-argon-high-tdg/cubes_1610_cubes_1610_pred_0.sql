-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (10, 'John', 'USA', 'T', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (20, 'Bob', 'UK', 'T', 35);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (30, 'Charlie', 'Canada', 'T', 40);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (100, 'Alice', 'USA', 'F', 28);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (200, 'Diana', 'UK', 'F', 32);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (300, 'Eve', 'Canada', 'F', 26);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (400, 'Grace', 'France', 'F', 29);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'First Parish', 'Council A', 1990, 'None');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'Second Parish', 'Council B', 2000, 'None');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2016, 'Millennium Church', 'Council C', 2016, 'None');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 10, 300, 2016);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 20, 100, 2015);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 30, 100, 2018);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 10, 200, 2015);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 20, 200, 2017);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2016, 10, 400, 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT female_id AS count__distinct_church_id_ FROM (SELECT church_id, female_id, COUNT(DISTINCT church_id) AS n_distinct FROM wedding GROUP BY church_id, female_id) WHERE (church_id <> 2016 AND n_distinct = church_id) ORDER BY count__distinct_church_id_;

/*
Gold Result:
(100,)
(300,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT church_id) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(1,)
*/