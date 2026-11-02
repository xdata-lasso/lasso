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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1403, 'effect', 'Johnny Khan', '8416 Duran Harbors
East Theresafurt, MN 44945', 'Estonia', 1407.5, 1411.5, 1415, 'http://www.castillo.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1404, 'past', 'Julie Herrera', '39868 Brandon Dam Suite 787
New Patricia, DC 43488', 'Slovenia', 1420.5, 1426.5, 1432.0, 'http://www.armstrong.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1405, 'head', 'Jessica Khan', 'USNV Martin
FPO AP 97405', 'Singapore', 1433.5, 1441.5, 1449.0, 'http://www.edwards-hernandez.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1406, 'anything', 'Pamela Diaz', '887 Wells Brook Suite 516
Lauratown, PA 62706', 'Mozambique', 1446.5, 1456.5, 1466.0, 'https://luna.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1451, 'generation', 'Charles Morris', '174 Richard Parkway
Hannahport, MN 81061', 'Israel', 1455.5, 1459.5, 1463, 'https://www.scott-smith.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1452, 'institution', 'Dean Young', '2795 Miles Mountains
Port John, WV 78595', 'Korea', 1468.5, 1474.5, 1480.0, 'http://www.cooper-brown.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1453, 'relationship', 'Tiffany Turner', '785 Samantha Creek
Port Amyhaven, ID 75566', 'Kyrgyz Republic', 1481.5, 1489.5, 1497.0, 'http://mitchell.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1454, 'beyond', 'Alexandra Valdez', '8713 Davis Pass
Stokesmouth, DC 67773', 'Peru', 1494.5, 1504.5, 1514.0, 'https://west-stark.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1499, 'who', 'Jennifer Allen', '55609 Joyce Brook Suite 899
Phillipsborough, MA 30650', 'Saint Helena', 1503.5, 1507.5, 1511, 'http://rodriguez.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1500, 'eight', 'Douglas Owens', '8547 Murray Street
Garyside, NM 24624', 'Falkland Islands (Malvinas)', 1516.5, 1522.5, 1528.0, 'http://www.harvey.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1501, 'safe', 'Elizabeth Ward', 'PSC 8080, Box 1006
APO AE 83168', 'Mauritania', 1529.5, 1537.5, 1545.0, 'https://watson.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1502, 'PM', 'Julie Lang', '38750 Hopkins Brook
New Andreatown, AK 69892', 'France', 1542.5, 1552.5, 1562.0, 'http://www.sutton-abbott.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1419, 'garden', 1423, 'however', 'Gloria Gomez', 'Dudley', '1979-02-22', 'Ghana', 'https://berry.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1420, 'recognize', 1430.0, 'former', 'Michelle Schneider', 'Evans', '1979-02-23', 'Lesotho', 'https://roberts.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1421, 'mean', 1437.0, 'consumer', 'Lisa Lee', 'Roberts', '1979-02-24', 'Guernsey', 'https://scott.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1422, 'never', 1444.0, 'machine', 'Justin Walker', 'Clark', '1979-02-25', 'Monaco', 'http://www.santiago.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1467, 'how', 1471, 'notice', 'Christopher Medina', 'Morrow', '1987-10-07', 'Vietnam', 'http://www.barnes.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1468, 'be', 1478.0, 'cell', 'Monica Walker', 'Wright', '1987-10-08', 'Turkey', 'http://www.garcia.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1469, 'result', 1485.0, 'ready', 'Alexander Evans', 'Reed', '1987-10-09', 'Saint Kitts and Nevis', 'http://www.williams.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1470, 'recently', 1492.0, 'trade', 'Kimberly Patel', 'Hill', '1987-10-10', 'Serbia', 'http://cabrera.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1515, 'better', 1519, 'old', 'Christopher Porter', 'Clay', '1995-07-15', 'Uzbekistan', 'http://www.smith-clark.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1516, 'into', 1526.0, 'maybe', 'Richard Knight', 'Alvarez', '1995-07-16', 'Fiji', 'https://www.martin-allen.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1517, 'hundred', 1533.0, 'arrive', 'Anna Rice', 'Williams', '1995-07-17', 'United Arab Emirates', 'https://taylor.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1518, 'huge', 1540.0, 'public', 'Daniel Parrish', 'Jones', '1995-07-18', 'Mayotte', 'https://www.kim.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1427, 'http://www.gutierrez.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1428, 'http://www.oconnell.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1429, 'https://gonzalez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1430, 'http://www.rodgers.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1475, 'https://turner.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1476, 'http://hill-hawkins.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1477, 'http://simpson.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1478, 'https://hernandez-bennett.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1523, 'https://walters.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1524, 'http://pugh.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1525, 'http://marquez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1526, 'http://bowers.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, 1427, 1435, 1403, 'Ryan Peck', '1983-06-03', 'player', 'https://daniels.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1432, 1427, 1442.0, 1403, 'Russell French', '1983-06-04', 'both', 'https://lamb.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1433, 1427, 1449.0, 1403, 'Paul Brennan', '1983-06-05', 'without', 'https://lopez.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1434, 1427, 1456.0, 1403, 'Andrew Evans', '1983-06-06', 'government', 'http://www.chase.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (150, 1475, 1483, 1451, 'Samuel Turner', '1991-03-11', 'radio', 'https://www.hardy.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1480, 1475, 1490.0, 1451, 'Renee Melendez', '1991-03-12', 'bar', 'http://www.ballard.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1481, 1475, 1497.0, 1451, 'Tracy Grant', '1991-03-13', 'win', 'http://booth.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1482, 1475, 1504.0, 1451, 'David Harris', '1991-03-14', 'throw', 'http://www.hayden.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (20, 1523, 1531, 1499, 'Aaron Parker', '1970-11-19', 'picture', 'http://hughes-miller.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1528, 1523, 1538.0, 1499, 'Derrick Anderson', '1970-11-20', 'piece', 'http://www.james.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1529, 1523, 1545.0, 1499, 'Jerry Peters', '1970-11-21', 'still', 'http://www.hamilton.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1530, 1523, 1552.0, 1499, 'Alexander Gomez', '1970-11-22', 'image', 'https://www.king-wright.info/');
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 1419, 1439, 1443, '12:34.56', 1447);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 1420, 1440, 1452.0, '12:34.56', 1460.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 1421, 1441, 1461.0, '12:34.56', 1473.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 1422, 1442, 1470.0, '12:34.56', 1486.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (150, 1467, 1487, 1491, '12:34.56', 1495);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (150, 1468, 1488, 1500.0, '12:34.56', 1508.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (150, 1469, 1489, 1509.0, '12:34.56', 1521.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (150, 1470, 1490, 1518.0, '12:34.56', 1534.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (20, 1515, 1535, 1539, 'phone', 1543);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (20, 1516, 1536, 1548.0, 'phone', 1556.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (20, 1517, 1537, 1557.0, 'phone', 1569.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (20, 1518, 1538, 1566.0, 'phone', 1582.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT time FROM lapTimes ORDER BY (CASE WHEN INSTR(time, ':') <> INSTR(SUBSTRING(time, INSTR(time, ':') + 1), ':') + INSTR(time, ':') THEN CAST(SUBSTRING(time, 1, INSTR(time, ':') - 1) AS REAL) * 3600 ELSE 0 END) + (CAST(SUBSTRING(time, INSTR(time, ':') - 2 * (INSTR(time, ':') = INSTR(SUBSTRING(time, INSTR(time, ':') + 1), ':') + INSTR(time, ':')), INSTR(time, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(time, INSTR(time, ':') + 1, INSTR(time, '.') - INSTR(time, ':') - 1) AS REAL)) + (CAST(SUBSTRING(time, INSTR(time, '.') + 1) AS REAL) / 1000) ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 1;

/*
Gold Result:
('phone',)
*/

-- Prediction Query
SELECT time FROM lapTimes ORDER BY time ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 1;

/*
Prediction Result:
('12:34.56',)
*/