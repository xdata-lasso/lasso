-- Schema DDL
CREATE TABLE flights (id INTEGER PRIMARY KEY, flight_no TEXT, origin_id INTEGER, destination_id INTEGER, FOREIGN KEY (destination_id) REFERENCES airports (id), FOREIGN KEY (origin_id) REFERENCES airports (id));

CREATE TABLE airports (id INTEGER PRIMARY KEY, name TEXT, city TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airports (id, name, city) VALUES (1, 'default1', 'default1'), (0, NULL, 'default1'), (2, NULL, 'default2'), (3, 'default1', 'default2'), (4, 'default1', 'default1'), (5, 'default2', NULL), (6, NULL, NULL);
INSERT INTO flights (id, destination_id, origin_id, flight_no) VALUES (0, NULL, 1, NULL), (1, 4, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.destination_id = d.id;

/*
Gold Result:
*/

-- Prediction Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.origin_id = d.id;

/*
Prediction Result:
(None, 'default1', 'default1')
*/