-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (1, NULL, NULL, 90.0, '1990-06-15', 'Seattle');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (2, 'Alice', 168.0, 64.0, NULL, 'London');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (3, 'Bob', 182.0, NULL, '1975-03-22', NULL);
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (4, 'Charlie', 177.0, 81.0, NULL, 'Paris');
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (1, 2, 125.0, 150.0, 275.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (2, 3, 160.0, 195.0, 355.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_date FROM people ORDER BY birth_date, people.people_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('1975-03-22',)
('1990-06-15',)
*/

-- Prediction Query
SELECT Birth_Date FROM People ORDER BY Height ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('1990-06-15',)
(None,)
(None,)
('1975-03-22',)
*/