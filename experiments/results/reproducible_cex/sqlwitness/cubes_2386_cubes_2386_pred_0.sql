-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (1, NULL, 0.0, NULL, NULL, 'default1'), (0, NULL, 0.0, 1.0, 'default1', 'default2'), (2, 'default2', 1.0, 1.0, 'default2', 'default1'), (3, 'default2', 1.0, 1.0, 'default2', NULL);
INSERT INTO climber (climber_id, mountain_id, name, country, time, points) VALUES (0, 0, 'default1', 'default2', 'default2', 0.0), (1, NULL, 'default2', 'default1', NULL, NULL), (2, NULL, NULL, NULL, 'default1', 0.0), (3, NULL, 'default2', NULL, 'default1', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM climber ORDER BY name, climber.climber_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM climber ORDER BY Points DESC, climber.climber_id NULLS LAST;

/*
Prediction Result:
('default1',)
(None,)
('default2',)
('default2',)
*/