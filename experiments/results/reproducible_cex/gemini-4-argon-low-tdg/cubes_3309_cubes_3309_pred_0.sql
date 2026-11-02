-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Alice', 170.0, 65.0, '1990-01-01', 'Z_City');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Bob', 180.0, 80.0, '1990-01-01', 'A_City');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (3, 'Charlie', 175.0, 70.0, '1990-01-01', 'A_City');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (4, 'David', 165.0, 60.0, '1991-02-02', 'B_City');
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (1, 1, 100.0, 120.0, 220.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place FROM (SELECT LHS.birth_date AS birth_date, LHS.birth_place AS birth_place, LHS.n AS n, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_place AS birth_place_other FROM (SELECT birth_date, birth_place, COUNT(*) AS n FROM people GROUP BY birth_date, birth_place) AS LHS INNER JOIN people AS RHS ON (LHS.n = RHS.people_id AND LHS.birth_date = RHS.birth_date)) ORDER BY birth_place;

/*
Gold Result:
('A_City',)
('Z_City',)
*/

-- Prediction Query
SELECT Birth_Place FROM people GROUP BY Birth_Place ORDER BY COUNT(*) DESC, Birth_Place NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_City',)
*/