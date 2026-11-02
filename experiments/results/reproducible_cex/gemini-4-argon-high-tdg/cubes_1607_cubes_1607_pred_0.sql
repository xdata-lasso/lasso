-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (1, 'John', 'USA', 'T', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (2, 'Alice', 'USA', 'F', 28);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (3, 'Bob', 'UK', 'T', 35);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (4, 'Clara', 'UK', 'F', 32);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'St. Peter', 'John', 1920, 'Old St. Peter');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'Grace', 'Zack', 1950, 'Grace Original');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (3, 'Grace', 'Adam', 1850, 'Early Grace');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (4, 'Alpha', 'Bishop', 2000, 'Alpha One');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (5, 'Grace', 'Mary', 1900, 'Middle Grace');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 2, 2010);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 3, 4, 2012);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (2, 1, 4, 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_date, organized_by FROM church ORDER BY name, church.church_id NULLS LAST;

/*
Gold Result:
('Alpha', 2000, 'Bishop')
('Grace', 1950, 'Zack')
('Grace', 1850, 'Adam')
('Grace', 1900, 'Mary')
('St. Peter', 1920, 'John')
*/

-- Prediction Query
SELECT name, open_date, organized_by FROM Church;

/*
Prediction Result:
('St. Peter', 1920, 'John')
('Grace', 1950, 'Zack')
('Grace', 1850, 'Adam')
('Alpha', 2000, 'Bishop')
('Grace', 1900, 'Mary')
*/