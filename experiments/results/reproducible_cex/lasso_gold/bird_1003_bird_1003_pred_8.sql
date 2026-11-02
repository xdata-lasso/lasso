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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1226, 'now', 'Chris Reyes', '66587 Brown Village
Priceshire, UT 03061', 'Togo', 1227.5, 1228.5, 1229, 'https://bender.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1300, 'better', 'Jared Sanchez', '8856 Bell Motorway Suite 443
Lake Jamesville, WA 70737', 'Zambia', 1301.5, 1302.5, 1303, 'http://www.rodgers.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1230, 'tonight', 'Morgan Marsh', 'Nigeria', 'https://www.day.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1231, 'wait', 'Katherine Nelson', 'Martinique', 'http://www.gray-lewis.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1232, 'thing', 'Mr. Michael Yates', 'Anguilla', 'https://walton-decker.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1233, 'kind', 'Sara Calhoun', 'United States of America', 'http://curry.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1304, 'soon', 'Dr. Elizabeth Ward', 'Bosnia and Herzegovina', 'https://alexander-lopez.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1305, 'network', 'Michael Martinez', 'Tunisia', 'https://short.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1306, 'picture', 'Anthony Carter', 'American Samoa', 'http://www.hernandez.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1307, 'fear', 'Margaret Mullins', 'Montserrat', 'http://www.grant.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1234, 'door', 1238, 'reach', 'Christina Smith', 'Adkins', '1994-03-02', 'Botswana', 'https://gonzalez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1235, 'rate', 1245.0, 'amount', 'Cameron Caldwell', 'Wilson', '1994-03-03', 'Mozambique', 'http://burke.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1236, 'authority', 1252.0, 'somebody', 'Claudia Lyons', 'Weiss', '1994-03-04', 'Vanuatu', 'https://wood.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1237, 'statement', 1259.0, 'allow', 'Carol Lawson', 'Oconnell', '1994-03-05', 'Georgia', 'https://www.yu-reid.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1308, 'pick', 1312, 'stand', 'Elizabeth Chapman', 'Allen', '1973-11-10', 'Portugal', 'http://www.mann-warner.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1309, 'street', 1319.0, 'necessary', 'Keith Brown', 'Arnold', '1973-11-11', 'Nepal', 'http://www.french-weber.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1310, 'present', 1326.0, 'husband', 'Annette Farmer', 'Moore', '1973-11-12', 'Latvia', 'https://www.walker.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1311, 'draw', 1333.0, 'little', 'Deborah Miller', 'Ortiz', '1973-11-13', 'French Guiana', 'http://www.sparks.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1242, 'http://gross.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1316, 'https://harrison.biz/');
INSERT INTO "status" ("statusid", "status") VALUES (3, 'power');
INSERT INTO "status" ("statusid", "status") VALUES (1243, 'system');
INSERT INTO "status" ("statusid", "status") VALUES (1244, 'wide');
INSERT INTO "status" ("statusid", "status") VALUES (1245, 'nothing');
INSERT INTO "status" ("statusid", "status") VALUES (1374, 'yes');
INSERT INTO "status" ("statusid", "status") VALUES (1317, 'expert');
INSERT INTO "status" ("statusid", "status") VALUES (1318, 'month');
INSERT INTO "status" ("statusid", "status") VALUES (1319, 'notice');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1246, 1242, 1253, 1226, 'Canadian Grand Prix', '1998-07-06', 'stage', 'https://rivas.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1247, 1242, 1260.0, 1226, 'Canadian Grand Prix', '1998-07-07', 'member', 'https://www.hudson-barnett.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1248, 1242, 1267.0, 1226, 'Canadian Grand Prix', '1998-07-08', 'make', 'http://white-lewis.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1249, 1242, 1274.0, 1226, 'Canadian Grand Prix', '1998-07-09', 'least', 'https://haynes.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1320, 1316, 1327, 1300, 'Canadian Grand Prix', '1977-04-14', 'minute', 'http://morris.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1321, 1316, 1334.0, 1300, 'Canadian Grand Prix', '1977-04-15', 'left', 'http://williams.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1322, 1316, 1341.0, 1300, 'Canadian Grand Prix', '1977-04-16', 'be', 'https://www.graham.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1323, 1316, 1348.0, 1300, 'Canadian Grand Prix', '1977-04-17', 'piece', 'https://morris-garcia.com/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1260, 1246, 1234, 1230, 1264, 1268, 1272, 'bed', 1276, 1280.5, 1284, 'middle', 1288, 1292, 1296, 'rock', 'military', 3);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1261, 1246, 1234, 1230, 1275.0, 1281.0, 1287.0, 'effort', 1295.0, 1301.5, 1307.0, 'one', 1315.0, 1321.0, 1327.0, 'maybe', 'line', 3);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1262, 1246, 1234, 1230, 1286.0, 1294.0, 1302.0, 'service', 1314.0, 1322.5, 1330.0, 'son', 1342.0, 1350.0, 1358.0, 'race', 'structure', 3);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1263, 1246, 1234, 1230, 1297.0, 1307.0, 1317.0, 'investment', 1333.0, 1343.5, 1353.0, 'effect', 1369.0, 1379.0, 1389.0, 'seek', 'adult', 3);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1334, 1320, 1308, 1304, NULL, 1342, 1346, 'girl', 1350, 1354.5, 1358, 'fight', 1362, 1366, 1370, 'teach', 'behavior', 3);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1335, 1320, 1308, 1304, NULL, 1355.0, 1361.0, 'its', 1369.0, 1375.5, 1381.0, 'recognize', 1389.0, 1395.0, 1401.0, 'oil', 'forward', 3);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1336, 1320, 1308, 1304, NULL, 1368.0, 1376.0, 'rule', 1388.0, 1396.5, 1404.0, 'you', 1416.0, 1424.0, 1432.0, 'although', 'entire', 3);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1337, 1320, 1308, 1304, NULL, 1381.0, 1391.0, 'mission', 1407.0, 1417.5, 1427.0, 'institution', 1443.0, 1453.0, 1463.0, 'look', 'game', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T3.statusId = 3 AND T2.name = 'Canadian Grand Prix' GROUP BY T1.driverId ORDER BY COUNT(T1.driverId) DESC LIMIT 1;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM results WHERE raceId IN (SELECT raceId FROM races WHERE name = 'Canadian Grand Prix') AND statusId = 3;

/*
Prediction Result:
(8,)
*/