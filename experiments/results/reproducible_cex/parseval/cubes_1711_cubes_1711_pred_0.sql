-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airport --
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483648, '4h', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: operate_company --
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366);

-- Inserting into table: flight --
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483648, -2147483648, -2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483647, -2147483648, -2147483648, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483646, -2147483648, -2147483648, 'tliqa1', 'ryytoo3', '9hl7', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483645, -2147483648, -2147483648, 'ex1', 'ji7zwau2', 'dwyrq13pyu78', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483644, -2147483648, -2147483648, 'jsl', 'b4yp5qi', 'rkf9vqx5', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483643, -2147483648, -2147483648, 'f8jegd2', 'vy9uxj4', 'wb', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483642, -2147483648, -2147483648, 'ph2', 'nd', 'wnqcx', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483641, -2147483648, -2147483648, 'cprj', 'u0dz7', 'fjgq8n2f3', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483640, -2147483648, -2147483648, '0gcb98', 'zk3z', 'i', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483639, -2147483648, -2147483648, 'kn6vc', '6ah', 'f8jswwl', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483638, -2147483648, -2147483648, '7', '2fxa7ryfdrz', '16nijjai5dh', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483637, -2147483648, -2147483648, 'rg', 'd8y', 't1afgog', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483636, -2147483648, -2147483648, 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 1.0, NULL);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483635, -2147483648, -2147483648, '5w1of7', 'pzo72ctdc', 'mfg62', 1.0, NULL);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483634, -2147483648, -2147483648, '5q8qdj', 'e1io', '278507cv', 1.0, NULL);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483633, -2147483648, -2147483648, 'ttg6', 'n', 'u5zi', NULL, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483632, -2147483648, -2147483648, 'bfkfoacd', '7z2zezj', '7wgx', NULL, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483631, -2147483648, -2147483648, 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', NULL, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483630, -2147483648, -2147483648, 'qs27p2r94', 'th', '2mnajjla3o', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483629, -2147483648, -2147483648, 'uttmu2ne5', '78lfvyz7zz', 'be8yvkv42q7', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483628, -2147483648, -2147483648, '58b4pmaus3a', 'vmkrpd', 'wzw', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483627, -2147483648, -2147483648, 'n9', 'o705', 'a9n0jxfofws', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483626, -2147483648, -2147483648, '2zob', '0', '0k32o', 1.0, 1.0);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483625, -2147483648, -2147483648, 'l', '5amsorlwyngc', 'dj9erhi', 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT altitude, velocity, COUNT(*) AS n FROM flight GROUP BY altitude, velocity) WHERE (n <> 200 AND velocity >= 200.0) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM flight WHERE velocity > 200;

/*
Prediction Result:
(0,)
*/