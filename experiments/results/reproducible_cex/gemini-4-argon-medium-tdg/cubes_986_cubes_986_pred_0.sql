-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Track A', 'Loc A', 1000.0, 1990.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Track B', 'Loc B', 2000.0, 2000.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'R1', 'ClassB', '2020-01-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '1', 'R2', 'ClassB', '2020-01-02');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, '1', 'R3', 'ClassB', '2020-01-03');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (4, '2', 'R4', 'ClassB', '2020-01-04');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (5, '2', 'R5', 'ClassB', '2020-01-05');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (6, '1', 'R6', 'ClassA', '2020-01-06');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (7, '1', 'R7', 'ClassA', '2020-01-07');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (8, '2', 'R8', 'ClassC', '2020-01-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM (SELECT LHS.class AS CLASS, LHS.track_id AS track_id, LHS.n AS n, RHS.class AS class_other, RHS.track_id AS track_id_other, RHS.n AS n_other FROM (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS LHS CROSS JOIN (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS RHS) WHERE (n > n_other) ORDER BY CLASS;

/*
Gold Result:
('ClassA',)
('ClassB',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('ClassB',)
*/