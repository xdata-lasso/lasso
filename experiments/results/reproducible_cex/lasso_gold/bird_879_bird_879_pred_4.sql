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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1718, 'mind', 'Jason Washington', '7569 Kevin Rapids Apt. 752
Novakport, WA 91590', 'New Zealand', 1722.5, 1726.5, 1730, 'https://rodriguez-garcia.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1719, 'child', 'David Wright', '6465 Sarah Flats
Lake Katrina, AK 95818', 'Aruba', 1735.5, 1741.5, 1747.0, 'http://myers-barton.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1720, 'at', 'Linda Gonzalez', '4167 Cynthia Garden
Donnachester, WY 49913', 'Mongolia', 1748.5, 1756.5, 1764.0, 'http://webb.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1721, 'computer', 'Eric Rush', '688 Stephens Turnpike Suite 891
Port Johnstad, GA 85304', 'Oman', 1761.5, 1771.5, 1781.0, 'http://www.thomas.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1734, 'near', 'Nathan Chavez', 'Maldives', 'https://hall-sullivan.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1735, 'meeting', 'Andrew Page', 'China', 'http://johnson-mendez.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1736, 'happen', 'Greg Rodriguez', 'Micronesia', 'https://smith-lewis.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1737, 'maybe', 'Tara Yang', 'Cayman Islands', 'http://www.lopez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1738, 'religious', 1742, 'purpose', 'Laurie Bailey', 'Torres', '1981-04-01', 'Italy', 'https://tucker.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1739, 'travel', 1749.0, 'form', 'Lisa Cervantes', 'White', '1981-04-02', 'Nepal', 'http://taylor-edwards.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1740, 'might', 1756.0, 'picture', 'Elizabeth Mendez', 'Steele', '1981-04-03', 'Burundi', 'http://washington.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1741, 'news', 1763.0, 'important', 'Cesar Wilson', 'Dixon', '1981-04-04', 'Morocco', 'https://vasquez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1728, 'to', NULL, NULL, 'Joseph Robinson', 'Jordan', NULL, NULL, 'http://morris-campbell.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1746, 'http://www.carter.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1747, 'https://www.cunningham-barton.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1748, 'http://www.hampton-morrow.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1749, 'http://robinson.com/');
INSERT INTO "status" ("statusid", "status") VALUES (1750, 'finish');
INSERT INTO "status" ("statusid", "status") VALUES (1751, 'two');
INSERT INTO "status" ("statusid", "status") VALUES (1752, 'alone');
INSERT INTO "status" ("statusid", "status") VALUES (1753, 'listen');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1754, 1746, 1758, 1718, 'Scott Miller', '1985-08-05', 'power', 'http://www.bell.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1755, 1746, 1765.0, 1718, 'Autumn Cain', '1985-08-06', 'chair', 'https://adams.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1756, 1746, 1772.0, 1718, 'Oscar Norris', '1985-08-07', 'still', 'http://riddle.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1757, 1746, 1779.0, 1718, 'Lisa Patterson', '1985-08-08', 'design', 'http://www.dawson.biz/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1762, 1754, 1738, 1734, 1766, 1770, 1774, 'change', 1778, 1782.5, 1786, 'product', 1790, 1794, 1798, 'bag', 'specific', 1750);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1763, 1754, 1738, 1734, 1777.0, 1783.0, 1789.0, 'participant', 1797.0, 1803.5, 1809.0, 'join', 1817.0, 1823.0, 1829.0, 'property', 'better', 1750);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1764, 1754, 1738, 1734, 1788.0, 1796.0, 1804.0, 'project', 1816.0, 1824.5, 1832.0, 'how', 1844.0, 1852.0, 1860.0, 'study', 'interesting', 1750);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1765, 1754, 1738, 1734, 1799.0, 1809.0, 1819.0, 'exist', 1835.0, 1845.5, 1855.0, 'live', 1871.0, 1881.0, 1891.0, 'up', 'myself', 1750);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1803, 1754, 1728, 1734, 1766, 1770, 1774, 'change', 1778, 1782.5, 1786, 'product', 1790, 1794, 1798, 'bag', 'specific', 1750);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.nationality FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapSpeed DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT d.nationality FROM results AS r JOIN drivers AS d ON r.driverId = d.driverId WHERE r.fastestLapSpeed = (SELECT MAX(fastestLapSpeed) FROM results) LIMIT 1;

/*
Prediction Result:
('Italy',)
*/