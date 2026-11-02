-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY (Country, Range), HAVING count <> 1, and difference between grouping by (Country, Range) vs grouping by Country only.
-- Also tests joins with climber table (some mountains have 0 climbers, some have multiple climbers).
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Mount Elbert', 4401.2, 2772.0, 'Rocky Mountains', 'USA');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Mount Massive', 4398.0, 592.0, 'Rocky Mountains', 'USA');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Mount Logan', 5959.0, 5250.0, 'Saint Elias', 'Canada');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (4, 'Mount Robson', 3954.0, 2829.0, 'Rocky Mountains', 'Canada');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (5, 'Aconcagua', 6960.8, 6960.8, 'Andes', 'Argentina');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 3, 'John Doe', 'USA', '10:00', 100.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 3, 'Jane Smith', 'Canada', '12:00', 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, RANGE, COUNT(*) AS n FROM mountain GROUP BY country, RANGE) WHERE (n <> 1) ORDER BY country;

/*
Gold Result:
('USA',)
*/

-- Prediction Query
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*) > 1;

/*
Prediction Result:
('Canada',)
('USA',)
*/