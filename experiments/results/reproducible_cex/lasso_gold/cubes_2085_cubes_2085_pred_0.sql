-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1013, 'Kevin Pacheco', 'Curtisfurt', 'Bhutan', 1016.5, 1019.5, 1022, 'guy', 'surface');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1014, 'Robert Wolfe', 'Curtisfurt', 'Guinea-Bissau', 1027.5, 1032.5, 1037.0, 'PM', 'animal');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1015, 'Christopher Bernard', 'Curtisfurt', 'Tanzania', 1038.5, 1045.5, 1052.0, 'everything', 'show');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1049, 'Frederick Tate', NULL, 'Indonesia', 1052.5, 1055.5, 1058, 'question', 'evidence');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1050, 'Rodney Trujillo', NULL, 'Turks and Caicos Islands', 1063.5, 1068.5, 1073.0, 'low', 'chair');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1051, 'Austin Gentry', NULL, 'United States Virgin Islands', 1074.5, 1081.5, 1088.0, 'character', 'employee');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM (SELECT city, COUNT(*) AS n FROM airports GROUP BY city) WHERE (n > 2) ORDER BY city;

/*
Gold Result:
(None,)
('Curtisfurt',)
*/

-- Prediction Query
SELECT city FROM airports GROUP BY city HAVING COUNT(*) > 2 ORDER BY COUNT(*), city NULLS LAST;

/*
Prediction Result:
('Curtisfurt',)
(None,)
*/