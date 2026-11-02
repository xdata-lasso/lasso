-- Schema DDL
CREATE TABLE flights (id INTEGER PRIMARY KEY, flight_no TEXT, origin_id INTEGER, destination_id INTEGER, FOREIGN KEY (destination_id) REFERENCES airports (id), FOREIGN KEY (origin_id) REFERENCES airports (id));

CREATE TABLE airports (id INTEGER PRIMARY KEY, name TEXT, city TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "flights" ("id", "destination_id", "origin_id", "flight_no") VALUES (26, 16, 17, '27');
INSERT INTO "flights" ("id", "destination_id", "origin_id", "flight_no") VALUES (28, 16, 16, NULL);
INSERT INTO "airports" ("id", "name", "city") VALUES (16, '22', NULL);
INSERT INTO "airports" ("id", "name", "city") VALUES (17, NULL, '25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.destination_id = d.id;

/*
Gold Result:
('27', None, '22')
(None, '22', '22')
*/

-- Prediction Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.destination_id = o.id JOIN airports AS d ON f.origin_id = d.id;

/*
Prediction Result:
('27', '22', None)
(None, '22', '22')
*/