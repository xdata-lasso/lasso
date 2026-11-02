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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1001, 'purpose', 'Megan Mcclain', '78161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 'Saudi Arabia', 1009.5, 1017.5, 1025, 'https://hayes.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1002, 'brother', 'Javier Johnson', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'Saint Lucia', 1022.5, 1032.5, 1042.0, 'http://www.jones.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1003, 'ago', 'Jonathan Johnson', '503 Linda Locks
Carlshire, FM 94599', 'Portugal', 1035.5, 1047.5, 1059.0, 'http://www.heath.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1004, 'site', 'Matthew Gardner', '7242 Julie Plain Suite 969
Coxberg, NY 65187', 'Cook Islands', 1048.5, 1062.5, 1076.0, 'http://washington.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1005, 'face', 'Kevin Pacheco', '22691 James Mountain
Tashatown, TX 94967', 'Rwanda', 1061.5, 1077.5, 1093.0, 'https://www.aguirre-lee.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1006, 'election', 'Robert Wolfe', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'Georgia', 1074.5, 1092.5, 1110.0, 'https://jenkins-shields.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1007, 'dog', 'Christopher Bernard', '809 Burns Creek
Natashaport, IA 08093', 'Iran', 1087.5, 1107.5, 1127.0, 'http://www.chandler-mcbride.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1008, 'chair', 'Brandon Davis', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'Paraguay', 1100.5, 1122.5, 1144.0, 'http://www.herrera.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1033, 'cover', 1041, 'system', 'Tracy House', 'Allison', '1982-12-31', 'German', 'http://olson-hancock.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1034, 'family', 1048.0, 'training', 'Tracy House', 'Allison', '1983-01-01', 'German', 'http://galloway.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1035, 'maintain', 1055.0, 'total', 'Tracy House', 'Allison', '1983-01-02', 'German', 'https://bernard.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1036, 'enjoy', 1062.0, 'oil', 'Tracy House', 'Allison', '1983-01-03', 'German', 'http://www.robinson-brown.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1037, 'two', 1069.0, 'billion', 'Tracy House', 'Allison', '1983-01-04', 'German', 'http://williams.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1038, 'wind', 1076.0, 'apply', 'Tracy House', 'Allison', '1983-01-05', 'German', 'http://www.miller.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1039, 'bag', 1083.0, 'reach', 'Tracy House', 'Allison', '1983-01-06', 'German', 'https://www.sanchez.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1040, 'level', 1090.0, 'now', 'Tracy House', 'Allison', '1983-01-07', 'German', 'https://santiago.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1049, 'https://powers.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1050, 'https://www.ellis.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1051, 'http://www.baker.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1052, 'https://kim.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1053, 'http://garcia.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1054, 'http://jacobs-robbins.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1055, 'https://whitehead-mathis.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1056, 'https://smith.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1057, 1049, 1065, 1001, 'Jeremy Thornton', '1970-01-01', 'so', 'http://white.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1058, 1050, 1072.0, 1002, 'Ashley Landry', '1970-01-02', 'clear', 'http://cobb.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1059, 1051, 1079.0, 1003, 'Brittany Johnson', '1970-01-03', 'wish', 'http://gonzalez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1060, 1052, 1086.0, 1004, 'Juan Jordan', '1970-01-04', 'wonder', 'https://www.johnson.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1061, 1053, 1093.0, 1005, 'Jacob Fitzpatrick', '1970-01-05', 'economic', 'https://rasmussen.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1062, 1054, 1100.0, 1006, 'Amanda Howard', '1970-01-06', 'treatment', 'https://wilson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1063, 1055, 1107.0, 1007, 'Mary Gomez', '1970-01-07', 'commercial', 'https://www.carlson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1064, 1056, 1114.0, 1008, 'Shelly Dickson', '1970-01-08', 'such', 'https://www.lam-lee.com/');
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1057, 1033, 1073, 1081, 'section', 'yard', 1089);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1058, 1034, 1074, 1090.0, 'least', 'since', 1104.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1059, 1035, 1075, 1099.0, 'ability', 'religious', 1119.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1060, 1036, 1076, 1108.0, 'nature', 'debate', 1134.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1061, 1037, 1077, 1117.0, 'sure', 'himself', 1149.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1062, 1038, 1078, 1126.0, 'nothing', 'lawyer', 1164.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1063, 1039, 1079, 1135.0, 'right', 'available', 1179.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1064, 1040, 1080, 1144.0, 'serve', 'red', 1194.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('Tracy House', 'Allison')
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname FROM drivers INNER JOIN pitstops ON drivers.driverid = pitstops.driverid WHERE drivers.nationality = 'German' AND STRFTIME('%Y', drivers.dob) BETWEEN '1980' AND '1985' GROUP BY drivers.driverid ORDER BY AVG(pitstops.duration) ASC, drivers.forename NULLS LAST, drivers.surname NULLS LAST LIMIT 3;

/*
Prediction Result:
('Tracy House', 'Allison')
('Tracy House', 'Allison')
('Tracy House', 'Allison')
*/