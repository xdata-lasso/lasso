-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate rows (to catch DISTINCT vs ALL), NULLS LAST ordering in Birth_Place, NULL Name ordering, and multiple body_builder entries for the same person.
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Dave', 170.0, 65.0, '1990-01-01', 'Seattle');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Dave', 170.0, 65.0, '1990-01-01', 'Austin');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (3, 'Dave', 170.0, 65.0, '1990-01-01', NULL);
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (4, 'Dave', 175.0, 75.0, '1995-02-02', 'Austin');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (5, NULL, 160.0, 55.0, '1998-08-08', 'Denver');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (6, 'Eve', 165.0, 60.0, '1991-11-11', 'Miami');
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (10, 6, 110.0, 130.0, 240.0);
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (11, 6, 115.0, 135.0, 250.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, birth_place FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM body_builder AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name, birth_place NULLS LAST;

/*
Gold Result:
(None, 'Denver')
('Dave', 'Austin')
('Dave', 'Austin')
('Dave', 'Seattle')
('Dave', None)
*/

-- Prediction Query
SELECT Name, birth_place FROM people EXCEPT SELECT T1.Name, T1.birth_place FROM people AS T1 JOIN body_builder AS T2 ON T1.people_id = T2.people_id;

/*
Prediction Result:
(None, 'Denver')
('Dave', None)
('Dave', 'Austin')
('Dave', 'Seattle')
*/