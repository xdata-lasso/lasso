-- Schema DDL
CREATE TABLE drivers (driver_id INTEGER PRIMARY KEY, nationality TEXT, points INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: drivers --
INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (1, 'Dutch', -55602865);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483647, 'Dutch', 0);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483646, 'Dutch', 0);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483645, 'Dutch', 0);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483644, 'Dutch', 0);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483643, 'Dutch', -1);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483642, 'Dutch', -59984348);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483641, 'Dutch', -664303813);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483640, 'Dutch', -1022641847);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483649, 'sk', 7719);

INSERT INTO "drivers" ("driver_id", "nationality", "points") VALUES (-2147483648, '9n8c4pgu7v', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT nationality FROM drivers ORDER BY points DESC, drivers.driver_id NULLS LAST LIMIT 3) AS top_drivers WHERE nationality = 'Dutch';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(CASE WHEN nationality = 'Dutch' THEN 1 END) FROM drivers ORDER BY points DESC, drivers.driver_id NULLS LAST LIMIT 3;

/*
Prediction Result:
(9,)
*/