-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (0, 'default1', 0.0, NULL, 'default1', 'default2'), (1, 'default1', 0.0, 0.0, 'default1', 'default1'), (2, 'default2', 1.0, 0.0, 'default2', 'default1'), (3, NULL, NULL, NULL, NULL, NULL), (4, 'default1', 1.0, NULL, 'default1', NULL), (5, 'default1', NULL, 0.0, 'default2', 'default2'), (6, NULL, NULL, NULL, NULL, 'default1'), (7, NULL, NULL, 0.0, NULL, NULL), (8, NULL, 0.0, NULL, 'default2', 'default2'), (9, NULL, 0.0, 0.0, 'default2', NULL), (10, NULL, 0.0, 0.0, NULL, 'default2');
INSERT INTO climber (climber_id, mountain_id, name, country, time, points) VALUES (1, NULL, 'default1', NULL, 'default2', 0.0), (0, 6, 'default2', 'default1', 'default1', 1.0), (2, 3, NULL, 'default1', 'default2', NULL), (3, 3, 'default1', 'default2', NULL, 1.0), (4, 9, 'default2', NULL, NULL, 1.0), (5, 4, 'default1', NULL, 'default2', 1.0), (6, 10, 'default2', NULL, 'default1', NULL), (7, 4, NULL, 'default2', NULL, 0.0), (8, 0, 'default1', 'default2', 'default1', NULL), (9, 4, 'default1', NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name, height FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.climber_id AS climber_id, RHS.name AS name_other, RHS.country AS country_other, RHS.time AS TIME, RHS.points AS points FROM mountain AS LHS INNER JOIN climber AS RHS ON (LHS.mountain_id = RHS.mountain_id)) ORDER BY name, height NULLS LAST;

/*
Gold Result:
(None, 1.0)
(None, None)
('default1', 0.0)
('default1', 1.0)
('default1', 1.0)
('default1', None)
('default2', 0.0)
('default2', 0.0)
('default2', None)
*/

-- Prediction Query
SELECT T1.Name, T2.Height FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID;

/*
Prediction Result:
('default2', None)
(None, None)
('default1', None)
('default2', 0.0)
('default1', 1.0)
('default2', 0.0)
(None, 1.0)
('default1', 0.0)
('default1', 1.0)
*/