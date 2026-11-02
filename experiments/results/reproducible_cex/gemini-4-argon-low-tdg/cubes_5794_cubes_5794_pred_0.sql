-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Inner GROUP BY (name, weight) vs grouping by only name or only weight.
-- 2. Join condition: LHS.n = RHS.people_id AND LHS.weight = RHS.weight (includes decoys failing one or the other).
-- 3. Outer GROUP BY (birth_date, birth_place) vs grouping by only birth_place (duplicate birth_place with different birth_date).
-- 4. Duplicate elimination within the same (birth_date, birth_place) group when multiple LHS groups match.
-- 5. ORDER BY birth_place (ascending vs descending vs insertion order).
-- 6. Independence from body_builder table (in case mutant joins with body_builder).
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (1, 'Alice', 170.0, 60.0, '1990-01-01', 'Zeta');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (2, 'Bob', 180.0, 75.0, '1985-05-05', 'Alpha');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (10, 'Bob', 175.0, 75.0, '1988-08-08', 'Beta');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (11, 'Alice', 165.0, 80.0, '1992-02-02', 'Gamma');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (12, 'Charlie', 185.0, 60.0, '1990-01-01', 'Delta');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (3, 'Dave', 190.0, 90.0, '1980-10-10', 'Omega');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (4, 'Eve', 160.0, 75.0, '1995-12-12', 'Alpha');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (13, 'Eve', 162.0, 75.0, '1995-12-12', 'Kappa');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (14, 'Frank', 170.0, 50.0, '2000-01-01', 'Sigma');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (15, 'Grace', 172.0, 60.0, '1999-09-09', 'Theta');
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (1, 1, 100.0, 120.0, 220.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (2, 3, 150.0, 180.0, 330.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place FROM (SELECT birth_date, birth_place, MAX(n) AS maxn FROM (SELECT name, weight, n, name_other, height, birth_date, birth_place, n AS people_id FROM (SELECT LHS.name AS name, LHS.weight AS weight, LHS.n AS n, RHS.name AS name_other, RHS.height AS height, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM (SELECT name, weight, COUNT(*) AS n FROM people GROUP BY name, weight) AS LHS INNER JOIN people AS RHS ON (LHS.n = RHS.people_id AND LHS.weight = RHS.weight))) GROUP BY birth_date, birth_place) ORDER BY birth_place;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Birth_Place FROM people GROUP BY Birth_Place ORDER BY COUNT(*) DESC, Birth_Place NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/