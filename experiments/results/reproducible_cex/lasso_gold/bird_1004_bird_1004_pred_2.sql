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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1523, 'likely', 'Justin Brown', '72867 Angelica Spring Suite 064
Lake Jefferyland, AZ 56035', 'Saint Helena', 1527.5, 1531.5, 1535, 'https://www.murray.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1524, 'news', 'Kathy Armstrong', '017 Justin Falls
Port Darlene, VA 85157', 'Mayotte', 1540.5, 1546.5, 1552.0, 'http://www.pacheco.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1525, 'score', 'Garrett Meyer', 'USNV Haney
FPO AA 59291', 'Jamaica', 1553.5, 1561.5, 1569.0, 'http://www.jones.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1526, 'high', 'Daniel Aguilar', '1825 Gregory Plain Suite 823
Port Andrewport, NH 88777', 'Martinique', 1566.5, 1576.5, 1586.0, 'https://www.yang.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1575, 'particularly', 'Gary James', '28728 Alexandria Villages Apt. 006
Port Crystal, CA 93191', 'Azerbaijan', 1579.5, 1583.5, 1587, 'http://www.bruce-newman.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1576, 'service', 'Kathryn Pena', '750 Hopkins Brook
New Andreatown, AK 69892', 'Northern Mariana Islands', 1592.5, 1598.5, 1604.0, 'http://www.lewis.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1577, 'key', 'Dawn Underwood', '86211 John River Suite 546
West Susanmouth, OK 32378', 'Algeria', 1605.5, 1613.5, 1621.0, 'https://glass.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1578, 'find', 'Maria Henry', 'Unit 3410 Box 1666
DPO AP 62891', 'Reunion', 1618.5, 1628.5, 1638.0, 'http://www.smith-clark.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1539, 'east', 1543, 'treat', 'Donna Cabrera', 'Dennis', '1992-04-12', 'Ghana', 'https://www.walter-odom.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1540, 'notice', 1550.0, 'stand', 'Donna Cabrera', 'Dennis', '1992-04-13', 'Morocco', 'http://hill-hawkins.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1541, 'director', 1557.0, 'arrive', 'Donna Cabrera', 'Dennis', '1992-04-14', 'Netherlands Antilles', 'http://simpson.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1542, 'somebody', 1564.0, 'challenge', 'Donna Cabrera', 'Dennis', '1992-04-15', 'Peru', 'https://hernandez-bennett.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1591, 'soldier', 1595, 'woman', 'Donna Cabrera', 'Dennis', '1971-01-20', 'Montenegro', 'https://taylor.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1592, 'tend', 1602.0, 'ball', 'Donna Cabrera', 'Dennis', '1971-01-21', 'Syrian Arab Republic', 'https://www.kim.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1593, 'seem', 1609.0, 'organization', 'Donna Cabrera', 'Dennis', '1971-01-22', 'Thailand', 'https://walters.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1594, 'information', 1616.0, 'effect', 'Donna Cabrera', 'Dennis', '1971-01-23', 'Iceland', 'http://pugh.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1547, 'https://www.turner.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1548, 'https://www.gutierrez.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1549, 'http://rivera.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1550, 'https://www.hardy.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1599, 'http://marquez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1600, 'http://bowers.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1601, 'http://www.hahn.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1602, 'https://www.miller.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1551, 1547, 1555, 1523, 'Shelly Lopez', '1996-08-16', 'site', 'http://www.herman-arnold.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1552, 1547, 1562.0, 1523, 'Misty Hansen', '1996-08-17', 'buy', 'https://wong.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1553, 1547, 1569.0, 1523, 'Sean Cook', '1996-08-18', 'skin', 'https://www.harrison.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1554, 1547, 1576.0, 1523, 'Alexis Giles', '1996-08-19', 'measure', 'https://hart.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1603, 1599, 1607, 1575, 'Kayla Garcia', '1975-05-01', 'operation', 'http://taylor.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1604, 1599, 1614.0, 1575, 'Julian Carlson', '1975-05-02', 'west', 'https://www.jackson.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1605, 1599, 1621.0, 1575, 'Sharon Smith', '1975-05-03', 'eight', 'https://ward.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1606, 1599, 1628.0, 1575, 'Richard Hardy', '1975-05-04', 'owner', 'http://taylor.biz/');
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1559, 1551, 1539, 1563.5, 1567, 'admit', 1571);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1560, 1551, 1539, 1572.5, 1578.0, 'on', 1586.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1561, 1551, 1539, 1581.5, 1589.0, 'worry', 1601.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1562, 1551, 1539, 1590.5, 1600.0, 'pattern', 1616.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1611, 1603, 1591, 1615.5, 1619, 'go', 1623);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1612, 1603, 1591, 1624.5, 1630.0, 'thought', 1638.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1613, 1603, 1591, 1633.5, 1641.0, 'pressure', 1653.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1614, 1603, 1591, 1642.5, 1652.0, 'husband', 1668.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.wins) FROM driverStandings AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId GROUP BY T2.forename, T2.surname ORDER BY T2.dob ASC, SUM(T1.wins) NULLS LAST LIMIT 1;

/*
Gold Result:
(12956,)
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname, SUM(driverstandings.wins) FROM drivers INNER JOIN driverstandings ON drivers.driverid = driverstandings.driverid WHERE drivers.dob = (SELECT MIN(dob) FROM drivers) GROUP BY drivers.forename, drivers.surname;

/*
Prediction Result:
('Donna Cabrera', 'Dennis', 6582)
*/