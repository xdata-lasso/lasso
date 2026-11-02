-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests join predicate mistakes (e.g., Mountain_ID = Climber_ID, or joining on Country/Name, or confusing Height with Prominence/Points).
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (10, 'SameName', 100.0, 999.0, 'RangeA', 'CountryX');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (20, 'DiffName', 200.0, 888.0, 'RangeB', 'CountryY');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (10, 20, 'SameName', 'CountryX', '05:00', 777.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (20, 10, 'OtherClimber', 'CountryZ', '06:00', 666.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name, height FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.climber_id AS climber_id, RHS.name AS name_other, RHS.country AS country_other, RHS.time AS TIME, RHS.points AS points FROM mountain AS LHS INNER JOIN climber AS RHS ON (LHS.mountain_id = RHS.mountain_id)) ORDER BY name, height NULLS LAST;

/*
Gold Result:
('OtherClimber', 100.0)
('SameName', 200.0)
*/

-- Prediction Query
SELECT T1.Name, T2.Height FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID;

/*
Prediction Result:
('SameName', 200.0)
('OtherClimber', 100.0)
*/