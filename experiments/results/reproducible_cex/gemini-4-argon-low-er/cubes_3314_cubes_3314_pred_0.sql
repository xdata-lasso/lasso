-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Alice', 170.0, 60.0, '1990-01-01', 'NY');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Bob', 180.0, 70.0, '1991-01-01', 'NY');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, n AS count___ FROM (SELECT birth_place, height, COUNT(*) AS n FROM people GROUP BY birth_place, height) ORDER BY birth_place, count___ NULLS LAST;

/*
Gold Result:
('NY', 1)
('NY', 1)
*/

-- Prediction Query
SELECT Birth_Place, COUNT(*) FROM people GROUP BY Birth_Place;

/*
Prediction Result:
('NY', 2)
*/