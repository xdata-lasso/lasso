-- Schema DDL
CREATE TABLE flights (id INTEGER PRIMARY KEY, flight_no TEXT, origin_id INTEGER, destination_id INTEGER, FOREIGN KEY (destination_id) REFERENCES airports (id), FOREIGN KEY (origin_id) REFERENCES airports (id));

CREATE TABLE airports (id INTEGER PRIMARY KEY, name TEXT, city TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airports" ("id", "name", "city") VALUES (1001, 'Allison Hill', 'East Jill');
INSERT INTO "airports" ("id", "name", "city") VALUES (1002, 'Stephanie Miller', 'Johnsonland');
INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (1003, 'discover', 1001, 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.destination_id = d.id;

/*
Gold Result:
('discover', 'Allison Hill', 'Stephanie Miller')
*/

-- Prediction Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = f.origin_id JOIN airports AS d ON f.destination_id = d.id;

/*
Prediction Result:
('discover', 'Allison Hill', 'Stephanie Miller')
('discover', 'Stephanie Miller', 'Stephanie Miller')
*/