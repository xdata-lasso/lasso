-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, ' Belmont Park', 'New York', 50000.0, 1905.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Churchill Downs', 'Kentucky', 60000.0, 1875.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Pimlico', 'Maryland', 40000.0, 1870.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'Zeta Stakes', 'B', '2020-01-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '2', 'Alpha Cup', 'C', '2020-04-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, '3', 'Omega Derby', 'A', '2020-02-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (4, '1', 'Beta Sprint', 'C', '2020-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM race ORDER BY CLASS;

/*
Gold Result:
('A',)
('B',)
('C',)
*/

-- Prediction Query
SELECT DISTINCT CLASS FROM race;

/*
Prediction Result:
('B',)
('C',)
('A',)
*/