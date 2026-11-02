-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (0, 'default2', 0.0, 2.0, NULL, 'default2'), (1, 'default1', 2.0, 0.0, 'default2', 'default1'), (2, 'default1', 0.0, 1.0, 'default2', 'default2');
INSERT INTO climber (climber_id, mountain_id, name, country, time, points) VALUES (0, 1, 'default2', 'default1', NULL, 2.0), (2, NULL, NULL, 'default1', 'default1', NULL), (1, 0, NULL, 'default2', NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM mountain AS LHS WHERE NOT EXISTS(SELECT 1 FROM climber AS RHS WHERE (LHS.mountain_id = RHS.mountain_id))) ORDER BY name;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE NOT Mountain_ID IN (SELECT Mountain_ID FROM climber);

/*
Prediction Result:
*/