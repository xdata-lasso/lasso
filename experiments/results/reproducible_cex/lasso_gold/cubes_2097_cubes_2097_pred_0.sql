-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1057, 'Kyle Mcdonald', 'Lake Nicoleview', 'Cuba', 1059.5, 1061.5, 1063, 'coach', 'about');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1058, 'Juan Dunlap', 'Danielchester', 'Argentina', 1070.5, 1074.5, 1078.0, 'long', 'seven');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1065, 'Deborah Mason', 'Meaganhaven', 'Cuba', 1067.5, 1069.5, 1071, 'color', 'start');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1066, 'Thomas Harrell', 'East Nathaniel', 'Argentina', 1078.5, 1082.5, 1086.0, 'notice', 'win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "airports" WHERE ("country" = 'Cuba' OR "country" = 'Argentina') ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('Deborah Mason',)
('Juan Dunlap',)
('Kyle Mcdonald',)
('Thomas Harrell',)
*/

-- Prediction Query
SELECT name FROM airports WHERE country = 'Cuba' OR country = 'Argentina';

/*
Prediction Result:
('Kyle Mcdonald',)
('Juan Dunlap',)
('Deborah Mason',)
('Thomas Harrell',)
*/