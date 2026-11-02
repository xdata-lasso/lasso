-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (non-alphabetical insertion), duplicate names (catches DISTINCT),
-- reverse ordering of attributes vs Name (catches ORDER BY wrong column),
-- and NULL Mountain_ID (catches unintended INNER JOIN with mountain).
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 1, 'Zack', 'USA', '10:00', 100.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 1, 'Alice', 'UK', '20:00', 50.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (3, NULL, 'Alice', 'Canada', '15:00', 75.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (4, 1, 'Bob', 'France', '05:00', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM climber ORDER BY name, climber.climber_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM climber ORDER BY Points DESC, climber.climber_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Zack',)
('Alice',)
('Alice',)
*/