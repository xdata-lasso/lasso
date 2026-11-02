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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2924, 'with', 'Craig Murphy', '3898 Sharp Mountain
Latoyamouth, PR 25122', 'Falkland Islands (Malvinas)', 2932.5, 2940.5, 2948, 'http://riddle-tran.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2925, 'drive', 'Robert Sutton', '77805 Barbara Crossroad Suite 075
Jeremiahchester, TX 99149', 'Turkmenistan', 2945.5, 2955.5, 2965.0, 'http://www.miranda.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2926, 'billion', 'Michael Bolton', '9090 Eric Isle Suite 636
New Paulfort, CT 43602', 'Niue', 2958.5, 2970.5, 2982.0, 'http://www.johnson-fowler.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2927, 'by', 'Dr. Nancy Gaines MD', '412 Emily Fall Apt. 970
East Chad, MS 37701', 'Mauritania', 2971.5, 2985.5, 2999.0, 'https://ross.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2928, 'away', 'Rodney Logan', '817 Miguel Branch Apt. 566
North David, MT 63186', 'French Guiana', 2984.5, 3000.5, 3016.0, 'http://www.santiago-marshall.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2929, 'here', 'Jared Carpenter', '23467 Cassandra Inlet Apt. 874
North Vickie, NV 08885', 'Papua New Guinea', 2997.5, 3015.5, 3033.0, 'http://www.sandoval.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2930, 'American', 'Kaitlyn Hunt', '597 Ford Canyon
West Debbiemouth, MI 92292', 'United States Virgin Islands', 3010.5, 3030.5, 3050.0, 'https://www.roberson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2931, 'office', 'Brittany Sanders', '9263 Rachel Street Suite 762
South Hollyton, IA 21201', 'Bangladesh', 3023.5, 3045.5, 3067.0, 'http://nichols.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2956, 'bank', 2964, 'help', 'Michael Copeland', 'Cain', '1985-12-31 23:59:59', 'German', 'http://parker.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2957, 'remain', 2971.0, 'could', 'Michael Copeland', 'Cain', '1985-12-31 23:59:59', 'German', 'http://www.kerr-gonzalez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2958, 'source', 2978.0, 'direction', 'Michael Copeland', 'Cain', '1985-12-31 23:59:59', 'German', 'https://www.rogers.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2959, 'activity', 2985.0, 'send', 'Michael Copeland', 'Cain', '1985-12-31 23:59:59', 'German', 'http://www.jackson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2960, 'research', 2992.0, 'already', 'Michael Copeland', 'Cain', '1985-12-31 23:59:59', 'German', 'https://sims.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2961, 'explain', 2999.0, 'walk', 'Michael Copeland', 'Cain', '1985-12-31 23:59:59', 'German', 'https://www.lewis.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2962, 'class', 3006.0, 'Republican', 'Michael Copeland', 'Cain', '1985-12-31 23:59:59', 'German', 'http://www.valdez-smith.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2963, 'let', 3013.0, 'no', 'Michael Copeland', 'Cain', '1985-12-31 23:59:59', 'German', 'https://www.barrett.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2972, 'https://www.mcclure.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2973, 'https://www.herrera.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2974, 'https://www.nguyen.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2975, 'https://www.gill.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2976, 'http://franklin.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2977, 'https://www.matthews.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2978, 'http://rojas.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2979, 'http://www.brooks.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2980, 2972, 2988, 2924, 'Dan Johnson', '1992-03-07', 'serve', 'https://www.kane.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2981, 2973, 2995.0, 2925, 'Linda Bautista', '1992-03-08', 'doctor', 'http://www.martinez.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2982, 2974, 3002.0, 2926, 'Erin Ramirez', '1992-03-09', 'political', 'http://www.miller.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2983, 2975, 3009.0, 2927, 'Paige Meyer', '1992-03-10', 'turn', 'http://obrien.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2984, 2976, 3016.0, 2928, 'Maria Roberts', '1992-03-11', 'I', 'https://www.huffman-olson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2985, 2977, 3023.0, 2929, 'Ryan Rivera', '1992-03-12', 'near', 'https://ruiz.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2986, 2978, 3030.0, 2930, 'Joshua Knox', '1992-03-13', 'fund', 'https://www.smith-james.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2987, 2979, 3037.0, 2931, 'Danielle Mcdaniel', '1992-03-14', 'cover', 'https://www.barber.info/');
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2980, 2956, 2996, 3004, 'federal', 'manager', 3012);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2981, 2957, 2997, 3013.0, 'how', 'deal', 3027.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2982, 2958, 2998, 3022.0, 'or', 'clear', 3042.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2983, 2959, 2999, 3031.0, 'police', 'whom', 3057.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2984, 2960, 3000, 3040.0, 'medical', 'customer', 3072.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2985, 2961, 3001, 3049.0, 'goal', 'above', 3087.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2986, 2962, 3002, 3058.0, 'century', 'add', 3102.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2987, 2963, 3003, 3067.0, 'senior', 'training', 3117.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('Michael Copeland', 'Cain')
*/

-- Prediction Query
SELECT d.forename, d.surname, AVG(ps.duration) AS avg_duration FROM drivers AS d INNER JOIN pitstops AS ps ON d.driverId = ps.driverId WHERE d.dob BETWEEN '1980-01-01' AND '1985-12-31' AND d.nationality = 'German' GROUP BY d.forename, d.surname ORDER BY avg_duration ASC, d.forename NULLS LAST, d.surname NULLS LAST LIMIT 3;

/*
Prediction Result:
*/