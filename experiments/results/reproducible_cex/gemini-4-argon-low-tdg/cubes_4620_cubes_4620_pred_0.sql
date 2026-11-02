-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Multiple tied maximum elevations across different countries, ORDER BY country (ASC vs DESC vs apid order), and DISTINCT vs ALL with a lower elevation airport.
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'High Z', 'CityZ', 'Zambia', 10.0, 10.0, 5000, 'HZA', 'HZAA');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'High A', 'CityA', 'Argentina', 20.0, 20.0, 5000, 'HAR', 'HARA');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Low B', 'CityB', 'Brazil', 30.0, 30.0, 100, 'LBR', 'LBRA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT LHS.elevation AS elevation, RHS.apid AS apid, RHS.name AS name, RHS.city AS city, RHS.country AS country, RHS.x AS x, RHS.y AS y, RHS.iata AS iata, RHS.icao AS icao FROM (SELECT MAX(elevation) AS elevation FROM airports) AS LHS LEFT JOIN airports AS RHS ON (LHS.elevation = RHS.elevation)) ORDER BY country;

/*
Gold Result:
('Argentina',)
('Zambia',)
*/

-- Prediction Query
SELECT country FROM airports ORDER BY elevation DESC, airports.apid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zambia',)
*/