-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (1, 'John', 'USA', 'T', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (2, 'Mary', 'UK', 'F', 28);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (3, 'Peter', 'Canada', 'T', 35);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (4, 'Alice', 'USA', 'F', 25);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'Zion Chapel', 'Alice', 1900, 'Alpha Church');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'Bethel Church', 'Zach', 2010, 'Omega Church');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (3, 'Bethel Church', 'Bob', 1950, 'Beta Church');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (4, 'Grace Cathedral', 'Charlie', 1850, 'Delta Church');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 2, 2015);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 3, 4, 2018);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 1, 4, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM church ORDER BY name, church.church_id NULLS LAST;

/*
Gold Result:
('Bethel Church',)
('Bethel Church',)
('Grace Cathedral',)
('Zion Chapel',)
*/

-- Prediction Query
SELECT name FROM church ORDER BY open_date DESC, church.church_id NULLS LAST;

/*
Prediction Result:
('Bethel Church',)
('Bethel Church',)
('Zion Chapel',)
('Grace Cathedral',)
*/