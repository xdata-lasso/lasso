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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1255, 'memory', 'Cynthia Moore', '7737 Patrick Rapid Apt. 146
Sarahhaven, KY 00837', 'Cape Verde', 1259.5, 1263.5, 1267, 'https://schwartz.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1256, 'campaign', 'Kristen Davis', '972 Ryan Key Suite 886
Cantuborough, UT 31801', 'Belarus', 1272.5, 1278.5, 1284.0, 'https://higgins.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1257, 'air', 'Susan Murray MD', '0576 Mcneil Turnpike
South Tammie, DC 66337', 'Latvia', 1285.5, 1293.5, 1301.0, 'http://www.cohen.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1258, 'professor', 'Kathleen Moran', 'Unit 5171 Box 8702
DPO AA 86324', 'Slovenia', 1298.5, 1308.5, 1318.0, 'https://www.padilla.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1339, 'staff', 'Destiny Riggs', '681 Thomas Tunnel
Williamville, NV 66540', 'Iran', 1343.5, 1347.5, 1351, 'https://scott.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1340, 'choose', 'Ms. Rebecca Rodriguez', '847 Bruce Neck
Simmonsville, NM 93876', 'Israel', 1356.5, 1362.5, 1368.0, 'http://www.davis.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1341, 'story', 'Bonnie Howard', 'PSC 1159, Box 2124
APO AP 83479', 'Saint Lucia', 1369.5, 1377.5, 1385.0, 'http://www.frye.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1342, 'wear', 'Leah Smith', '9847 Garcia Squares Apt. 836
Beasleychester, MA 59942', 'Germany', 1382.5, 1392.5, 1402.0, 'https://williams.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1423, 'gun', 'David Kim', '1864 Cummings Shoals
West Christopher, TN 19038', 'Puerto Rico', 1427.5, 1431.5, 1435, 'http://jenkins.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1424, 'send', 'Joseph Moore', 'PSC 4629, Box 1486
APO AP 43555', 'Sierra Leone', 1440.5, 1446.5, 1452.0, 'https://bowers.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1425, 'mother', 'Douglas Ortiz', '685 Michael Falls
West Stacey, NM 25667', 'Nigeria', 1453.5, 1461.5, 1469.0, 'http://valentine.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1426, 'race', 'Kyle Mccormick', '14188 Ebony Wells
New Nicholas, GA 24204', 'Sudan', 1466.5, 1476.5, 1486.0, 'https://montoya.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1271, 'well', 'Ian Jordan', 'Myanmar', 'https://estrada-nolan.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1272, 'any', 'Jason Maldonado', 'Cambodia', 'https://www.alexander.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1273, 'garden', 'Christopher Lynch', 'Djibouti', 'https://wright.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1274, 'style', 'Michael Jimenez', 'Kyrgyz Republic', 'https://www.james.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1355, 'participant', 'Dr. Gregory Hawkins', 'New Caledonia', 'https://www.nelson.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1356, 'movement', 'Donald Perez', 'Vanuatu', 'https://www.kane.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1357, 'difference', 'Justin Saunders', 'Palestinian Territory', 'http://www.schultz.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1358, 'realize', 'Megan Hawkins', 'Switzerland', 'https://peterson-wood.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1439, 'turn', 'Kristen Garcia', 'Cyprus', 'https://www.brown-shaw.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1440, 'enough', 'Sarah Mitchell', 'Svalbard & Jan Mayen Islands', 'https://www.walker-flores.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1441, 'put', 'Denise Whitehead', 'Korea', 'https://www.johnson.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1442, 'medical', 'Jeffrey Potts', 'Turks and Caicos Islands', 'https://smith.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1275, 'find', 1279, 'reason', 'Melissa Garner', 'Oliver', '1994-03-02', 'Taiwan', 'http://johnson-diaz.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1276, 'scene', 1286.0, 'individual', 'Larry Crawford', 'Byrd', '1994-03-03', 'Burundi', 'http://burgess-thompson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1277, 'age', 1293.0, 'face', 'Donna Lindsey', 'Le', '1994-03-04', 'Niue', 'https://scott.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1278, 'themselves', 1300.0, 'across', 'Heather Fields', 'Hopkins', '1994-03-05', 'Bhutan', 'https://www.mccarty-taylor.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1359, 'standard', 1363, 'become', 'Luke Craig', 'Gregory', '1973-11-10', 'Indonesia', 'http://saunders.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1360, 'year', 1370.0, 'use', 'Matthew Tucker', 'Tucker', '1973-11-11', 'Netherlands Antilles', 'https://www.jimenez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1361, 'out', 1377.0, 'area', 'Donald Fischer', 'Estrada', '1973-11-12', 'Azerbaijan', 'http://padilla.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1362, 'pick', 1384.0, 'clearly', 'Jeffrey Campbell', 'Williams', '1973-11-13', 'Albania', 'http://williams.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1443, 'official', 1447, 'land', 'Anthony Barnes', 'Patterson', '1981-08-18', 'Papua New Guinea', 'https://www.stephens.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1444, 'yard', 1454.0, 'bring', 'Joyce Rodriguez', 'Mendez', '1981-08-19', 'Paraguay', 'https://reid.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1445, 'politics', 1461.0, 'fight', 'Linda Smith', 'Allen', '1981-08-20', 'Belize', 'http://cooper.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1446, 'news', 1468.0, 'economy', 'Dana Thomas', 'Butler', '1981-08-21', 'Malta', 'https://www.bell.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1283, 'https://gibbs.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1284, 'http://chambers-chambers.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1285, 'https://leonard.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1286, 'https://www.brown.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1367, 'https://bowman.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1368, 'http://gillespie.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1369, 'https://miller.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1370, 'https://www.dixon.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1451, 'https://white.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1452, 'http://atkins-williams.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1453, 'https://www.kim-ross.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1454, 'https://crawford.com/');
INSERT INTO "status" ("statusid", "status") VALUES (1287, 'range');
INSERT INTO "status" ("statusid", "status") VALUES (1288, 'issue');
INSERT INTO "status" ("statusid", "status") VALUES (1289, 'but');
INSERT INTO "status" ("statusid", "status") VALUES (1290, 'challenge');
INSERT INTO "status" ("statusid", "status") VALUES (1371, 'Mrs');
INSERT INTO "status" ("statusid", "status") VALUES (1372, 'daughter');
INSERT INTO "status" ("statusid", "status") VALUES (1373, 'western');
INSERT INTO "status" ("statusid", "status") VALUES (1374, 'stand');
INSERT INTO "status" ("statusid", "status") VALUES (1455, 'window');
INSERT INTO "status" ("statusid", "status") VALUES (1456, 'subject');
INSERT INTO "status" ("statusid", "status") VALUES (1457, 'natural');
INSERT INTO "status" ("statusid", "status") VALUES (1458, 'example');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1291, 1283, 1295, 1255, 'Andrew Ferrell', '1998-07-06', 'short', 'http://russell.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1292, 1283, 1302.0, 1255, 'David Medina', '1998-07-07', 'clear', 'http://sampson-foley.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1293, 1283, 1309.0, 1255, 'Jacob Avery', '1998-07-08', 'value', 'https://sanders.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1294, 1283, 1316.0, 1255, 'Kimberly Matthews', '1998-07-09', 'join', 'https://www.lewis.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1375, 1367, 1379, 1339, 'Nicholas Fuentes', '1977-04-14', 'minute', 'https://stewart.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1376, 1367, 1386.0, 1339, 'Cynthia Thomas', '1977-04-15', 'majority', 'https://www.romero-collins.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1377, 1367, 1393.0, 1339, 'Lance Wolf', '1977-04-16', 'somebody', 'http://www.decker-jones.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1378, 1367, 1400.0, 1339, 'Cassandra Mejia', '1977-04-17', 'organization', 'https://spencer.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1507, 1451, 1462, 1423, 'Monica Miller', '1985-01-22', 'road', 'http://bolton.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1459, 1451, 1469.0, 1423, 'Samantha Gardner', '1985-01-23', 'life', 'http://palmer-brady.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1460, 1451, 1476.0, 1423, 'Bobby Guerrero', '1985-01-24', 'have', 'http://www.gregory.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1461, 1451, 1483.0, 1423, 'Lance Simmons', '1985-01-25', 'likely', 'https://herring-johnson.com/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1299, 1291, 1275, 1271, 1303, 1307, 1311, 'stop', 1315, 1319.5, 1323, 'other', 1327, 1331, 1335, 'once', 'tax', 1287);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1300, 1291, 1275, 1271, 1314.0, 1320.0, 1326.0, 'goal', 1334.0, 1340.5, 1346.0, 'describe', 1354.0, 1360.0, 1366.0, 'despite', 'true', 1287);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1301, 1291, 1275, 1271, 1325.0, 1333.0, 1341.0, 'either', 1353.0, 1361.5, 1369.0, 'authority', 1381.0, 1389.0, 1397.0, 'peace', 'early', 1287);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1302, 1291, 1275, 1271, 1336.0, 1346.0, 1356.0, 'car', 1372.0, 1382.5, 1392.0, 'southern', 1408.0, 1418.0, 1428.0, 'direction', 'get', 1287);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1383, 1375, 1359, 1355, 1387, 1391, 1395, 'when', 1399, 1403.5, 1407, NULL, 1411, 1415, 1419, 'more', 'board', 1371);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1384, 1375, 1359, 1355, 1398.0, 1404.0, 1410.0, 'take', 1418.0, 1424.5, 1430.0, NULL, 1438.0, 1444.0, 1450.0, 'city', 'talk', 1371);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1385, 1375, 1359, 1355, 1409.0, 1417.0, 1425.0, 'owner', 1437.0, 1445.5, 1453.0, NULL, 1465.0, 1473.0, 1481.0, 'assume', 'way', 1371);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1386, 1375, 1359, 1355, 1420.0, 1430.0, 1440.0, 'reach', 1456.0, 1466.5, 1476.0, NULL, 1492.0, 1502.0, 1512.0, 'little', 'third', 1371);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1466, 1375, 1443, 1439, 1470, 1474, 1478, 'respond', 1482, 1486.5, 1490, 'source', 1494, 1498, 1502, 'next', 'rate', 1455);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1467, 1375, 1443, 1439, 1481.0, 1487.0, 1493.0, 'listen', 1501.0, 1507.5, 1513.0, 'ball', 1521.0, 1527.0, 1533.0, 'hit', 'family', 1455);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1468, 1375, 1443, 1439, 1492.0, 1500.0, 1508.0, 'hospital', 1520.0, 1528.5, 1536.0, 'painting', 1548.0, 1556.0, 1564.0, 'information', 'enjoy', 1455);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1469, 1375, 1443, 1439, 1503.0, 1513.0, 1523.0, 'hot', 1539.0, 1549.5, 1559.0, 'certain', 1575.0, 1585.0, 1595.0, 'former', 'build', 1455);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1506, 1291, 1275, 1271, 1303, 1307, 1311, 'stop', 1315, 1319.5, 1323, NULL, 1327, 1331, 1335, 'once', 'tax', 1287);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT raceId FROM results GROUP BY raceId ORDER BY COUNT(NOT time IS NULL) DESC, raceId NULLS LAST LIMIT 1;

/*
Gold Result:
(1375,)
*/

-- Prediction Query
SELECT "raceid" FROM "results" WHERE NOT "time" IS NULL GROUP BY "raceid" ORDER BY COUNT("raceid") DESC, "raceid" NULLS LAST LIMIT 1;

/*
Prediction Result:
(1291,)
*/