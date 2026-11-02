-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (1, 'John', 'USA', 'T', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (2, 'Mike', 'UK', 'T', 35);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (3, 'Alice', 'USA', 'F', 28);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (4, 'Sara', 'UK', 'F', 32);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (5, 'Unused Person', 'Canada', 'F', 25);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'St. Mary', 'Diocese', 2010, 'None');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'Grace Chapel', 'Community', 2018, 'St. Mary');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (3, 'Unused Church', 'State', 2020, 'None');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 1, 3, 2014);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 1, 4, 2015);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 2, 3, 2015);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 3, 2016);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 4, 2016);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 2, 3, 2016);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 2, 4, 2017);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 2, 4, 2018);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (3, 1, 3, 2018);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (3, 1, 4, 2019);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (3, 2, 4, 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT YEAR, COUNT(*) AS n FROM wedding GROUP BY YEAR) WHERE (YEAR >= 2016 OR n > 2016) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(3,)
*/