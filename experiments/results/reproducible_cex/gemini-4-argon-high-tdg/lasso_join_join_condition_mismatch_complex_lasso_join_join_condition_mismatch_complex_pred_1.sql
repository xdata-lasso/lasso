-- Schema DDL
CREATE TABLE flights (id INTEGER PRIMARY KEY, flight_no TEXT, origin_id INTEGER, destination_id INTEGER, FOREIGN KEY (destination_id) REFERENCES airports (id), FOREIGN KEY (origin_id) REFERENCES airports (id));

CREATE TABLE airports (id INTEGER PRIMARY KEY, name TEXT, city TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (id, name, city) VALUES (10, 'Heathrow', 'London');
INSERT INTO airports (id, name, city) VALUES (20, 'Charles de Gaulle', 'Paris');
INSERT INTO airports (id, name, city) VALUES (30, 'Unused Airport', 'Berlin');
INSERT INTO flights (id, flight_no, origin_id, destination_id) VALUES (1, 'BA101', 10, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.destination_id = d.id;

/*
Gold Result:
('BA101', 'Heathrow', 'Charles de Gaulle')
*/

-- Prediction Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.destination_id = o.id JOIN airports AS d ON f.origin_id = d.id;

/*
Prediction Result:
('BA101', 'Charles de Gaulle', 'Heathrow')
*/