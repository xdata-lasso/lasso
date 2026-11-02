-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Central Park', 'NY', 5000.0, 1950.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'R1', 'Class_B', '2021-01-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '1', 'R2', 'Class_B', '2021-01-02');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, '1', 'R3', 'Class_C', '2021-01-03');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (4, '1', 'R4', 'Class_A', '2021-01-04');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (5, '1', 'R5', 'Class_A', '2021-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CLASS FROM (SELECT CLASS, n, MAX(n) OVER () AS maxn FROM (SELECT CLASS, COUNT(*) AS n FROM race GROUP BY CLASS)) WHERE (maxn = n) ORDER BY CLASS;

/*
Gold Result:
('Class_A',)
('Class_B',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('Class_A',)
*/