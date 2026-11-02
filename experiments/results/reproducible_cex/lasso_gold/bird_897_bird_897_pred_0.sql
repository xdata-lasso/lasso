-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, location TEXT, country TEXT, lat REAL, lng REAL, alt INTEGER, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE constructors (constructorId INTEGER PRIMARY KEY AUTOINCREMENT, constructorRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL UNIQUE, nationality TEXT, url TEXT DEFAULT '' NOT NULL);

CREATE TABLE drivers (driverId INTEGER PRIMARY KEY AUTOINCREMENT, driverRef TEXT DEFAULT '' NOT NULL, number INTEGER, code TEXT, forename TEXT DEFAULT '' NOT NULL, surname TEXT DEFAULT '' NOT NULL, dob DATE, nationality TEXT, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

CREATE TABLE constructorResults (constructorResultsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, points REAL, status TEXT, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE constructorStandings (constructorStandingsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT, wins INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE driverStandings (driverStandingsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT, wins INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE lapTimes (raceId INTEGER NOT NULL, driverId INTEGER NOT NULL, lap INTEGER NOT NULL, position INTEGER, time TEXT, milliseconds INTEGER, PRIMARY KEY (raceId, driverId, lap), FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE pitStops (raceId INTEGER NOT NULL, driverId INTEGER NOT NULL, stop INTEGER NOT NULL, lap INTEGER NOT NULL, time TEXT NOT NULL, duration TEXT, milliseconds INTEGER, PRIMARY KEY (raceId, driverId, stop), FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE qualifying (qualifyId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, number INTEGER DEFAULT 0 NOT NULL, position INTEGER, q1 TEXT, q2 TEXT, q3 TEXT, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE status (statusId INTEGER PRIMARY KEY AUTOINCREMENT, status TEXT DEFAULT '' NOT NULL);

CREATE TABLE results (resultId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, number INTEGER, grid INTEGER DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT DEFAULT '' NOT NULL, positionOrder INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, laps INTEGER DEFAULT 0 NOT NULL, time TEXT, milliseconds INTEGER, fastestLap INTEGER, rank INTEGER DEFAULT 0, fastestLapTime TEXT, fastestLapSpeed TEXT, statusId INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId), FOREIGN KEY (statusId) REFERENCES status (statusId));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1205, 'main', 'David Murphy', '4641 Smith Plains Apt. 531
Port Anthonybury, ID 03172', 'Nigeria', 1206.5, 1207.5, 1208, 'http://www.wells.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1244, 'structure', 'Edward Sullivan', '8856 Bell Motorway Suite 443
Lake Jamesville, WA 70737', 'Zambia', 1245.5, 1246.5, 1247, 'http://www.rodgers.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1283, 'raise', 'Derek Thomas', '947 Taylor Hollow Suite 488
Kimton, FM 57127', 'Saint Pierre and Miquelon', 1284.5, 1285.5, 1286, 'https://davis.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1209, 'yourself', 1213, 'establish', 'Tracey Higgins', 'Strickland', '1981-08-18', 'Central African Republic', 'https://www.johnson.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1210, 'discover', 1220.0, 'speak', 'Tracey Higgins', 'Strickland', '1981-08-19', 'Central African Republic', 'https://www.vargas.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1211, 'make', 1227.0, 'home', 'Tracey Higgins', 'Strickland', '1981-08-20', 'Central African Republic', 'http://burke.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1212, 'scene', 1234.0, 'computer', 'Tracey Higgins', 'Strickland', '1981-08-21', 'Central African Republic', 'https://wood.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1248, 'soon', 1252, 'black', 'Christopher Smith', 'Ferguson', '1989-05-03', 'Falkland Islands (Malvinas)', 'http://www.carter.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1249, 'network', 1259.0, 'there', 'Christopher Smith', 'Ferguson', '1989-05-04', 'Falkland Islands (Malvinas)', 'http://www.mitchell.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1250, 'picture', 1266.0, 'daughter', 'Christopher Smith', 'Ferguson', '1989-05-05', 'Falkland Islands (Malvinas)', 'https://short.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1251, 'fear', 1273.0, 'fine', 'Christopher Smith', 'Ferguson', '1989-05-06', 'Falkland Islands (Malvinas)', 'http://www.hernandez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1287, 'people', 1291, 'term', 'Christopher Smith', 'Ferguson', '1997-02-11', 'Falkland Islands (Malvinas)', 'http://pearson.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1288, 'against', 1298.0, 'exist', 'Christopher Smith', 'Ferguson', '1997-02-12', 'Falkland Islands (Malvinas)', 'https://harrison.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1289, 'southern', 1305.0, 'part', 'Christopher Smith', 'Ferguson', '1997-02-13', 'Falkland Islands (Malvinas)', 'https://www.rivera.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1290, 'remember', 1312.0, 'amount', 'Christopher Smith', 'Ferguson', '1997-02-14', 'Falkland Islands (Malvinas)', 'https://johnson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1217, 'https://www.yu-reid.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1256, 'http://www.grant.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1295, 'https://www.booth.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1218, 1217, 1225, 1205, 'Jessica Gross', '1985-01-22', 'then', 'https://www.hudson-barnett.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1219, 1217, 1232.0, 1205, 'Debra Morton', '1985-01-23', 'worry', 'http://white-lewis.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1220, 1217, 1239.0, 1205, 'Karen Graham', '1985-01-24', 'before', 'https://haynes.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1221, 1217, 1246.0, 1205, 'Debra Christian', '1985-01-25', 'family', 'http://www.russell.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1257, 1256, 1264, 1244, 'Lisa Rowe', '1993-09-07', 'source', 'https://www.allen.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1258, 1256, 1271.0, 1244, 'Terry Evans', '1993-09-08', 'despite', 'http://www.hayes-wheeler.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1259, 1256, 1278.0, 1244, 'Jessica Carroll', '1993-09-09', 'process', 'http://www.mann-warner.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1260, 1256, 1285.0, 1244, 'Tyler Garcia', '1993-09-10', 'development', 'http://www.french-weber.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1296, 1295, 1303, 1283, 'Peter Garrett', '1972-06-15', 'education', 'http://walker.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1297, 1295, 1310.0, 1283, 'Christina Dunn', '1972-06-16', 'security', 'http://www.cantu-carter.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1298, 1295, 1317.0, 1283, 'Jessica Wolfe', '1972-06-17', 'cold', 'https://sanchez-arnold.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1299, 1295, 1324.0, 1283, 'William Lynch', '1972-06-18', 'foreign', 'http://www.hill.com/');
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1232, 1218, 1209, 1236.5, 1240, 'race', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1233, 1218, 1209, 1245.5, 1251.0, 'seek', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1234, 1218, 1209, 1254.5, 1262.0, 'military', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1235, 1218, 1209, 1263.5, 1273.0, 'line', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1271, 1257, 1248, 1275.5, NULL, 'large', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1272, 1257, 1248, 1284.5, NULL, 'building', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1273, 1257, 1248, 1293.5, NULL, 'off', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1274, 1257, 1248, 1302.5, NULL, 'down', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1310, 1296, 1287, 1314.5, 1318, 'world', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1311, 1296, 1287, 1323.5, 1329.0, 'store', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1312, 1296, 1287, 1332.5, 1340.0, 'movement', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1313, 1296, 1287, 1341.5, 1351.0, 'example', 1);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1322, 1218, 1209, 1236.5, NULL, 'race', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname, T1.nationality, AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T2.driverId = T1.driverId WHERE T2.wins = 1 GROUP BY T1.forename, T1.surname, T1.nationality ORDER BY COUNT(T2.wins) DESC, T1.forename NULLS LAST, T1.surname NULLS LAST, T1.nationality NULLS LAST, AVG(T2.points) NULLS LAST LIMIT 1;

/*
Gold Result:
('Christopher Smith', 'Ferguson', 'Falkland Islands (Malvinas)', 1308.5)
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T1.nationality, AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T1.driverId = T2.driverId GROUP BY T1.driverId ORDER BY COUNT(T2.wins) DESC, T1.forename NULLS LAST, T1.surname NULLS LAST, T1.nationality NULLS LAST, AVG(T2.points) NULLS LAST LIMIT 1;

/*
Prediction Result:
('Tracey Higgins', 'Strickland', 'Central African Republic', 1247.3)
*/