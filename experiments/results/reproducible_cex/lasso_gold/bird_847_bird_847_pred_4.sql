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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1944, 'development', 'Kimberly Dean', '016 Alvarado Shoals Suite 104
Hallfurt, NY 93521', 'Poland', 1948.5, 1952.5, 1956, 'http://thornton.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1945, 'Democrat', 'Melissa Barnett MD', '9812 Vincent Mount Apt. 038
Matthewfurt, WA 21079', 'South Georgia and the South Sandwich Islands', 1961.5, 1967.5, 1973.0, 'http://grant.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1946, 'office', 'Kelsey Scott', '4384 Connie Wells Suite 084
East Matthew, MO 86606', 'Cook Islands', 1974.5, 1982.5, 1990.0, 'http://acosta.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1947, 'necessary', 'Curtis Horton', '936 Ashley Meadow Suite 957
East Denise, OR 71457', 'Tokelau', 1987.5, 1997.5, 2007.0, 'https://reese-underwood.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2046, 'bank', 'Katelyn Vargas', '013 Paige Throughway Apt. 227
Petershire, NV 26147', 'Uganda', 2050.5, 2054.5, 2058, 'https://www.hicks-arnold.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2047, 'sister', 'Justin Short', '9465 Brandi Ridge Suite 240
Rachelton, AL 92691', 'Solomon Islands', 2063.5, 2069.5, 2075.0, 'https://lopez.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2048, 'word', 'Tyler Jones', '40369 Garrett Station Suite 666
Lake Glenn, DC 25172', 'Qatar', 2076.5, 2084.5, 2092.0, 'https://www.shaw.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2049, 'seek', 'Robert Wise', '2422 Charles Brook Apt. 762
East Dawnchester, VI 60273', 'Venezuela', 2089.5, 2099.5, 2109.0, 'http://www.webb.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1960, 'civil', 'Alexander Odom', 'Tanzania', 'https://www.henry-taylor.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1961, 'start', 'Lisa Salazar', 'Netherlands', 'http://www.duran-smith.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1962, 'cup', 'Crystal Johnson', 'Latvia', 'https://www.powers.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1963, 'both', 'Richard Anderson', 'Rwanda', 'https://nguyen.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2062, 'change', 'Dr. Peggy Marshall', 'Georgia', 'https://www.gibson-escobar.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2063, 'show', 'Steve Davis', 'New Zealand', 'https://yu-yates.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2064, 'side', 'Patrick Horne', 'Austria', 'http://www.livingston.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2065, 'new', 'Mark Yates', 'United Kingdom', 'https://www.kennedy.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1964, 'stand', 1968, 'thank', 'Todd Armstrong', 'Medina', '1973-06-11', 'Serbia', 'https://wilkerson-ayala.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1965, 'analysis', 1975.0, 'husband', 'Margaret Padilla', 'Terrell', '1973-06-12', 'Norfolk Island', 'https://www.phillips-ellison.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1966, 'political', 1982.0, 'service', 'Brian Bryant', 'Williams', '1973-06-13', 'Australia', 'http://hayes.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1967, 'simple', 1989.0, 'form', 'Sherry Sanchez', 'Hughes', '1973-06-14', 'Comoros', 'http://morris-johnson.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2066, 'table', 2070, 'few', 'Sarah Ramirez', 'Morton', '1989-11-04', 'Marshall Islands', 'http://www.mullins-gutierrez.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2067, 'sing', 2077.0, 'memory', 'Douglas Hodge', 'Green', '1989-11-05', 'Antigua and Barbuda', 'http://walsh.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2068, 'probably', 2084.0, 'beautiful', 'Brian Thompson', 'Haynes', '1989-11-06', 'Guam', 'http://williams.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2069, 'agreement', 2091.0, 'card', 'Brittany Griffin', 'Washington', '1989-11-07', 'Belize', 'https://reese-goodwin.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1972, 'http://wright.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1973, 'http://www.mccarthy.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1974, 'http://moody.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1975, 'https://www.barr.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2074, 'http://thornton.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (2075, 'http://reyes-stewart.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2076, 'http://www.walsh.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2077, 'https://lang-scott.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (19, 1972, 1979, 1944, 'Charles Hammond', '1977-10-15', 'southern', 'https://aguirre.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1976, 1972, 1986.0, 1944, 'Eric Cross', '1977-10-16', 'environment', 'https://ramos-burke.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1977, 1972, 1993.0, 1944, 'Donna White', '1977-10-17', 'actually', 'http://fuller.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1978, 1972, 2000.0, 1944, 'Toni Smith', '1977-10-18', 'low', 'http://www.bailey.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2097, 2074, 2081, 2046, 'Raymond Curry', '1993-04-08', 'its', 'https://hardy.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2078, 2074, 2088.0, 2046, 'Leah Lee', '1993-04-09', 'billion', 'http://www.davis.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2079, 2074, 2095.0, 2046, 'Michael White', '1993-04-10', 'network', 'http://www.gates.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2080, 2074, 2102.0, 2046, 'Megan Decker', '1993-04-11', 'body', 'http://www.lopez.com/');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1983, 19, 1964, 1960, 1987, 1991, 'this', 'wife', 'keep');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1984, 19, 1964, 1960, 1998.0, 2004.0, 'player', 'begin', 'could');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1985, 19, 1964, 1960, 2009.0, 2017.0, 'fire', 'appear', 'color');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1986, 19, 1964, 1960, 2020.0, 2030.0, 'glass', 'boy', 'remember');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2085, 19, 2066, 2062, 2089, 2093, 'purpose', NULL, 'specific');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2086, 19, 2066, 2062, 2100.0, 2106.0, 'long', NULL, 'late');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2087, 19, 2066, 2062, 2111.0, 2119.0, 'win', NULL, 'well');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2088, 19, 2066, 2062, 2122.0, 2132.0, 'factor', NULL, 'region');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 19 AND NOT T1.q2 IS NULL ORDER BY T1.q2 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Medina',)
*/

-- Prediction Query
SELECT T1.surname FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 19 ORDER BY T2.q2, T1.driverid NULLS LAST, T2.qualifyid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Morton',)
*/