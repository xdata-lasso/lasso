-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests duplicate elimination (INTERSECT semantics vs UNION ALL / standard SELECT), ordering (ORDER BY RANGE ASC vs DESC or insertion order), and decoupled foreign key joins (mountains without climbers vs mountains with multiple climbers).
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Mont Blanc', 4808.0, 4695.0, 'Alps', 'France');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Denali', 6190.0, 6144.0, 'Alaska Range', 'USA');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 1, 'Alice', 'France', '10:00', 100.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 1, 'Bob', 'UK', '12:00', 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RANGE FROM (SELECT RANGE FROM mountain INTERSECT SELECT RANGE FROM mountain) ORDER BY RANGE;

/*
Gold Result:
('Alaska Range',)
('Alps',)
('Himalayas',)
*/

-- Prediction Query
SELECT DISTINCT RANGE FROM mountain ORDER BY Prominence DESC, RANGE NULLS LAST LIMIT 3;

/*
Prediction Result:
('Himalayas',)
('Alaska Range',)
('Alps',)
*/