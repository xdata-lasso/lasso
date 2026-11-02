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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3063, 'finally', 'Joseph Armstrong', '8333 Karen Shoals
North Ryantown, GA 43296', 'Brunei Darussalam', 3067.5, 3071.5, 3075, 'http://lawrence.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3064, 'policy', 'Kathy Anderson', 'PSC 4347, Box 1287
APO AE 91174', 'Germany', 3080.5, 3086.5, 3092.0, 'https://salinas-peck.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3065, 'day', 'Elizabeth Nunez', '915 Kent Summit
Valdezside, PR 57774', 'Zimbabwe', 3093.5, 3101.5, 3109.0, 'http://www.smith-phelps.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3066, 'seem', 'Shelly Jackson', '1411 Matthew Ramp
Lake Sheri, OK 48701', 'Hong Kong', 3106.5, 3116.5, 3126.0, 'http://porter.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3111, 'member', 'Ariana Brown', '12920 Mcbride Crossing
East Baileyburgh, CO 74228', 'Belize', 3115.5, 3119.5, 3123, 'https://www.harris.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3112, 'quite', 'Rebecca Lopez', '18458 Rodney Shoals
East Kevinhaven, MH 38957', 'Western Sahara', 3128.5, 3134.5, 3140.0, 'https://www.underwood-stewart.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3113, 'leader', 'Alicia Hawkins', '97585 Hailey Shore Apt. 303
West Melissa, IL 18091', 'Equatorial Guinea', 3141.5, 3149.5, 3157.0, 'https://www.wright.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3114, 'fire', 'Robin Freeman', '542 Jones Glens
Patrickburgh, MO 60278', 'Philippines', 3154.5, 3164.5, 3174.0, 'https://www.bowman-cox.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3079, 'plant', 3083, 'time', 'Michael', 'Schumacher', '1990-10-18', 'Macao', 'https://www.carter-levy.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3081, 'child', 3090.0, 'scientist', 'Michael', 'Schumacher', '1990-10-19', 'British Virgin Islands', 'https://www.clark.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3082, 'skin', 3097.0, 'already', 'Michael', 'Schumacher', '1990-10-20', 'Falkland Islands (Malvinas)', 'http://myers.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3128, 'reduce', 3104.0, 'front', 'Michael', 'Schumacher', '1990-10-21', 'Thailand', 'http://henderson-kennedy.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3080, 'star', 3131, 'action', 'Michael', 'Schumacher', '1998-07-03', 'Bosnia and Herzegovina', 'https://rice.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3129, 'explain', 3138.0, 'billion', 'Michael', 'Schumacher', '1998-07-04', 'Uzbekistan', 'https://garcia.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3130, 'success', 3145.0, 'huge', 'Michael', 'Schumacher', '1998-07-05', 'China', 'http://byrd.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3131, 'draw', 3152.0, 'doctor', 'Michael', 'Schumacher', '1998-07-06', 'Saint Lucia', 'https://www.smith-palmer.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3127, 'machine', NULL, NULL, 'Kelsey Fernandez', 'Meyer', NULL, NULL, 'http://cooley.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3087, 'https://rose.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3088, 'https://martin.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3089, 'http://www.brock.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3090, 'https://www.floyd.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (3135, 'http://www.bradley-adams.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3136, 'http://ellis.info/');
INSERT INTO "seasons" ("year", "url") VALUES (3137, 'https://meyer-higgins.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3138, 'https://www.russell-edwards.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3092, 3087, 3095, 3063, 'Angela Allen', '1973-11-07', 'along', 'http://jensen.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3093, 3087, 3102.0, 3063, 'John Landry', '1994-03-23', 'by', 'https://chen-wallace.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3094, 3087, 3109.0, 3063, 'Jose Morgan', '1994-03-24', 'effect', 'http://www.martinez.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3139, 3087, 3116.0, 3063, 'Charles Sharp', '1994-03-25', 'industry', 'http://www.berry.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3091, 3135, 3096, 3111, 'Carol Brown', '1994-03-22', 'work', 'https://carlson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3140, 3135, 3150.0, 3111, 'Kenneth Miller', '1973-11-08', 'side', 'https://gamble.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3141, 3135, 3157.0, 3111, 'Timothy Stokes', '1973-11-09', 'century', 'http://craig.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3142, 3135, 3164.0, 3111, 'Travis Rhodes', '1973-11-10', 'modern', 'http://www.franco-palmer.com/');
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3092, 3079, 3099, 3103, 'study', 3107);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3092, 3081, 3101, 3112.0, 'personal', 3120.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3092, 3082, 3102, 3121.0, 'course', 3133.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3092, 3127, 3147, 3130.0, 'if', 3146.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3091, 3080, 3100, 3151, 'knowledge', 3107);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3091, 3128, 3148, 3160.0, 'hundred', 3168.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3091, 3129, 3149, 3169.0, 'conference', 3181.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3091, 3130, 3150, 3178.0, 'hour', 3194.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.year FROM races AS T1 INNER JOIN lapTimes AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Michael' AND T3.surname = 'Schumacher' ORDER BY T2.milliseconds ASC, T1.raceid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Carol Brown', 3135)
*/

-- Prediction Query
SELECT T3.name, T3.year FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T1.forename = 'Michael' AND T1.surname = 'Schumacher' ORDER BY T2.milliseconds ASC, T1.driverid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Angela Allen', 3087)
*/