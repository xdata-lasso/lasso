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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2138, 'budget', 'Christopher Hill', '950 Michael Drives
East Tonymouth, OH 84996', 'Cape Verde', 2142.5, 2146.5, 2150, 'https://davis.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2139, 'eat', 'Richard Smith', '306 Ramsey Glen Apt. 778
Amyfort, ID 74779', 'New Zealand', 2155.5, 2161.5, 2167.0, 'http://www.russo.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2140, 'property', 'Richard Alvarez', '7498 Casey Drives Suite 448
Shawnhaven, MS 96662', 'Finland', 2168.5, 2176.5, 2184.0, 'https://www.johnson.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2141, 'leader', 'Jacqueline Davis', '593 Le Shoals
Leefort, WI 72782', 'Gibraltar', 2181.5, 2191.5, 2201.0, 'https://diaz.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2190, 'small', 'Madison Chen', 'Unit 9981 Box 3646
DPO AE 17827', 'Saint Lucia', 2194.5, 2198.5, 2202, 'http://www.mcintosh.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2191, 'read', 'Joseph Flores', '086 Miller Parkway Suite 227
South Randall, OK 26204', 'Timor-Leste', 2207.5, 2213.5, 2219.0, 'https://www.cole-johnson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2192, 'time', 'Erin Wolfe', '14659 Daniel Loop
Diazborough, MD 45658', 'Belize', 2220.5, 2228.5, 2236.0, 'http://www.mills.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2193, 'play', 'Michael Osborn', '2597 Scott Viaduct
East Gina, FL 99818', 'Bouvet Island (Bouvetoya)', 2233.5, 2243.5, 2253.0, 'http://escobar.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2154, 'add', 2158, 'reality', 'Julie Fowler', 'Davenport', '1996-07-11', 'Bolivia', 'http://www.sandoval.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2156, 'wonder', 2165.0, 'million', 'Patrick Zamora', 'Miller', '1996-07-12', 'Saint Kitts and Nevis', 'https://www.ray.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2157, 'will', 2172.0, 'without', 'Rebecca Brown', 'Lewis', '1996-07-13', 'Martinique', 'http://www.pierce.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2206, 'detail', 2179.0, 'voice', 'Kendra Navarro', 'Stone', '1996-07-14', 'Hungary', 'http://orr-pierce.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2155, 'federal', 2210, 'prepare', 'Alejandra Price', 'Bray', '1975-04-19', 'Colombia', 'http://www.nielsen.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2207, 'deep', 2217.0, 'experience', 'Samuel Keller', 'Garcia', '1975-04-20', 'Congo', 'https://moore.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2208, 'strategy', 2224.0, 'argue', 'Alicia Dillon', 'Delacruz', '1975-04-21', 'Macao', 'http://garrett.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2209, 'same', 2231.0, 'make', 'Crystal James', 'Schmidt', '1975-04-22', 'Kuwait', 'https://www.peterson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2162, 'https://jordan.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2163, 'http://howe.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2164, 'https://www.johnson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2165, 'https://www.joyce-lewis.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2214, 'http://yu.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2215, 'https://www.delgado.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2216, 'http://www.barker-roach.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2217, 'https://www.fitzpatrick.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2167, 2162, 2170, 2138, 'Michelle White', '1971-11-15', 'pass', 'http://www.lopez.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2168, 2162, 2177.0, 2138, 'Juan Hawkins', '1971-11-16', 'enjoy', 'https://www.petersen-norris.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2169, 2162, 2184.0, 2138, 'Brittney Johnson', '1971-11-17', 'early', 'http://cross.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2218, 2162, 2191.0, 2138, 'Charles Richardson', '1971-11-18', 'talk', 'http://www.bailey-montoya.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2166, 2214, 2171, 2190, 'Rodney Norris', '1979-08-23', 'worker', 'https://www.ross.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2219, 2214, 2229.0, 2190, 'Brianna Johnson', '1979-08-24', 'eye', 'https://www.hall.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2220, 2214, 2236.0, 2190, 'William Ali', '1979-08-25', 'civil', 'http://banks.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2221, 2214, 2243.0, 2190, 'Patrick Underwood', '1979-08-26', 'start', 'http://www.perez.com/');
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2174, 2167, 2154, 2257.5, 2182, 'camera', 2186);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2176, 2167, 2154, 2187.5, 2193.0, 'true', 2201.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2177, 2167, 2154, 2196.5, 2204.0, 'speech', 2216.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2226, 2167, 2154, 2205.5, 2215.0, 'dream', 2231.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2175, 2166, 2155, 2257.5, 2234, 'wish', 2238);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2227, 2166, 2155, 2239.5, 2245.0, 'expect', 2253.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2228, 2166, 2155, 2248.5, 2256.0, 'doctor', 2268.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2229, 2166, 2155, 2178.5, 2267.0, 'situation', 2283.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Alejandra Price', 'Bray', 2257.5)
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname", "driverStandings"."points" FROM "driverStandings" INNER JOIN "drivers" ON "driverStandings"."driverId" = "drivers"."driverId" ORDER BY "driverStandings"."points" DESC, driverStandings.driverstandingsid NULLS LAST, drivers.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Julie Fowler', 'Davenport', 2257.5)
*/