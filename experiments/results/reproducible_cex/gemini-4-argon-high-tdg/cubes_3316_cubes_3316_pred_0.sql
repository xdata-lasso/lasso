-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (5, 'David', 190.0, 60.0, '1985-04-12', 'Boston');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (30, 'Bob', 175.5, 75.0, '1992-11-23', 'Chicago');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (10, 'Charlie', 175.5, 85.0, '1988-07-19', 'Austin');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (40, 'Eve', 160.0, 95.0, '1995-01-30', 'Seattle');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (20, 'Alice', 175.5, 65.0, '1990-03-15', 'Denver');
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (1, 5, 140.0, 175.0, 315.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (2, 20, 130.0, 160.0, 290.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height, weight FROM people ORDER BY height, people.people_id NULLS LAST;

/*
Gold Result:
(160.0, 95.0)
(175.5, 85.0)
(175.5, 65.0)
(175.5, 75.0)
(190.0, 60.0)
*/

-- Prediction Query
SELECT Height, Weight FROM people ORDER BY Height DESC, people.people_id NULLS LAST;

/*
Prediction Result:
(190.0, 60.0)
(175.5, 85.0)
(175.5, 65.0)
(175.5, 75.0)
(160.0, 95.0)
*/