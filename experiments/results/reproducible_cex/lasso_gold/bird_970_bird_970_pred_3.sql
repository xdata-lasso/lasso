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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1001, 'purpose', 'Noah Rhodes', '2351 Noah Knolls Suite 940
Herrerafurt, CO 72858', 'Cape Verde', 1007.5, 1013.5, 1019, 'http://smith-hickman.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1002, 'brother', 'Angie Henderson', '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'Holy See (Vatican City State)', 1020.5, 1028.5, 1036.0, 'http://www.humphrey.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1003, 'ago', 'Daniel Wagner', '192 Frank Light Suite 835
East Lydiamouth, MO 35594', 'Serbia', 1033.5, 1043.5, 1053.0, 'https://www.cannon.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1004, 'site', 'Cristian Santos', '76724 John Points Suite 969
Coxberg, NY 65187', 'Central African Republic', 1046.5, 1058.5, 1070.0, 'http://brennan.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1005, 'face', 'Connie Lawrence', '22691 James Mountain
Tashatown, TX 94967', 'Mauritius', 1059.5, 1073.5, 1087.0, 'http://carney-santos.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1006, 'election', 'Abigail Shaffer', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'Zimbabwe', 1072.5, 1088.5, 1104.0, 'https://www.walker.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1025, 'per', 1031, 'second', 'Gary Palmer', 'Valdez', '1985-07-01', 'German', 'http://www.west.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1026, 'once', 1038.0, 'program', 'John Ryan', 'Lucas', '1985-07-02', 'German', 'http://garcia.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1027, 'drug', 1045.0, 'artist', 'Sonya Johnston', 'Brown', '1985-07-03', 'German', 'http://www.russell.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1028, 'discussion', 1052.0, 'drop', 'John Russell', 'Chandler', '1985-07-04', 'German', 'https://www.gray.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1029, 'account', 1059.0, 'author', 'Matthew Gomez', 'Mcbride', '1985-07-05', 'German', 'https://horton-cross.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1030, 'avoid', 1066.0, 'western', 'Scott Brown', 'Rodriguez', '1985-07-06', 'German', 'https://www.phillips.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1037, 'http://williams.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1038, 'http://www.miller.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1039, 'https://www.sanchez.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1040, 'https://santiago.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1041, 'https://powers.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1042, 'https://www.ellis.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1043, 1037, 1049, 1001, 'Daniel Baker', '1970-01-01', 'center', 'http://jacobs-robbins.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1044, 1038, 1056.0, 1002, 'Shirley Suarez', '1970-01-02', 'everything', 'https://whitehead-mathis.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1045, 1039, 1063.0, 1003, 'Christopher Bass', '1970-01-03', 'business', 'https://smith.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1046, 1040, 1070.0, 1004, 'Lisa Archer', '1970-01-04', 'voice', 'http://thornton.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1047, 1041, 1077.0, 1005, 'Aimee Montoya', '1970-01-05', 'both', 'http://tran.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1048, 1042, 1084.0, 1006, 'Matthew Mcmillan', '1970-01-06', 'situation', 'http://fleming.com/');
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1043, 1025, 1055, 1061, 'health', 'pressure', 1067);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1044, 1026, 1056, 1070.0, 'state', 'so', 1082.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1045, 1027, 1057, 1079.0, 'opportunity', 'clear', 1097.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1046, 1028, 1058, 1088.0, 'usually', 'wish', 1112.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1047, 1029, 1059, 1097.0, 'two', 'wonder', 1127.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1048, 1030, 1060, 1106.0, 'investment', 'economic', 1142.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1990' ORDER BY T1.time, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
(1025,)
(1030,)
(1027,)
*/

-- Prediction Query
SELECT T2.driverId FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1990' ORDER BY T1.milliseconds, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 3;

/*
Prediction Result:
*/