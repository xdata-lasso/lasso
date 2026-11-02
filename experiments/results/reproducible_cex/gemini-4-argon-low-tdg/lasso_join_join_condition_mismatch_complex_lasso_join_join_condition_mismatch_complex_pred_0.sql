-- Schema DDL
CREATE TABLE flights (id INTEGER PRIMARY KEY, flight_no TEXT, origin_id INTEGER, destination_id INTEGER, FOREIGN KEY (destination_id) REFERENCES airports (id), FOREIGN KEY (origin_id) REFERENCES airports (id));

CREATE TABLE airports (id INTEGER PRIMARY KEY, name TEXT, city TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, column projections (name vs city), and origin vs destination ordering/aliasing.
-- Also includes an unreferenced airport to kill RIGHT JOIN / FULL OUTER JOIN on airports.
INSERT INTO airports (id, name, city) VALUES (1, 'JFK Airport', 'New York');
INSERT INTO airports (id, name, city) VALUES (2, 'LAX Airport', 'Los Angeles');
INSERT INTO airports (id, name, city) VALUES (3, 'ORD Airport', 'Chicago');
INSERT INTO flights (id, flight_no, origin_id, destination_id) VALUES (10, 'FL100', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.destination_id = d.id;

/*
Gold Result:
('FL100', 'JFK Airport', 'LAX Airport')
*/

-- Prediction Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.origin_id = d.id;

/*
Prediction Result:
('FL100', 'JFK Airport', 'JFK Airport')
*/