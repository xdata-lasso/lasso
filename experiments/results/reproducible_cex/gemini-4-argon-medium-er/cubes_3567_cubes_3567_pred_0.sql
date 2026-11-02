-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("Track_ID", "Name", "Location", "Seating", "Year_Opened") VALUES (1, 'Track A', 'Location A', 1000.0, 2000.0);
INSERT INTO "race" ("Race_ID", "Track_ID", "Name", "Class", "Date") VALUES (1, 1, 'Race 1', 'Class A', '2023-01-01');
INSERT INTO "race" ("Race_ID", "Track_ID", "Name", "Class", "Date") VALUES (2, 1, 'Race 2', 'Class B', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CLASS FROM (SELECT CLASS, n, MAX(n) OVER () AS maxn FROM (SELECT CLASS, COUNT(*) AS n FROM race GROUP BY CLASS)) WHERE (maxn = n) ORDER BY CLASS;

/*
Gold Result:
('Class A',)
('Class B',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('Class A',)
*/