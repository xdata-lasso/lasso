-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1005, 'Leslie Johnson', 'East Jessetown', 'Monaco', 1006.5, 1007.5, 1008, 'decide', 'sense');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1009, NULL, 'Lisatown', 'Senegal', 1010.5, 1011.5, 1012, 'sure', 'collection');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1013, 'Gina Moore', 'Curtisfurt', 'Senegal', 1014.5, 1015.5, 1016, 'bill', 'her');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airports GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'Monaco')
(2, 'Senegal')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airports GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST;

/*
Prediction Result:
(2, 'Senegal')
(1, 'Monaco')
*/