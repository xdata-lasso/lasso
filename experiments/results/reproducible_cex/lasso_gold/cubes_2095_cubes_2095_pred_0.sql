-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1020, 'Gina Moore', 'Curtisfurt', 'Bhutan', 1021.5, 1022.5, 1023, 'her', 'throw');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1024, 'Dennis Williams', 'Herrerafurt', 'Belgium', 1025.5, 1026.5, NULL, 'old', 'finally');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1028, 'Lisa Hensley', 'Lake Chad', 'Belgium', 1029.5, 1030.5, 1031, 'recently', 'drive');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanelevation AS avg_elevation_, country FROM (SELECT country, AVG(elevation) AS meanelevation FROM airports GROUP BY country) ORDER BY avg_elevation_, country NULLS LAST;

/*
Gold Result:
(1023.0, 'Bhutan')
(1031.0, 'Belgium')
*/

-- Prediction Query
SELECT AVG(elevation), country FROM airports GROUP BY country;

/*
Prediction Result:
(1031.0, 'Belgium')
(1023.0, 'Bhutan')
*/