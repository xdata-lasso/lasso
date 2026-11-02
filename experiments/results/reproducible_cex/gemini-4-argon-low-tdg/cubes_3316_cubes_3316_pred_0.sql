-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Alice', 170.5, 65.0, '1990-01-01', 'NY');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Bob', 180.0, 80.0, '1985-05-05', 'LA');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (3, 'Charlie', 160.0, 55.0, '1992-03-03', 'SF');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (4, 'David', 170.5, 70.0, '1988-08-08', 'CHI');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (5, 'Eve', 170.5, 65.0, '1995-12-12', 'BOS');
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (101, 1, 100.0, 120.0, 220.0);
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (102, 2, 110.0, 130.0, 240.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height, weight FROM people ORDER BY height, people.people_id NULLS LAST;

/*
Gold Result:
(160.0, 55.0)
(170.5, 65.0)
(170.5, 70.0)
(170.5, 65.0)
(180.0, 80.0)
*/

-- Prediction Query
SELECT Height, Weight FROM people ORDER BY Height DESC, people.people_id NULLS LAST;

/*
Prediction Result:
(180.0, 80.0)
(170.5, 65.0)
(170.5, 70.0)
(170.5, 65.0)
(160.0, 55.0)
*/