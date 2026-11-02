-- Schema DDL
CREATE TABLE drivers (driver_id INTEGER PRIMARY KEY, nationality TEXT, points INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (1001, 'Dutch', 1007);
INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (1002, 'Dutch', 1014.0);
INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (1003, 'Dutch', 1021.0);
INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (1004, 'Dutch', 1028.0);
INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (1005, 'Dutch', 1035.0);
INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (1006, 'Dutch', 1042.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT nationality FROM drivers ORDER BY points DESC, drivers.driver_id NULLS LAST LIMIT 3) AS top_drivers WHERE nationality = 'Dutch';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(CASE WHEN nationality = 'Dutch' THEN 1 END) FROM drivers ORDER BY points DESC, drivers.driver_id NULLS LAST LIMIT 3;

/*
Prediction Result:
(6,)
*/