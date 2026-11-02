-- Schema DDL
CREATE TABLE drivers (driver_id INTEGER PRIMARY KEY, nationality TEXT, points INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO drivers (driver_id, nationality, points) VALUES (1, 'British', 100);
INSERT INTO drivers (driver_id, nationality, points) VALUES (2, 'Dutch', 90);
INSERT INTO drivers (driver_id, nationality, points) VALUES (3, 'Dutch', 80);
INSERT INTO drivers (driver_id, nationality, points) VALUES (4, 'Dutch', 70);
INSERT INTO drivers (driver_id, nationality, points) VALUES (5, 'French', 60);
INSERT INTO drivers (driver_id, nationality, points) VALUES (6, 'German', 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT nationality FROM drivers ORDER BY points DESC, drivers.driver_id NULLS LAST LIMIT 3) AS top_drivers WHERE nationality = 'Dutch';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(CASE WHEN nationality = 'Dutch' THEN 1 END) FROM drivers ORDER BY points DESC, drivers.driver_id NULLS LAST LIMIT 3;

/*
Prediction Result:
(3,)
*/