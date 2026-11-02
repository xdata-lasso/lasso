-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (23, 22, 14, NULL, '23', '23', '23', '23');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (14, '23', '23', '23', 23, 23, 23, '23', '23');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (15, '23', '23', '23', 23, 23, 23, '23', '23');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (18, '23', '21', NULL, '23', '25', '20');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (22, '23', '21', '21', '23', '25', '24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_other AS country FROM (SELECT alid, callsign AS name, iata, icao, callsign, country, active, alid_other, icao_other, callsign_other, country_other, active_other FROM (SELECT alid, name, icao AS iata, icao, callsign, country, active, alid_other, icao_other, callsign_other, country_other, active_other FROM (SELECT LHS.alid AS alid, LHS.name AS name, LHS.iata AS iata, LHS.icao AS icao, LHS.callsign AS callsign, LHS.country AS country, LHS.active AS active, RHS.alid AS alid_other, RHS.icao AS icao_other, RHS.callsign AS callsign_other, RHS.country AS country_other, RHS.active AS active_other FROM airlines AS LHS INNER JOIN airlines AS RHS ON (LHS.icao = RHS.iata AND LHS.callsign = RHS.name)))) ORDER BY country;

/*
Gold Result:
('25',)
('25',)
*/

-- Prediction Query
SELECT country FROM airlines GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('25',)
*/