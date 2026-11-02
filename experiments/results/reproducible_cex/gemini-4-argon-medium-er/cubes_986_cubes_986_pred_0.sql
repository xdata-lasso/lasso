-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("Track_ID", "Name", "Location", "Seating", "Year_Opened") VALUES (1, 'Track A', 'Loc A', 1000.0, 2000.0);
INSERT INTO "race" ("Race_ID", "Track_ID", "Name", "Class", "Date") VALUES (1, '1', 'Race 1', 'Class A', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM (SELECT LHS.class AS CLASS, LHS.track_id AS track_id, LHS.n AS n, RHS.class AS class_other, RHS.track_id AS track_id_other, RHS.n AS n_other FROM (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS LHS CROSS JOIN (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS RHS) WHERE (n > n_other) ORDER BY CLASS;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('Class A',)
*/