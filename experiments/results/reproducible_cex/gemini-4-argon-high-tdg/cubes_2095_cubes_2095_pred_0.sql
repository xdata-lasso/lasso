-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'JFK Airport', 'New York', 'USA', -73.77, 40.64, 10, 'JFK', 'KJFK');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'LAX Airport', 'Los Angeles', 'USA', -118.40, 33.94, 10, 'LAX', 'KLAX');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'ORD Airport', 'Chicago', 'USA', -87.90, 41.97, 40, 'ORD', 'KORD');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'YYZ Airport', 'Toronto', 'Canada', -79.63, 43.67, 1, 'YYZ', 'CYYZ');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'YVR Airport', 'Vancouver', 'Canada', -123.18, 49.19, 2, 'YVR', 'CYVR');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'GIG Airport', 'Rio', 'Brazil', -43.25, -22.80, 20, 'GIG', 'SBGL');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'EZE Airport', 'Buenos Aires', 'Argentina', -58.53, -34.82, 100, 'EZE', 'SAEZ');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (1, 'Delta', 'DL', 'DAL', 'DELTA', 'USA', 'Y');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (2, 'United', 'UA', 'UAL', 'UNITED', 'USA', 'Y');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (1, 1, 1, 2, 'LAX', 'JFK', 'DL', 'N');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (2, 2, 1, 3, 'ORD', 'JFK', 'UA', 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanelevation AS avg_elevation_, country FROM (SELECT country, AVG(elevation) AS meanelevation FROM airports GROUP BY country) ORDER BY avg_elevation_, country NULLS LAST;

/*
Gold Result:
(1.5, 'Canada')
(20.0, 'Brazil')
(20.0, 'USA')
(100.0, 'Argentina')
*/

-- Prediction Query
SELECT AVG(elevation), country FROM airports GROUP BY country;

/*
Prediction Result:
(100.0, 'Argentina')
(20.0, 'Brazil')
(1.5, 'Canada')
(20.0, 'USA')
*/