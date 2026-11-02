-- Schema DDL
CREATE TABLE flights (id INTEGER PRIMARY KEY, flight_no TEXT, origin_id INTEGER, destination_id INTEGER, FOREIGN KEY (destination_id) REFERENCES airports (id), FOREIGN KEY (origin_id) REFERENCES airports (id));

CREATE TABLE airports (id INTEGER PRIMARY KEY, name TEXT, city TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airports --
INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483648, 'air_8cfaf3', '5k5swwqcgs');

INSERT INTO "airports" ("id", "name", "city") VALUES (1, 'd_s_0848b9', '9n8');

INSERT INTO "airports" ("id", "name", "city") VALUES (2, 'air_8cfaf3', '4');

INSERT INTO "airports" ("id", "name", "city") VALUES (3, 'air_8cfaf3', 'gu7v');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483646, 'd_s_debf34', 'e4');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483643, 'air_8cfaf3', 'hria2ypuzhs');

INSERT INTO "airports" ("id", "name", "city") VALUES (4, 'rwbbp6luhvd', 'tti');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483641, 'air_8cfaf3', 'bnp');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483640, 'air_8cfaf3', 'mdpos');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483639, 'air_8cfaf3', 'ie5');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483638, 'air_8cfaf3', 'nw6klf');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483637, 'air_8cfaf3', 'a9000t5c4eci');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483636, 'air_8cfaf3', 'gce376nium52');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483635, 'air_8cfaf3', 'zbuo4nrqrof');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483634, NULL, 'qyp5s5bbp0');

INSERT INTO "airports" ("id", "name", "city") VALUES (-2147483633, 'air_8cfaf3', '2eutliqa11r');

-- Inserting into table: flights --
INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (-2147483648, 'f_s_925ddd', 1, 1);

INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (2, 'f_s_925ddd', 1, 1);

INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (3, 'f_s_925ddd', 1, 1);

INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (-2147483645, 'f_s_925ddd', 4, 1);

INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (-2147483644, 'f_s_925ddd', 1, 4);

INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (-2147483643, 'f_s_925ddd', 4, 1);

INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (-2147483642, 'f_s_925ddd', 1, 4);

INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (-2147483641, 'f_s_925ddd', 1, 1);

INSERT INTO "flights" ("id", "flight_no", "origin_id", "destination_id") VALUES (-2147483640, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.destination_id = d.id;

/*
Gold Result:
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'rwbbp6luhvd', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'rwbbp6luhvd')
('f_s_925ddd', 'rwbbp6luhvd', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'rwbbp6luhvd')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
(None, 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
*/

-- Prediction Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = f.origin_id JOIN airports AS d ON f.destination_id = d.id;

/*
Prediction Result:
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_debf34', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', None, 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'rwbbp6luhvd', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_debf34', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', None, 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'rwbbp6luhvd', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'd_s_debf34', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', None, 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'd_s_0848b9', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'rwbbp6luhvd', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_debf34', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', None, 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'rwbbp6luhvd', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'd_s_debf34', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', None, 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'd_s_0848b9', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'rwbbp6luhvd')
('f_s_925ddd', 'rwbbp6luhvd', 'rwbbp6luhvd')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_debf34', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', None, 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'rwbbp6luhvd', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'd_s_debf34', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, None, 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'd_s_0848b9', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'air_8cfaf3', 'd_s_0848b9')
(None, 'rwbbp6luhvd', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_debf34', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', None, 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'rwbbp6luhvd', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_debf34', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', None, 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'd_s_0848b9', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'air_8cfaf3', 'd_s_0848b9')
('f_s_925ddd', 'rwbbp6luhvd', 'd_s_0848b9')
*/