-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (7, 9, 10, 10, 10);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (6, 9, 10, 10, 10);
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (8, '10', 12, 10, '10', '10');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (9, '10', NULL, 10, '10', '10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, n AS count___ FROM (SELECT birth_place, height, COUNT(*) AS n FROM people GROUP BY birth_place, height) ORDER BY birth_place, count___ NULLS LAST;

/*
Gold Result:
('10', 1)
('10', 1)
*/

-- Prediction Query
SELECT Birth_Place, COUNT(*) FROM people GROUP BY Birth_Place;

/*
Prediction Result:
('10', 2)
*/