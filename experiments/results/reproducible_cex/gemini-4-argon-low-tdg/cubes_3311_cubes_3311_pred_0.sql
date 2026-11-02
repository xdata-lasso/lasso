-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (1, 'Zack', 175.0, 72.0, '1991-04-10', 'Boston');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (2, 'Zack', 180.0, 78.0, '1993-08-22', 'Boston');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (3, 'Zack', 168.0, 64.0, '1989-12-05', 'Austin');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (4, 'Zack', 172.0, 68.0, '1990-06-18', NULL);
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (5, NULL, 160.0, 50.0, '1996-02-14', 'Denver');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (6, 'Aaron', 185.0, 90.0, '1987-09-09', 'Seattle');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, birth_place FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM body_builder AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name, birth_place NULLS LAST;

/*
Gold Result:
(None, 'Denver')
('Aaron', 'Seattle')
('Zack', 'Austin')
('Zack', 'Boston')
('Zack', 'Boston')
('Zack', None)
*/

-- Prediction Query
SELECT Name, birth_place FROM people EXCEPT SELECT T1.Name, T1.birth_place FROM people AS T1 JOIN body_builder AS T2 ON T1.people_id = T2.people_id;

/*
Prediction Result:
(None, 'Denver')
('Aaron', 'Seattle')
('Zack', None)
('Zack', 'Austin')
('Zack', 'Boston')
*/