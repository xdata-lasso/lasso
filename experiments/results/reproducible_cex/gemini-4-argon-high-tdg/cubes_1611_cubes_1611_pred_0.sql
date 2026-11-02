-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (1, 'John', 'USA', 'T', 35);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (2, 'Alice', 'UK', 'F', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (3, 'Robert', 'Canada', 'T', 40);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (4, 'Diana', 'USA', 'F', 28);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (20, 'Bethany', 'Bishop A', 2010, 'Old Bethany');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (50, 'St. Mary', 'Father Z', 1920, 'St. Anne');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (10, 'Aaron Chapel', 'Pastor B', 1800, 'First Chapel');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (40, 'All Souls', 'Rev. C', 1980, 'None');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (5, 'Zwingli Church', 'Elder D', 1999, 'Reformed');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (30, 'Zion', 'Deacon E', 1950, 'Mount Zion');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (40, 1, 2, 2000);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (40, 3, 4, 2005);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (30, 1, 4, 2010);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (20, 1, 2, 2011);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (20, 3, 4, 2012);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (20, 3, 2, 2015);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (10, 1, 2, 1990);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_date FROM (SELECT * FROM (SELECT * FROM church ORDER BY church_id DESC) LIMIT 3);

/*
Gold Result:
('St. Mary', 1920)
('All Souls', 1980)
('Zion', 1950)
*/

-- Prediction Query
SELECT name, open_date FROM church ORDER BY open_date DESC, church.church_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('Bethany', 2010)
('Zwingli Church', 1999)
('All Souls', 1980)
*/