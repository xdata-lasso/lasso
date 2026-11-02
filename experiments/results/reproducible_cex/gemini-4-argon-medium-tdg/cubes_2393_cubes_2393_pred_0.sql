-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'M1', 5000.0, 2000.0, 'R1', 'C1');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'M2', 3000.0, 1000.0, 'R2', 'C2');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'M3', NULL, 500.0, 'R3', 'C3');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 1, 'Dan', 'C1', '08:00', 80.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 2, 'Dan', 'C2', '09:00', 90.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (3, 3, 'Dan', 'C3', '10:00', 70.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (4, 1, 'Dan', 'C4', '11:00', 85.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name, height FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.climber_id AS climber_id, RHS.name AS name_other, RHS.country AS country_other, RHS.time AS TIME, RHS.points AS points FROM mountain AS LHS INNER JOIN climber AS RHS ON (LHS.mountain_id = RHS.mountain_id)) ORDER BY name, height NULLS LAST;

/*
Gold Result:
('Dan', 3000.0)
('Dan', 5000.0)
('Dan', 5000.0)
('Dan', None)
*/

-- Prediction Query
SELECT T1.Name, T2.Height FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID;

/*
Prediction Result:
('Dan', 5000.0)
('Dan', 3000.0)
('Dan', None)
('Dan', 5000.0)
*/