-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'K2', 8611.0, 4017.0, 'Karakoram', 'Pakistan');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Denali', 6190.0, 6144.0, 'Alaska Range', 'USA');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Olympus', 2917.0, 2355.0, 'Olympus Range', 'Greece');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 2, 'Zara', 'UK', '12:30', 95.5);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 3, 'Liam', 'Canada', '08:15', 80.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (3, 1, 'Noah', 'Switzerland', '05:45', 70.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (4, NULL, 'Emma', 'France', '00:00', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.climber_id AS climber_id, RHS.name AS name_other, RHS.country AS country_other, RHS.time AS TIME, RHS.points AS points FROM mountain AS LHS INNER JOIN climber AS RHS ON (LHS.mountain_id = RHS.mountain_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Liam', 'Denali')
('Noah', 'Matterhorn')
('Zara', 'K2')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID;

/*
Prediction Result:
('Zara', 'K2')
('Liam', 'Denali')
('Noah', 'Matterhorn')
*/