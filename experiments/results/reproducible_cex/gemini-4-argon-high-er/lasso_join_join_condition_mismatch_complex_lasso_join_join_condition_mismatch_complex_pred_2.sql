-- Schema DDL
CREATE TABLE flights (id INTEGER PRIMARY KEY, flight_no TEXT, origin_id INTEGER, destination_id INTEGER, FOREIGN KEY (destination_id) REFERENCES airports (id), FOREIGN KEY (origin_id) REFERENCES airports (id));

CREATE TABLE airports (id INTEGER PRIMARY KEY, name TEXT, city TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airports (id, name, city) VALUES (1, 'A', 'CityA');
INSERT INTO airports (id, name, city) VALUES (2, 'B', 'CityB');
INSERT INTO flights (id, flight_no, origin_id, destination_id) VALUES (1, 'F1', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.destination_id = d.id;

/*
Gold Result:
('F1', 'A', 'B')
*/

-- Prediction Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = f.origin_id JOIN airports AS d ON f.destination_id = d.id;

/*
Prediction Result:
('F1', 'A', 'B')
('F1', 'B', 'B')
*/