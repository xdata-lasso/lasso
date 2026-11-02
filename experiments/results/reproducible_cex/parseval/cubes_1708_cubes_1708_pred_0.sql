-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airport --
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483648, '5k5swwqcgs', 'air_167e03', '9n8', '4', 'gu7v');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483647, 'e4', 'air_167e03', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483646, 'bnp', 'air_167e03', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (2, 'a9000t5c4eci', 'air_167e03', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (3, '2eutliqa11r', 'air_167e03', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483645, '7zwau2dwyr', 'air_167e03', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483642, 'rkf9vqx5', 'air_167e03', 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483641, 'v', 'air_167e03', 'ph2', 'nd', 'wnqcx');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483640, '5hncprjtu0d', 'air_167e03', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483639, 'kn6vc', NULL, '6ah', 'f8jswwl', '7xb72');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483638, 'xa', NULL, '7ryfdrz16n', 'jja', '5dh');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483637, 'ogrgjd8y', NULL, 't1afgog', 'itsj3', 'y');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483636, 'p1q430', 'air_167e03', 'jh3den8', 'c68x8vacx7', 'f');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483635, '5w1of7', 'air_167e03', 'pzo72ctdc', 'mfg62', '0v');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483634, 'q8qdjpe1', 'air_167e03', 'o22', '8507cvtjp', 'ttg6bnou5zi3');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (5, 'c4bfkfoac', 'air_bd5b9d', '0', '7z2zezjo7wg', 'd5ysxc');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (4, 'r0oz', 'air_bd5b9d', 'dgj5i', 'lq5lnpim', 'k58qs27p');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483631, '5k5swwqcgs', 'air_6cc654', '9n8', '4', 'gu7v');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (6, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) WHERE (n >= 2) ORDER BY country;

/*
Gold Result:
(None,)
('air_167e03',)
('air_bd5b9d',)
*/

-- Prediction Query
SELECT country FROM airport GROUP BY country HAVING COUNT(*) > 2;

/*
Prediction Result:
(None,)
('air_167e03',)
*/