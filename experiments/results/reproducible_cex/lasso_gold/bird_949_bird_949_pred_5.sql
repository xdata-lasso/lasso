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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1809, 'development', 'Jacob Santos', '6184 Miles Ford Apt. 461
Cindyberg, MT 14252', 'Uganda', 1813.5, 1817.5, 1821, 'https://www.briggs-white.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1810, 'similar', 'Shawn Scott', '1173 Kimberly Village
West Jade, LA 21521', 'Kazakhstan', 1826.5, 1832.5, 1838.0, 'https://houston-vaughn.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1811, 'age', 'Amber Vang', '75300 Rebecca Village Suite 218
Lake Jenniferview, SD 30799', 'Zimbabwe', 1839.5, 1847.5, 1855.0, 'https://www.anderson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1812, 'mother', 'Martha Smith', '7012 Melissa Lake Suite 611
North Melissaburgh, MA 47362', 'Nigeria', 1852.5, 1862.5, 1872.0, 'http://www.pruitt-webb.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1857, 'per', 'Matthew Blanchard', '69958 Barnes Rest
West Raymond, MA 39058', 'Portugal', 1861.5, 1865.5, 1869, 'http://garcia-parrish.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1858, 'candidate', 'Jonathan Moreno', '69848 Joseph Plaza
East Jason, VT 38587', 'French Polynesia', 1874.5, 1880.5, 1886.0, 'http://butler-french.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1859, 'sport', 'Timothy Roberson', '288 Page Trace
Annashire, OK 87946', 'Costa Rica', 1887.5, 1895.5, 1903.0, 'http://www.king.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1860, 'wait', 'Mr. Thomas Thompson', '0810 Thomas Skyway Apt. 342
Francesberg, MP 08631', 'Sao Tome and Principe', 1900.5, 1910.5, 1920.0, 'http://payne.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1825, 'resource', 'Ian Johnson', 'Germany', 'http://mills.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1827, 'left', 'Sara Mcpherson', 'American Samoa', 'https://rhodes.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1828, 'course', 'Thomas Rodriguez', 'Romania', 'http://www.michael.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1873, 'popular', 'Angel Green', 'Trinidad and Tobago', 'http://www.flores-rivera.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1826, 'financial', 'Victor Moss', 'Armenia', 'http://tyler-pierce.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1874, 'list', 'Andrew Ramirez', 'Vanuatu', 'https://www.meyer.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1875, 'cost', 'Christopher Singleton', 'Gibraltar', 'https://bailey.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1876, 'result', 'John Pineda', 'Nepal', 'https://robinson-goodwin.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1829, 'http://www.schneider.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1830, 'https://gates.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1831, 'http://valdez.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1832, 'http://www.richmond.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1877, 'https://www.caldwell.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1878, 'http://www.blackwell.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1879, 'https://ramsey.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1880, 'https://phillips.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1833, 1829, 1837, 1809, 'Michael Clements', '1981-04-01', 'build', 'http://www.kelly-schultz.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1834, 1829, 1844.0, 1809, 'Anthony Walker', '1981-04-02', 'bill', 'https://www.prince.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1835, 1829, 1851.0, 1809, 'Justin Harvey', '1981-04-03', 'song', 'https://www.carr-lopez.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1836, 1829, 1858.0, 1809, 'Matthew Baldwin', '1981-04-04', 'reason', 'http://love.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1881, 1877, 1885, 1857, 'Bradley Davis', '1985-08-05', 'describe', 'https://www.parks.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1882, 1877, 1892.0, 1857, 'Patricia Ferguson', '1985-08-06', 'note', 'http://www.thompson.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1883, 1877, 1899.0, 1857, 'Christine Soto', '1985-08-07', 'them', 'http://www.russell-hayes.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1884, 1877, 1906.0, 1857, 'Michael Houston', '1985-08-08', 'scientist', 'https://price.net/');
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (1842, 1833, 1825, 1920.5, 1849, 'according', 1853);
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (1843, 1833, 1825, 1854.5, 1860.0, 'with', 1868.0);
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (1844, 1833, 1825, 1863.5, 1871.0, 'property', 1883.0);
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (1889, 1833, 1825, 1872.5, 1882.0, 'remember', 1898.0);
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (1841, 1881, 1826, 1920.5, 1850, 'any', 1854);
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (1890, 1881, 1826, 1902.5, 1908.0, 'service', 1916.0);
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (1891, 1881, 1826, 1911.5, 1919.0, 'present', 1931.0);
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (1892, 1881, 1826, 1845.5, 1930.0, 'at', 1946.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId ORDER BY T1.points DESC, T1.constructorstandingsid NULLS LAST, T2.constructorid NULLS LAST LIMIT 1;

/*
Gold Result:
('Victor Moss',)
*/

-- Prediction Query
SELECT T1.name FROM constructors AS T1 INNER JOIN constructorStandings AS T2 ON T1.constructorId = T2.constructorId ORDER BY T2.points DESC, T1.constructorid NULLS LAST, T2.constructorstandingsid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Ian Johnson',)
*/