-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (1, 'Aerolineas Argentinas', 'AR', 'ARG', 'ARGENTINA', 'Argentina', 'Y');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (2, 'Cubana de Aviacion', 'CU', 'CUB', 'CUBANA', 'Cuba', 'Y');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (10, 'Zorro Airport', 'Havana', 'Cuba', -82.409, 22.989, 210, 'ZOR', 'MUZO');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (20, 'Ministro Pistarini', 'Buenos Aires', 'Argentina', -58.535, -34.822, 67, 'EZE', 'SAEZ');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (30, 'Aeroparque Jorge Newbery', 'Buenos Aires', 'Argentina', -58.415, -34.559, 18, 'AEP', 'SABE');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (40, 'Jose Marti International', 'Havana', 'Cuba', -82.409, 22.989, 210, 'HAV', 'MUHA');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (50, 'Guarulhos International', 'Sao Paulo', 'Brazil', -46.473, -23.435, 2459, 'GRU', 'SBGR');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (60, 'Unknown Territory Airfield', 'Nowhere', NULL, 0.0, 0.0, 0, 'UNK', 'ZZZZ');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (100, 1, 20, 30, 'AEP', 'EZE', 'AR', NULL);
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (101, 1, 20, 40, 'HAV', 'EZE', 'AR', 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "airports" WHERE ("country" = 'Cuba' OR "country" = 'Argentina') ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('Aeroparque Jorge Newbery',)
('Jose Marti International',)
('Ministro Pistarini',)
('Zorro Airport',)
*/

-- Prediction Query
SELECT name FROM airports WHERE country = 'Cuba' OR country = 'Argentina';

/*
Prediction Result:
('Zorro Airport',)
('Ministro Pistarini',)
('Aeroparque Jorge Newbery',)
('Jose Marti International',)
*/