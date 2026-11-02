-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty body_builder table (with rows in people to distinguish table selection errors).
-- Expected output of Reference Query: 0 rows (since COUNT(*) OVER () runs per row, unlike standard COUNT(*) which returns 0).
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Alice Smith', 170.0, 65.0, '1990-01-01', 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Bob Jones', 180.0, 80.0, '1985-05-12', 'Los Angeles');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM body_builder ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM body_builder;

/*
Prediction Result:
(0,)
*/