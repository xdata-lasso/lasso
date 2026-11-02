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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3125, 'us', 'Carol Jackson', '2065 Paul Mount Apt. 149
Bradleyborough, MT 40023', 'Mali', 3129.5, 3133.5, 3137, 'https://www.bradford.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3126, 'big', 'Brian Murphy', '89241 Jarvis Square Suite 252
Tiffanyfort, CA 44423', 'Somalia', 3142.5, 3148.5, 3154.0, 'http://www.brown.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3127, 'subject', 'Chelsey Clark', '8389 Jesse Ridges Apt. 436
New Christopher, DC 49590', 'Israel', 3155.5, 3163.5, 3171.0, 'https://ramos.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3128, 'thing', 'Teresa Martinez', '63039 Stevenson Isle
West Lonnie, WY 05692', 'Oman', 3168.5, 3178.5, 3188.0, 'https://www.williams.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3177, 'where', 'Dawn Turner', '43640 Lisa Alley Apt. 168
Penachester, GA 23622', 'Saudi Arabia', 3181.5, 3185.5, 3189, 'https://everett.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3178, 'under', 'Mary Reyes', '72817 Jacob Circle
Port Katherine, KS 54082', 'Guadeloupe', 3194.5, 3200.5, 3206.0, 'https://www.marks-drake.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3179, 'land', 'Jason Walter', '214 Nicholas Harbor
West Anthonybury, NJ 64096', 'Netherlands', 3207.5, 3215.5, 3223.0, 'https://houston.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3180, 'company', 'Ann Fields', '04090 Jason Turnpike
South Carrieview, NM 62528', 'Heard Island and McDonald Islands', 3220.5, 3230.5, 3240.0, 'https://www.hayes-parks.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3141, 'car', 3145, 'often', 'Lewis', 'Hamilton', '1974-05-02', 'Costa Rica', 'https://griffith.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3143, 'benefit', 3152.0, 'theory', 'Lewis', 'Hamilton', '1974-05-03', 'Dominica', 'http://www.mitchell-west.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3144, 'consumer', 3159.0, 'stuff', 'Lewis', 'Hamilton', '1974-05-04', 'Belgium', 'https://tapia.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3193, 'person', 3166.0, 'work', 'Lewis', 'Hamilton', '1974-05-05', 'Japan', 'https://www.alexander-wagner.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3142, 'myself', 3197, 'about', 'Lewis', 'Hamilton', '1982-02-10', 'Gibraltar', 'https://lawson.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3194, 'job', 3204.0, 'pull', 'Lewis', 'Hamilton', '1982-02-11', 'Guyana', 'http://crosby-david.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3195, 'recent', 3211.0, 'year', 'Lewis', 'Hamilton', '1982-02-12', 'Tunisia', 'http://lawson-joseph.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3196, 'cup', 3218.0, 'tax', 'Lewis', 'Hamilton', '1982-02-13', 'Aruba', 'http://www.robles-turner.net/');
INSERT INTO "seasons" ("year", "url") VALUES (3149, 'http://gill.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3150, 'https://www.barber.info/');
INSERT INTO "seasons" ("year", "url") VALUES (3151, 'https://obrien.info/');
INSERT INTO "seasons" ("year", "url") VALUES (3152, 'https://bentley-waller.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3202, 'http://www.jackson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3203, 'http://johnson.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (3204, 'https://www.scott.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3154, 3149, 3157, 3125, 'Eric Archer', '1978-09-06', 'share', 'https://brown.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3155, 3149, 3164.0, 3125, 'Stephen Riddle', '1978-09-07', 'seven', 'http://dorsey.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3156, 3149, 3171.0, 3125, 'Timothy Martin', '1978-09-08', 'happen', 'http://gibson.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3205, 3149, 3178.0, 3125, 'Tina Wise', '1978-09-09', 'Mr', 'http://www.wise.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3153, 3149, 3158, 3177, 'Tammy Schultz', '1986-06-14', 'society', 'https://www.green.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3206, 3149, 3216.0, 3177, 'Robert Cook II', '1986-06-15', 'I', 'http://www.yang-pineda.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3207, 3149, 3223.0, 3177, 'Tammy Brown', '1986-06-16', 'ready', 'https://www.finley-ray.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3208, 3149, 3230.0, 3177, 'Thomas Paul', '1986-06-17', 'quality', 'https://www.nichols.com/');
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3161, 3154, 3141, 3165.5, 3169, 'seat', 3173);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3163, 3154, 3141, 3174.5, 3180.0, 'wear', 3188.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3164, 3154, 3141, 3183.5, 3191.0, 'be', 3203.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3213, 3154, 3141, 3192.5, 3202.0, 'national', 3218.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3162, 3153, 3142, 3217.5, 3221, 'spend', 3225);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3214, 3153, 3142, 3226.5, 3232.0, 'his', 3240.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3215, 3153, 3142, 3235.5, 3243.0, 'respond', 3255.0);
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3216, 3153, 3142, 3244.5, 3254.0, 'world', 3270.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.year ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Tammy Schultz', 3217.5)
*/

-- Prediction Query
SELECT r.name AS race_name, ds.points AS points FROM drivers AS d INNER JOIN driverStandings AS ds ON d.driverId = ds.driverId INNER JOIN races AS r ON ds.raceId = r.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' ORDER BY r.year ASC, d.driverid NULLS LAST, ds.driverstandingsid NULLS LAST, r.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Eric Archer', 3165.5)
*/