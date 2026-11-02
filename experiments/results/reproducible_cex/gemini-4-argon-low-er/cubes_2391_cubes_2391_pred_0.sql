-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'M1', 1000.0, 500.0, 'R1', 'C1');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'M2', 2000.0, 600.0, 'R2', 'C1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, RANGE, COUNT(*) AS n FROM mountain GROUP BY country, RANGE) WHERE (n <> 1) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*) > 1;

/*
Prediction Result:
('C1',)
*/