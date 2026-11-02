-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Fuji', 3776.0, 3776.0, 'Honshu', 'Japan');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (10, 'Everest', 8848.86, 8848.86, 'Himalayas', 'Nepal');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (20, 'K2', 8611.0, 4017.0, 'Karakoram', 'Pakistan');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 10, 'Tenzing', 'Japan', '11:30', 95.5);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 10, 'Hillary', 'NZ', '11:30', 95.5);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (3, NULL, 'Solo', 'Nepal', '08:00', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name, height FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.climber_id AS climber_id, RHS.name AS name_other, RHS.country AS country_other, RHS.time AS TIME, RHS.points AS points FROM mountain AS LHS INNER JOIN climber AS RHS ON (LHS.mountain_id = RHS.mountain_id)) ORDER BY name, height NULLS LAST;

/*
Gold Result:
('Hillary', 8848.86)
('Tenzing', 8848.86)
*/

-- Prediction Query
SELECT T1.Name, T2.Height FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID;

/*
Prediction Result:
('Tenzing', 8848.86)
('Hillary', 8848.86)
*/