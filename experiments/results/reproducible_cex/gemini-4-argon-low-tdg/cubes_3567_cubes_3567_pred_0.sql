-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Track A', 'Location A', 50000.0, 1990.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'Race 1', 'Z_Class', '2023-01-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '1', 'Race 2', 'Z_Class', '2023-01-02');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, '1', 'Race 3', 'A_Class', '2023-01-03');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (4, '1', 'Race 4', 'A_Class', '2023-01-04');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (5, '1', 'Race 5', 'M_Class', '2023-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CLASS FROM (SELECT CLASS, n, MAX(n) OVER () AS maxn FROM (SELECT CLASS, COUNT(*) AS n FROM race GROUP BY CLASS)) WHERE (maxn = n) ORDER BY CLASS;

/*
Gold Result:
('A_Class',)
('Z_Class',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_Class',)
*/