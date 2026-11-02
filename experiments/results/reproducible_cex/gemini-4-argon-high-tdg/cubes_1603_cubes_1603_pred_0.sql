-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (1, 'John Doe', 'USA', 'T', 35);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (2, 'Jane Roe', 'USA', 'F', 30);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (3, 'Mark Twain', 'UK', 'T', 40);
INSERT INTO people (People_ID, Name, Country, Is_Male, Age) VALUES (4, 'Mary Shelley', 'UK', 'F', 28);
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'St. Paul', 'Wesley', 1829, 'Old St. Paul');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'Grace Chapel', 'Calvin', 1830, 'First Grace');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (3, 'Trinity Church', 'Luther', 1835, 'Old Trinity');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (4, 'Bethel Mission', 'Knox', 1840, 'Bethel East');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (5, 'New Hope', 'Zwingli', 1841, 'Hope Chapel');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (6, 'Modern Cathedral', 'cranmer', 1850, 'Ancient Cathedral');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (7, 'Unknown Parish', 'Fox', NULL, 'Mystery Parish');
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 1, 2, 1831);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (1, 3, 4, 1832);
INSERT INTO wedding (Church_ID, Male_ID, Female_ID, Year) VALUES (5, 1, 4, 1845);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organized_by, name FROM church WHERE (open_date < 1830 OR open_date <= 1840) ORDER BY organized_by, church.church_id NULLS LAST;

/*
Gold Result:
('Calvin', 'Grace Chapel')
('Knox', 'Bethel Mission')
('Luther', 'Trinity Church')
('Wesley', 'St. Paul')
*/

-- Prediction Query
SELECT organized_by, name FROM church WHERE open_date BETWEEN 1830 AND 1840;

/*
Prediction Result:
('Calvin', 'Grace Chapel')
('Luther', 'Trinity Church')
('Knox', 'Bethel Mission')
*/