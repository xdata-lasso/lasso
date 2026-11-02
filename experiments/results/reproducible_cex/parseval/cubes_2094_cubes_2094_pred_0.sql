-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airlines --
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (1, 'value', 'value', 'air_9fd1c4', 'air_31d5f3', 'air_67f3e1', 'air_a72042');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (-2147483647, 'value', 'value', 'air_7b9fd7', 'air_31f069', 'air_d6083f', 'air_b88577');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (2, '5k5swwqcgs', 'f9', '844', '9n8', '4', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (3, 'gu7v', 'f9', '844', 'e4', 'hria2ypuzhs', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (4, 'rwbbp6luhvd', 'f9', '844', 'tti', 'bnp', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (5, 'mdpos', 'f9', '844', 'ie5', 'nw6klf', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (6, 'a9000t5c4eci', 'f9', '844', 'gce376nium52', 'zbuo4nrqrof', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (7, 'qyp5s5bbp0', 'f9', '844', '2eutliqa11r', 'ytoo3o9', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (8, 'l7', 'f9', '844', 'klex14ji', '7zwau2dwyr', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (9, '13pyu', 'f9', '844', '8d99rljsl', 'b4yp5qi', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (10, 'rkf9vqx5', 'f9', '844', 'pz0f8jegd', '1vy9uxj4', '45');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (11, 'wb', 'f9', '844', 'v', 'ph2', '45');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_other AS country FROM (SELECT alid, callsign AS name, iata, icao, callsign, country, active, alid_other, icao_other, callsign_other, country_other, active_other FROM (SELECT alid, name, icao AS iata, icao, callsign, country, active, alid_other, icao_other, callsign_other, country_other, active_other FROM (SELECT LHS.alid AS alid, LHS.name AS name, LHS.iata AS iata, LHS.icao AS icao, LHS.callsign AS callsign, LHS.country AS country, LHS.active AS active, RHS.alid AS alid_other, RHS.icao AS icao_other, RHS.callsign AS callsign_other, RHS.country AS country_other, RHS.active AS active_other FROM airlines AS LHS INNER JOIN airlines AS RHS ON (LHS.icao = RHS.iata AND LHS.callsign = RHS.name)))) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT country FROM airlines GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('1vy9uxj4',)
*/