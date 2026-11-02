-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Lowland Intl', 'Miami', 'USA', 25.79, -80.29, 100, 'MIA', 'KMIA');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Andes High', 'Juliaca', 'Peru', -15.46, -70.15, 4000, 'JUL', 'SPJL');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'El Alto Intl', 'La Paz', 'Bolivia', -16.51, -68.19, 4000, 'LPB', 'SLLP');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Polder Field', 'Amsterdam', 'Netherlands', 52.30, 4.76, -20, 'AMS', 'EHAM');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Unknown Alt', 'Atlantis', 'Greece', 36.00, 25.00, NULL, 'ATL', 'LGAT');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (1, 'Global Air', 'GA', 'GLA', 'GLOBAL', 'UK', 'Y');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (1, 1, 1, 4, 'EHAM', 'KMIA', 'GLA', '');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT LHS.elevation AS elevation, RHS.apid AS apid, RHS.name AS name, RHS.city AS city, RHS.country AS country, RHS.x AS x, RHS.y AS y, RHS.iata AS iata, RHS.icao AS icao FROM (SELECT MAX(elevation) AS elevation FROM airports) AS LHS LEFT JOIN airports AS RHS ON (LHS.elevation = RHS.elevation)) ORDER BY country;

/*
Gold Result:
('Bolivia',)
('Peru',)
*/

-- Prediction Query
SELECT country FROM airports ORDER BY elevation DESC, airports.apid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Peru',)
*/