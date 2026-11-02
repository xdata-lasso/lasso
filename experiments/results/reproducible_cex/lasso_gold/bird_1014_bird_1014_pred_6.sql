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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1001, 'purpose', 'Daniel Doyle', '79402 Peterson Drives Apt. 511
Davisstad, PA 35172', 'Germany', 1005.5, 1009.5, 1013, 'https://baker.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1002, 'brother', 'Stephanie Miller', '161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 'Croatia', 1018.5, 1024.5, 1030.0, 'https://ross.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1003, 'ago', 'Allen Robinson', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'Palau', 1031.5, 1039.5, 1047.0, 'https://www.callahan.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1004, 'site', 'Alyssa Gonzalez', '503 Linda Locks
Carlshire, FM 94599', 'Luxembourg', 1044.5, 1054.5, 1064.0, 'https://www.james-ferrell.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1017, 'enter', 'Nathan Maldonado', '148 Eric Track
New Stephanie, NC 00575', 'Italy', 1021.5, 1025.5, 1029, 'http://mueller.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1018, 'on', 'Debra Davidson', '15430 Natalie Common Apt. 718
East Donna, OH 22144', 'Italy', 1034.5, 1040.5, 1046.0, 'http://www.jordan.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1019, 'traditional', 'Jeffrey Chavez', '83465 Lam Mission Apt. 331
Andrewside, IN 77629', 'Italy', 1047.5, 1055.5, 1063.0, 'http://www.chandler-mcbride.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1020, 'yes', 'Sherri Baker', '031 Michele Cliffs
West Elizabeth, IL 71179', 'Italy', 1060.5, 1070.5, 1080.0, 'http://www.herrera.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1033, 'cover', 'Angela Morton', 'Liberia', 'http://www.smith-myers.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1034, 'family', 'Annette Pearson', 'Tonga', 'https://bernard.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1035, 'maintain', 'Alexis Davis', 'Iran', 'http://www.robinson-brown.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1036, 'enjoy', 'Cynthia Russell', 'United Kingdom', 'http://williams.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1037, 'wide', 1041, 'art', 'Kurt Leonard', 'Donovan', '1970-01-01', 'Indonesia', 'https://hickman-walls.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1038, 'tonight', 1048.0, 'movie', 'Bryan Zamora', 'Harris', '1970-01-02', 'Bulgaria', 'https://www.medina.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1039, 'nice', 1055.0, 'be', 'Kristopher Harvey', 'Moran', '1970-01-03', 'Paraguay', 'http://suarez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1040, 'coach', 1062.0, 'today', 'Kevin Mills', 'Allen', '1970-01-04', 'Oman', 'http://warner.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1045, 'http://garcia.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1046, 'http://jacobs-robbins.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1047, 'https://whitehead-mathis.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1048, 'https://smith.com/');
INSERT INTO "status" ("statusid", "status") VALUES (1049, 'color');
INSERT INTO "status" ("statusid", "status") VALUES (1050, 'letter');
INSERT INTO "status" ("statusid", "status") VALUES (1051, 'ok');
INSERT INTO "status" ("statusid", "status") VALUES (1052, 'season');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1053, 1045, 1057, 1001, 'Adam Jones', '1974-05-05', 'style', 'http://www.garcia.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1054, 1045, 1064.0, 1001, 'Stephanie Gardner', '1974-05-06', 'among', 'http://www.cherry.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1055, 1045, 1071.0, 1001, 'Lauren Hernandez', '1974-05-07', 'way', 'http://www.middleton.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1056, 1045, 1078.0, 1001, 'Eric Nolan', '1974-05-08', 'help', 'https://www.rodriguez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1061, 1045, 1065, 1017, 'Thomas Bailey', '1978-09-09', 'Mr', 'https://www.wiley.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1062, 1045, 1072.0, 1017, 'Shelby Walker', '1978-09-10', 'instead', 'https://www.carlson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1063, 1045, 1079.0, 1017, 'Jennifer Ramirez', '1978-09-11', 'respond', 'https://www.lam-lee.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1064, 1045, 1086.0, 1017, 'Raymond Bell', '1978-09-12', 'threat', 'https://www.frost.com/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1069, 1053, 1037, 1033, 1073, 1077, 1081, 'himself', 1085, 1089.5, 1093, 'wife', 1097, 1101, 1105, '12:34.56', 'record', 1049);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1070, 1053, 1037, 1033, 1084.0, 1090.0, 1096.0, 'lawyer', 1104.0, 1110.5, 1116.0, 'give', 1124.0, 1130.0, 1136.0, '12:34.56', 'thus', 1049);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1071, 1053, 1037, 1033, 1095.0, 1103.0, 1111.0, 'available', 1123.0, 1131.5, 1139.0, 'price', 1151.0, 1159.0, 1167.0, '12:34.56', 'capital', 1049);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1072, 1053, 1037, 1033, 1106.0, 1116.0, 1126.0, 'red', 1142.0, 1152.5, 1162.0, 'former', 1178.0, 1188.0, 1198.0, '12:34.56', 'service', 1049);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1109, 1061, 1037, 1033, 1113, 1117, 1121, 'we', 1125, 1129.5, 1133, 'reflect', 1137, 1141, 1145, '12:34.56', 'same', 1049);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1110, 1061, 1037, 1033, 1124.0, 1130.0, 1136.0, 'first', 1144.0, 1150.5, 1156.0, 'issue', 1164.0, 1170.0, 1176.0, '12:34.56', 'find', 1049);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1111, 1061, 1037, 1033, 1135.0, 1143.0, 1151.0, 'movement', 1163.0, 1171.5, 1179.0, 'general', 1191.0, 1199.0, 1207.0, '12:34.56', 'once', 1049);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1112, 1061, 1037, 1033, 1146.0, 1156.0, 1166.0, 'for', 1182.0, 1192.5, 1202.0, 'interesting', 1218.0, 1228.0, 1238.0, '12:34.56', 'care', 1049);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T1.FastestLapTime AS lap_record FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds LIMIT 1;

/*
Gold Result:
('12:34.56',)
*/

-- Prediction Query
SELECT lt.time FROM circuits AS c JOIN races AS r ON c.circuitId = r.circuitId JOIN lapTimes AS lt ON r.raceId = lt.raceId WHERE c.country = 'Italy';

/*
Prediction Result:
*/