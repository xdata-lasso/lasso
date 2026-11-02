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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2356, 'military', 'Marina Bay Street Circuit', '8730 Eric Hills Suite 146
South Rebecca, SD 32580', 'American Samoa', 2360.5, 2364.5, 2368, 'https://peterson-bartlett.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2357, 'and', 'Marina Bay Street Circuit', '1959 Cunningham Ways Suite 715
Port Jordanshire, AR 19655', 'Burundi', 2373.5, 2379.5, 2385.0, 'http://www.walker.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2358, 'test', 'Marina Bay Street Circuit', '2045 Fields Knolls
West Kellyland, NY 25904', 'Maldives', 2386.5, 2394.5, 2402.0, 'http://moon-wilson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2359, 'the', 'Marina Bay Street Circuit', '92855 Nelson Square
Codyshire, MI 19338', 'Finland', 2399.5, 2409.5, 2419.0, 'http://collins-cox.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2458, 'write', 'Marina Bay Street Circuit', '90034 Parker Squares Suite 183
Pricefurt, PW 33994', 'Korea', 2462.5, 2466.5, 2470, 'http://mcdaniel.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2459, 'check', 'Marina Bay Street Circuit', '3275 Mccormick Harbor
Port Kimberlyfort, NJ 97093', 'Lesotho', 2475.5, 2481.5, 2487.0, 'http://www.richardson-long.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2460, 'him', 'Marina Bay Street Circuit', '612 Hunter Knoll Suite 985
Nealton, SD 84595', 'Tunisia', 2488.5, 2496.5, 2504.0, 'http://www.leblanc.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2461, 'senior', 'Marina Bay Street Circuit', '206 Courtney Island Apt. 123
Port Brooke, MT 42365', 'Saint Pierre and Miquelon', 2501.5, 2511.5, 2521.0, 'http://www.gonzalez-haynes.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2372, 'voice', 'Carrie Torres', 'Serbia', 'http://williams-rodriguez.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2373, 'picture', 'Barbara Anderson', 'Slovenia', 'http://kerr.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2374, 'necessary', 'Melissa Parker', 'Bouvet Island (Bouvetoya)', 'https://www.patton.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2375, 'source', 'William Coleman', 'Belarus', 'http://www.bell.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2474, 'appear', 'Brittany Rubio', 'Costa Rica', 'https://snyder.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2475, 'institution', 'Keith Smith', 'Comoros', 'http://byrd.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2476, 'prepare', 'Patricia Hebert', 'Yemen', 'http://young-hayes.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2477, 'laugh', 'Kathleen Walker', 'Tokelau', 'https://smith.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2376, 'particularly', 2380, 'top', 'Kathy Jones', 'Glass', '1978-03-05', 'Qatar', 'http://www.zavala-coleman.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2377, 'happen', 2387.0, 'month', 'Pamela Rice', 'Knapp', '1978-03-06', 'Namibia', 'http://juarez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2378, 'he', 2394.0, 'statement', 'Tracey Jackson', 'York', '1978-03-07', 'Colombia', 'https://www.taylor.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2379, 'college', 2401.0, 'shoulder', 'April Swanson', 'Wells', '1978-03-08', 'Kazakhstan', 'http://www.snyder-cruz.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2478, 'room', 2482, 'sell', 'Angel Hawkins', 'Smith', '1994-08-21', 'Paraguay', 'http://www.jackson-vasquez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2479, 'information', 2489.0, 'identify', 'Timothy Ruiz', 'Wagner', '1994-08-22', 'Heard Island and McDonald Islands', 'https://www.stewart.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2480, 'right', 2496.0, 'section', 'Larry Lambert', 'James', '1994-08-23', 'Bulgaria', 'http://edwards.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2481, 'difference', 2503.0, 'simply', 'Michelle Pacheco', 'Madden', '1994-08-24', 'Uganda', 'https://campbell-mcdowell.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2008, 'https://spencer.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (2384, 'http://www.crosby-richardson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2385, 'https://www.kim-barrett.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2386, 'http://www.morales-garza.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2509, 'https://stafford-stewart.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2486, 'http://lopez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2487, 'http://www.green-mccarthy.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (2488, 'http://alexander.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2387, 2008, 2391, 2356, 'Marina Bay Street Circuit', '1982-07-09', 'site', 'http://morgan.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2388, 2008, 2398.0, 2356, 'Marina Bay Street Circuit', '1982-07-10', 'wish', 'http://www.hardy-ramirez.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2389, 2008, 2405.0, 2356, 'Marina Bay Street Circuit', '1982-07-11', 'wait', 'https://alvarez-morrison.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2390, 2008, 2412.0, 2356, 'Marina Bay Street Circuit', '1982-07-12', 'concern', 'https://tate.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2489, 2008, 2493, 2458, 'Marina Bay Street Circuit', '1998-01-02', 'memory', 'http://www.davis-oneill.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2490, 2008, 2500.0, 2458, 'Marina Bay Street Circuit', '1998-01-03', 'lot', 'http://macdonald.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2491, 2008, 2507.0, 2458, 'Marina Bay Street Circuit', '1998-01-04', 'mind', 'http://sanchez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2492, 2008, 2514.0, 2458, 'Marina Bay Street Circuit', '1998-01-05', 'budget', 'https://www.maldonado-becker.biz/');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2395, 2387, 2376, 2372, 2399, 2403, 'enough', 'production', '12:34.56');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2396, 2387, 2376, 2372, 2410.0, 2416.0, 'might', 'yes', '12:34.56');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2397, 2387, 2376, 2372, 2421.0, 2429.0, 'modern', 'center', '12:34.56');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2398, 2387, 2376, 2372, 2432.0, 2442.0, 'during', 'all', '12:34.56');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2497, 2489, 2478, 2474, 2501, 2505, 'hour', 'third', NULL);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2498, 2489, 2478, 2474, 2512.0, 2518.0, 'performance', 'game', NULL);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2499, 2489, 2478, 2474, 2523.0, 2531.0, 'woman', 'class', NULL);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2500, 2489, 2478, 2474, 2534.0, 2544.0, 'born', 'air', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('Kathy Jones', 'Glass')
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname" FROM "qualifying" INNER JOIN "races" ON "qualifying"."raceid" = "races"."raceid" INNER JOIN "circuits" ON "races"."circuitid" = "circuits"."circuitid" INNER JOIN "drivers" ON "qualifying"."driverid" = "drivers"."driverid" WHERE "races"."year" = 2008 AND "circuits"."name" = 'Marina Bay Street Circuit' ORDER BY "qualifying"."q3", qualifying.qualifyid NULLS LAST, races.raceid NULLS LAST, circuits.circuitid NULLS LAST, drivers.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Angel Hawkins', 'Smith')
*/