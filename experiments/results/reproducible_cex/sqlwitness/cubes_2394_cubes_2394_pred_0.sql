-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (1, 'default2', 1.0, NULL, 'default1', NULL), (0, NULL, NULL, 0.0, NULL, NULL), (2, 'default1', 1.0, 0.0, 'default2', 'default2'), (3, 'default2', NULL, 1.0, 'default1', 'default2'), (4, NULL, 1.0, 0.0, 'default2', NULL);
INSERT INTO climber (climber_id, mountain_id, name, country, time, points) VALUES (0, 0, 'default1', NULL, 'default2', 0.0), (1, NULL, NULL, 'default2', 'default2', NULL), (2, 2, 'default1', 'default1', 'default1', NULL), (3, 2, 'default1', 'default2', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.climber_id AS climber_id, RHS.name AS name_other, RHS.country AS country_other, RHS.time AS TIME, RHS.points AS points FROM mountain AS LHS INNER JOIN climber AS RHS ON (LHS.mountain_id = RHS.mountain_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('default1', 'default1')
('default1', 'default1')
('default1', None)
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID;

/*
Prediction Result:
('default1', None)
('default1', 'default1')
('default1', 'default1')
*/