-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty track table to differentiate between window function COUNT(*) OVER () (returns 0 rows) and regular aggregate COUNT(*) (returns 1 row with 0).
INSERT INTO "race" ("Race_ID", "Track_ID", "Name", "Class", "Date") VALUES (1, NULL, 'Orphan Race', 'Class A', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM track ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM track;

/*
Prediction Result:
(0,)
*/