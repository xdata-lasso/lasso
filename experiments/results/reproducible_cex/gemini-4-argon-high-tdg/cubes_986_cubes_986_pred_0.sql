-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Speedway One', 'Austin', 50000.0, 2000.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Speedway Two', 'Miami', 60000.0, 2005.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Speedway Three', 'Dallas', 40000.0, 2010.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'Race 1', 'B', '2021-01-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '1', 'Race 2', 'B', '2021-01-02');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, '1', 'Race 3', 'B', '2021-01-03');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (4, '2', 'Race 4', 'A', '2021-02-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (5, '2', 'Race 5', 'A', '2021-02-02');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (6, '3', 'Race 6', 'C', '2021-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM (SELECT LHS.class AS CLASS, LHS.track_id AS track_id, LHS.n AS n, RHS.class AS class_other, RHS.track_id AS track_id_other, RHS.n AS n_other FROM (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS LHS CROSS JOIN (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS RHS) WHERE (n > n_other) ORDER BY CLASS;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('B',)
*/