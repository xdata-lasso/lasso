-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (0, NULL, NULL, 1.0, NULL, NULL), (1, 'default2', NULL, 0.0, 'default2', 'default1'), (2, 'default2', NULL, 0.0, NULL, 'default2'), (3, NULL, 0.0, 0.0, 'Switzerland', 'default1'), (4, 'default2', 0.0, 1.0, 'default2', 'Switzerland');
INSERT INTO climber (climber_id, mountain_id, name, country, time, points) VALUES (0, 0, NULL, NULL, 'Switzerland', 1.0), (1, 0, 'default2', NULL, 'Switzerland', 0.0), (2, 3, 'default2', 'default1', 'default1', 0.0), (3, 3, NULL, 'default2', 'Switzerland', NULL), (4, NULL, 'default2', 'default1', NULL, 1.0), (5, 4, NULL, 'default2', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "climber" WHERE ("country" <> 'Switzerland') ORDER BY name, climber.climber_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM climber WHERE Country <> 'Switzerland';

/*
Prediction Result:
('default2',)
(None,)
('default2',)
(None,)
*/