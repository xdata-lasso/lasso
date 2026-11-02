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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2199, 'much', 'Bryan Burns', '911 Sparks Flats Suite 778
Amyside, ND 02817', 'Taiwan', 2203.5, 2207.5, 2211, 'https://patterson.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2200, 'family', 'Tommy Johnson', 'USS Ewing
FPO AE 50784', 'Sudan', 2216.5, 2222.5, 2228.0, 'https://www.sanchez.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2201, 'choice', 'Sandra Jimenez', '7002 Dyer Expressway Suite 624
Freemanville, OK 88977', 'Saint Vincent and the Grenadines', 2229.5, 2237.5, 2245.0, 'http://morgan.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2202, 'special', 'Christopher Jacobs', '8280 Baker Ramp Suite 954
Bryanshire, AZ 17304', 'Niue', 2242.5, 2252.5, 2262.0, 'https://www.barrett-henderson.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2238, 'those', 'Kenneth Mason', '363 Daniel Forest Suite 764
South Amandaville, MD 72032', 'Puerto Rico', 2242.5, 2246.5, 2250, 'https://www.morales.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2239, 'shake', 'Matthew Carpenter', '2575 Smith Rest
Port Joditon, UT 88528', 'Antarctica (the territory South of 60 deg S)', 2255.5, 2261.5, 2267.0, 'https://www.moore.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2240, 'thousand', 'Kelly Crawford', '5183 Price Lock Suite 413
Jasonburgh, PW 58021', 'Norway', 2268.5, 2276.5, 2284.0, 'https://mendoza-moss.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2241, 'challenge', 'Kyle Mejia', '41776 Love Wells Apt. 248
West Robertside, WA 43331', 'Norfolk Island', 2281.5, 2291.5, 2301.0, 'http://gonzalez-perry.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2215, 'week', 'Leah Odom', 'Guadeloupe', 'https://crawford.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2217, 'know', 'James Armstrong', 'Chad', 'http://williams-davies.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2218, 'example', 'Ariel Leonard', 'Nicaragua', 'http://www.richard.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2254, 'again', 'Jonathan Hubbard', 'French Southern Territories', 'https://reed.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2216, 'under', 'Travis Leblanc', 'Eritrea', 'http://www.higgins.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2255, 'huge', 'Lori Meadows', 'Canada', 'https://www.reeves.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2256, 'you', 'Christina Haynes', 'Benin', 'https://anderson-gates.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2257, 'own', 'James Patterson', 'Heard Island and McDonald Islands', 'http://byrd.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2219, 'https://fernandez.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2220, 'https://www.burton.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2221, 'https://www.hayden.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2222, 'https://www.gonzalez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2258, 'http://young-hayes.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2259, 'https://smith.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2260, 'https://www.reyes.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2261, 'http://www.cook.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 2219, 2226, 2199, 'Jennifer Dalton', '1978-04-10', 'citizen', 'https://castro-graham.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2223, 2219, 2233.0, 2199, 'Madison Singleton', '1978-04-11', 'dark', 'http://www.taylor-green.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2224, 2219, 2240.0, 2199, 'Dustin Martin', '1978-04-12', 'ahead', 'http://www.tucker.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2225, 2219, 2247.0, 2199, 'Cynthia Allen', '1978-04-13', 'else', 'https://lester.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2262, 2258, 2272.0, 2238, 'Linda Goodman', '1982-08-15', 'partner', 'https://www.wilson-williams.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2263, 2258, 2279.0, 2238, 'David Harvey', '1982-08-16', 'ever', 'https://ward.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2264, 2258, 2286.0, 2238, 'James Wood', '1982-08-17', 'condition', 'https://stafford-stewart.info/');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2231, 9, 2215, 2300.5, 'city');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2232, 9, 2215, 2243.5, 'believe');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2233, 9, 2215, 2252.5, 'industry');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2269, 9, 2215, 2261.5, 'yes');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2230, 9, 2216, 2300.5, 'remain');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2270, 9, 2216, 2282.5, 'only');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2271, 9, 2216, 2291.5, 'tonight');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2272, 9, 2216, 2234.5, 'wind');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.url FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T2.constructorId = T1.constructorId WHERE T1.raceId = 9 ORDER BY T1.points DESC, T1.constructorresultsid NULLS LAST, T2.constructorid NULLS LAST LIMIT 1;

/*
Gold Result:
('http://www.higgins.info/',)
*/

-- Prediction Query
SELECT T1.url FROM constructors AS T1 INNER JOIN constructorResults AS T2 ON T1.constructorId = T2.constructorId WHERE T2.raceId = 9 ORDER BY T2.points DESC, T1.constructorid NULLS LAST, T2.constructorresultsid NULLS LAST LIMIT 1;

/*
Prediction Result:
('https://crawford.net/',)
*/