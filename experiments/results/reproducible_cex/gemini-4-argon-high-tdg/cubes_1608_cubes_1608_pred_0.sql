-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'First Parish', 'John Eliot', 1849, 'Old Parish');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (2, 'Second Parish', 'Cotton Mather', 1850, 'First Parish');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (3, 'Third Parish', 'Increase Mather', 1850, 'Second Parish');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (4, 'Fourth Parish', 'Samuel Willard', 1851, 'Third Parish');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (5, 'Fifth Parish', 'Thomas Bridge', 1851, 'Fourth Parish');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (6, 'Sixth Parish', 'Benjamin Wadsworth', 1851, 'Fifth Parish');
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (7, 'Seventh Parish', 'Thomas Foxcroft', 1851, 'Sixth Parish');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM church WHERE (open_date <> 1850))) ORDER BY count___;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Church WHERE Open_Date < 1850;

/*
Prediction Result:
(1,)
*/