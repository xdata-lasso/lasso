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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1962, 'name', 'Andrew Allen', '489 Bailey Via
Jeremyborough, NH 53448', 'Dominican Republic', 1966.5, 1970.5, 1974, 'http://maxwell.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1963, 'say', 'Christopher Shea', '68181 Morgan Crescent Suite 894
Churchshire, NJ 32387', 'Estonia', 1979.5, 1985.5, 1991.0, 'https://www.rubio.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1964, 'each', 'Heather Foster', '790 Wilson Cliff Suite 335
Moseshaven, ND 01775', 'Denmark', 1992.5, 2000.5, 2008.0, 'https://white-duran.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1965, 'possible', 'Kelly Mclaughlin', '41651 Thomas Knoll Apt. 942
South Jillian, IA 96895', 'Cook Islands', 2005.5, 2015.5, 2025.0, 'https://christensen.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2010, 'six', 'Brian Brown', '34722 Anthony Shore Suite 577
Amyberg, UT 71186', 'Niue', 2014.5, 2018.5, 2022, 'https://paul.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2011, 'so', 'Kimberly Johnson', '968 Stout Orchard Apt. 174
Robertberg, ME 01884', 'Maldives', 2027.5, 2033.5, 2039.0, 'http://www.rodriguez-gibson.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2012, 'base', 'Phillip Miller', '4780 Arroyo Neck
Albertchester, AS 38894', 'Serbia', 2040.5, 2048.5, 2056.0, 'https://flores.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2013, 'develop', 'Christopher Pena', '536 Foster Estates
Claytonbury, KS 10883', 'South Georgia and the South Sandwich Islands', 2053.5, 2063.5, 2073.0, 'http://www.campbell.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3355, 'end', 'Robert White', NULL, NULL, NULL, NULL, NULL, 'http://www.love.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3358, 'floor', 'Darren Willis', NULL, NULL, NULL, NULL, NULL, 'https://herrera.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3361, 'black', 'Cindy Freeman', NULL, NULL, NULL, NULL, NULL, 'http://cortez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1978, 'never', 1982, 'yard', 'Scott Parsons', 'Hensley', '1984-06-22', 'Guam', 'http://goodwin.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1979, 'successful', 1989.0, 'now', 'Bryan Holmes', 'Lopez', '1984-06-23', 'Haiti', 'http://www.parks.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1980, 'land', 1996.0, 'alone', 'Adam Craig', 'Adams', '1984-06-24', 'Luxembourg', 'https://thomas.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1981, 'mean', 2003.0, 'morning', 'Brian Ward', 'Mullen', '1984-06-25', 'Jamaica', 'https://www.fisher.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2027, 'across', 2037.0, 'minute', 'Rick Rivera', 'Skinner', '1992-03-08', 'Rwanda', 'http://maldonado-collins.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2028, 'early', 2044.0, 'guess', 'Tiffany Brown', 'Roth', '1992-03-09', 'Hungary', 'http://www.pineda.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2029, 'city', 2051.0, 'kitchen', 'Andrea Harrison', 'Clayton', '1992-03-10', 'Sierra Leone', 'http://boyer.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2026, 'down', NULL, NULL, 'Danny Ramirez', 'Strickland', NULL, NULL, 'http://www.porter-hudson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1986, 'https://king-garrison.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1987, 'https://www.martin.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1988, 'https://ward-castro.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1989, 'https://www.martinez-dillon.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2034, 'http://smith-bauer.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2035, 'http://smith.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2036, 'https://www.townsend-wright.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2037, 'http://brown.net/');
INSERT INTO "seasons" ("year", "url") VALUES (3353, 'https://www.tran-nichols.net/');
INSERT INTO "seasons" ("year", "url") VALUES (3356, 'https://www.lee.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3359, 'http://www.wilson-miller.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2038, 1986, 1994, 1962, 'Kenneth Banks', '1988-10-03', 'program', 'https://salazar.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1991, 1986, 2001.0, 1962, 'Richard Kelly', '1988-10-04', 'check', 'http://edwards.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1992, 1986, 2008.0, 1962, 'Katherine Doyle', '1988-10-05', 'trouble', 'https://barron-norman.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1993, 1986, 2015.0, 1962, 'Jane Mitchell', '1988-10-06', 'computer', 'https://white.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1990, 2034, 2042, 2010, 'Beth Hall', '1996-07-11', 'memory', 'https://www.lopez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2039, 2034, 2049.0, 2010, 'Dr. Nicole Trujillo', '1996-07-12', 'left', 'http://www.moore.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2040, 2034, 2056.0, 2010, 'Corey Norris', '1996-07-13', 'operation', 'https://www.hunter.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2041, 2034, 2063.0, 2010, 'Chad Roach', '1996-07-14', 'financial', 'https://www.le-barrett.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2042, 3353, 3354, 3355, 'Sarah Logan', '1979-02-19', NULL, NULL);
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2043, 3356, 3357, 3358, 'Crystal Harris', '1980-03-20', NULL, NULL);
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2044, 3359, 3360, 3361, 'Jennifer Garcia', '1981-04-21', NULL, NULL);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2038, 1978, 1998, 2002, 'yeah', 2006);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2039, 1980, 2000, 2011.0, 'easy', 2019.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2040, 1981, 2001, 2020.0, 'enter', 2032.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2041, 2026, 2046, 2029.0, 'customer', 2045.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1990, 1979, 1999, 2003, 'yeah', 2007);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2042, 2027, 2047, 2059.0, 'impact', 2067.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2043, 2028, 2048, 2068.0, 'customer', 2080.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2044, 2029, 2049, 2077.0, 'need', 2093.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.year FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId ORDER BY T1.time DESC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
(2034,)
*/

-- Prediction Query
SELECT r.year FROM circuits AS c JOIN races AS r ON c.circuitId = r.circuitId JOIN laptimes AS l ON r.raceId = l.raceId ORDER BY l.time DESC, c.circuitid NULLS LAST, r.raceid NULLS LAST, l.raceid NULLS LAST, l.driverid NULLS LAST, l.lap NULLS LAST LIMIT 1;

/*
Prediction Result:
(1986,)
*/