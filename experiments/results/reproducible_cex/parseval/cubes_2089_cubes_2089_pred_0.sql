-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airports --
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1, 'air_4ee4ae', '5k5swwqcgs', '9n8', 874.871895, 475.173408, -49, '15f', '8b03');

INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (2, 'air_4ee4ae', 'u7', 'fe4hri', 710.998147, 945.642658, -49, '15f', '8b03');

INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (3, 'air_4ee4ae', 'ypuzhsrw', 'b', 749.826493, 503.083789, -49, '15f', '8b03');

INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (4, 'hvdltt', 'lbn', 'rmdp', 227.766936, 971.82669, 51, '15f', '8b03');

INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (5, '5k5swwqcgs', '9n8', '4', 249.706432, 99.523333, -50, '15f', '8b03');

INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (6, '5k5swwqcgs', '9n8', '4', 249.706432, 99.523333, NULL, '15f', '8b03');

INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (7, '7vfe4h', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, NULL, '15f', '8b03');

INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (8, 'l', 'tilbn', 'rmdp', 227.766936, 971.82669, NULL, '15f', '8b03');

INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (9, 'ie5', 'nw6klf', 'a9000t5c4eci', 734.586266, 767.720387, NULL, '15f', '8b03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM airports WHERE (elevation > -50 AND elevation <= 50) ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('air_4ee4ae',)
('air_4ee4ae',)
('air_4ee4ae',)
*/

-- Prediction Query
SELECT name FROM airports WHERE elevation BETWEEN -50 AND 50;

/*
Prediction Result:
('air_4ee4ae',)
('air_4ee4ae',)
('air_4ee4ae',)
('5k5swwqcgs',)
*/