-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (1, 'Alice', 170.0, 60.0, '1990-01-01', 'Zurich');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (2, 'Bob', 180.0, 75.0, '1985-05-05', 'Amsterdam');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (3, 'Charlie', 175.0, 99.0, '1992-03-03', 'Berlin');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (4, 'David', 165.0, 60.0, '1988-08-08', 'Cairo');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (5, 'Eve', 160.0, 75.0, '1995-07-07', 'Dublin');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (6, 'Eve', 162.0, 75.0, '1996-07-07', 'Dublin');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (7, 'Frank', 185.0, 85.0, '1991-11-11', 'Lisbon');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (8, 'Frank', 185.0, 85.0, '1991-11-11', 'Lisbon');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (9, 'Frank', 185.0, 85.0, '1991-11-11', 'Lisbon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place FROM (SELECT birth_date, birth_place, MAX(n) AS maxn FROM (SELECT name, weight, n, name_other, height, birth_date, birth_place, n AS people_id FROM (SELECT LHS.name AS name, LHS.weight AS weight, LHS.n AS n, RHS.name AS name_other, RHS.height AS height, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM (SELECT name, weight, COUNT(*) AS n FROM people GROUP BY name, weight) AS LHS INNER JOIN people AS RHS ON (LHS.n = RHS.people_id AND LHS.weight = RHS.weight))) GROUP BY birth_date, birth_place) ORDER BY birth_place;

/*
Gold Result:
('Amsterdam',)
('Zurich',)
*/

-- Prediction Query
SELECT Birth_Place FROM people GROUP BY Birth_Place ORDER BY COUNT(*) DESC, Birth_Place NULLS LAST LIMIT 1;

/*
Prediction Result:
('Lisbon',)
*/