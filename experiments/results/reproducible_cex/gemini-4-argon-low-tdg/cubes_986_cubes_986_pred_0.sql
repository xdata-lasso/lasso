-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Track A', 'Loc A', 1000.0, 2000.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Track B', 'Loc B', 2000.0, 2001.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Track C', 'Loc C', 3000.0, 2002.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'R1', 'C', '2020-01-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '1', 'R2', 'C', '2020-01-02');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, '2', 'R3', 'C', '2020-01-03');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (4, '2', 'R4', 'C', '2020-01-04');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (5, '1', 'R5', 'A', '2020-01-05');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (6, '2', 'R6', 'A', '2020-01-06');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (7, '3', 'R7', 'A', '2020-01-07');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (8, '1', 'R8', 'B', '2020-01-08');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (9, '1', 'R9', 'B', '2020-01-09');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (10, '1', 'R10', 'B', '2020-01-10');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (11, '2', 'R11', 'B', '2020-01-11');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (12, '2', 'R12', 'B', '2020-01-12');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (13, '2', 'R13', 'B', '2020-01-13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM (SELECT LHS.class AS CLASS, LHS.track_id AS track_id, LHS.n AS n, RHS.class AS class_other, RHS.track_id AS track_id_other, RHS.n AS n_other FROM (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS LHS CROSS JOIN (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS RHS) WHERE (n > n_other) ORDER BY CLASS;

/*
Gold Result:
('B',)
('C',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('B',)
*/