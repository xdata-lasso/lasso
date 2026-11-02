-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Height", "Weight") VALUES (1, 170.0, 70.0);
INSERT INTO "people" ("People_ID", "Height", "Weight") VALUES (2, 180.0, 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height, weight FROM people ORDER BY height, people.people_id NULLS LAST;

/*
Gold Result:
(170.0, 70.0)
(180.0, 80.0)
*/

-- Prediction Query
SELECT Height, Weight FROM people ORDER BY Height DESC, people.people_id NULLS LAST;

/*
Prediction Result:
(180.0, 80.0)
(170.0, 70.0)
*/