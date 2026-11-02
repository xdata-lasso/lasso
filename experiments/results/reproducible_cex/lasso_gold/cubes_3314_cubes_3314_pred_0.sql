-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1004, 'Megan Mcclain', 1005.5, 1006.5, 'begin', 'performance');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1012, 'Jerry Ramirez', NULL, 1014.5, 'true', 'according');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1015, 'Caitlin Henderson', 1016.5, 1017.5, 'fall', 'according');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, n AS count___ FROM (SELECT birth_place, height, COUNT(*) AS n FROM people GROUP BY birth_place, height) ORDER BY birth_place, count___ NULLS LAST;

/*
Gold Result:
('according', 1)
('according', 1)
('performance', 1)
*/

-- Prediction Query
SELECT Birth_Place, COUNT(*) FROM people GROUP BY Birth_Place;

/*
Prediction Result:
('according', 2)
('performance', 1)
*/