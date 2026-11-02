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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1882, 'child', 'Amanda Juarez', '84498 Nicholas Lane Suite 918
Nicholasbury, NC 53695', 'Northern Mariana Islands', 1886.5, 1890.5, 1894, 'https://www.cole.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1883, 'simply', 'Dennis Young', '7908 Scott Forks Apt. 843
East Eric, PA 94519', 'Andorra', 1899.5, 1905.5, 1911.0, 'http://www.burke-norton.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1884, 'sign', 'Kelly Moody', '5177 Clark Estates
Johnsonton, DC 75669', 'Turkey', 1912.5, 1920.5, 1928.0, 'https://www.jennings.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1885, 'member', 'Thomas Keith', '809 Brian Green
New Susan, PA 74373', 'Saint Helena', 1925.5, 1935.5, 1945.0, 'http://anderson-smith.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1929, 'place', 'Christopher Johnson', '489 Bailey Via
Jeremyborough, NH 53448', 'Dominican Republic', 1933.5, 1937.5, 1941, 'http://www.huff.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1930, 'Mrs', 'Aaron Moore', '68181 Morgan Crescent Suite 894
Churchshire, NJ 32387', 'Tunisia', 1946.5, 1952.5, 1958.0, 'http://www.lowe.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1931, 'name', 'Penny Gomez MD', '790 Wilson Cliff Suite 335
Moseshaven, ND 01775', 'Estonia', 1959.5, 1967.5, 1975.0, 'http://www.watson-stewart.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1932, 'say', 'Kelly Mclaughlin', '41651 Thomas Knoll Apt. 942
South Jillian, IA 96895', 'Costa Rica', 1972.5, 1982.5, 1992.0, 'https://joyce.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1898, 'trade', 1902, 'kind', 'John Mendez', 'Hampton', '1976-09-14', 'Aruba', 'http://bell-ballard.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1899, 'where', 1909.0, 'the', 'Richard Gordon', 'Banks', '1976-09-15', 'Qatar', 'http://scott.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1900, 'mother', 1916.0, 'citizen', 'John Anderson', 'Boyd', '1976-09-16', 'Marshall Islands', 'https://lopez-fletcher.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1901, 'return', 1923.0, 'police', 'Samantha Prince', 'Wood', '1976-09-17', 'Japan', 'http://www.pena-watts.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1945, 'information', 1949, 'career', 'Todd Johnson', 'Gray', '1984-06-22', 'Colombia', 'https://white-coleman.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1946, 'doctor', 1956.0, 'arm', 'Scott Parsons', 'Garcia', '1984-06-23', 'Mexico', 'https://ramirez-white.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1947, 'social', 1963.0, 'never', 'Bryan Holmes', 'Ward', '1984-06-24', 'Dominica', 'http://www.nelson.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1948, 'part', 1970.0, 'successful', 'Adam Craig', 'Hensley', '1984-06-25', 'Ethiopia', 'http://www.hernandez.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1906, 'https://moore.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1907, 'https://henderson.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1908, 'http://bowers.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1909, 'https://lane-schroeder.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1953, 'http://evans-hart.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1954, 'http://vaughn.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1955, 'https://davis.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1956, 'https://jenkins.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1910, 1906, 1961, 1882, 'Sarah Hopkins', '1988-10-03', 'seat', 'http://www.ruiz.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1911, 1906, 1921.0, 1882, 'Jillian Lyons', '1980-02-19', 'area', 'http://www.walker-miller.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1912, 1906, 1928.0, 1882, 'Daniel Morales', '1980-02-20', 'college', 'https://douglas.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1913, 1906, 1935.0, 1882, 'Joshua Terry', '1980-02-21', 'improve', 'http://smith-jefferson.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1957, 1953, 1914, 1929, 'Kenneth Banks', '1980-02-18', 'program', 'https://salazar.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1958, 1953, 1968.0, 1929, 'Richard Kelly', '1988-10-04', 'check', 'http://edwards.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1959, 1953, 1975.0, 1929, 'Katherine Doyle', '1988-10-05', 'trouble', 'https://barron-norman.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1960, 1953, 1982.0, 1929, 'Jane Mitchell', '1988-10-06', 'computer', 'https://white.com/');
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1910, 1898, 1, 1968, 'six', 1972);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1910, 1899, 1918, 1930.0, 'yeah', 1938.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1910, 1900, 1919, 1939.0, 'yeah', 1951.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1910, 1901, 1920, 1948.0, 'yeah', 1964.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1957, 1945, 1, 1921, 'six', 1925);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1957, 1946, 1965, 1977.0, 'yeah', 1985.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1957, 1947, 1966, 1986.0, 'yeah', 1998.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1957, 1948, 1967, 1995.0, 'yeah', 2011.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.milliseconds FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T1.lap = 1 ORDER BY T1.time, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
(1972,)
*/

-- Prediction Query
SELECT T1.name, MIN(T2.milliseconds) FROM races AS T1 INNER JOIN lapTimes AS T2 ON T1.raceId = T2.raceId WHERE T2.lap = 1 GROUP BY T1.name ORDER BY MIN(T2.milliseconds), T1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Kenneth Banks', 1925)
*/