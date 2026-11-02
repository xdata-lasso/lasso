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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1098, 'fund', 'John Santana', '00379 Stanley Roads
Lake Heather, NM 52884', 'Djibouti', 1102.5, 1106.5, 1110, 'http://www.russell-daniels.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1099, 'make', 'Carolyn Miller', '63287 Angela Vista
South Dennismouth, TN 70117', 'Hungary', 1115.5, 1121.5, 1127.0, 'http://www.price-carrillo.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1100, 'letter', 'Mackenzie Rogers', 'Unit 9579 Box 8687
DPO AE 97973', 'Puerto Rico', 1128.5, 1136.5, 1144.0, 'https://bender.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1101, 'Republican', 'Nicole Chambers', '3487 Joshua Club Suite 345
Patricialand, DC 20270', 'Cape Verde', 1141.5, 1151.5, 1161.0, 'https://www.robinson-graham.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1146, 'science', 'Travis Miller', '957 Coleman Summit Suite 574
Johnville, VA 25743', 'Egypt', 1150.5, 1154.5, 1158, 'https://www.james.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1147, 'up', 'Katherine Chang', '37498 Hooper Village
West Jeremy, HI 40119', 'British Indian Ocean Territory (Chagos Archipelago)', 1163.5, 1169.5, 1175.0, 'https://oliver.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1148, 'fact', 'Maria Henry', '0084 Dana Terrace
Garciatown, OK 37769', 'Moldova', 1176.5, 1184.5, 1192.0, 'http://miller.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1149, 'only', 'Anna Walker', '2047 Lynn Locks Suite 190
East Lisa, ME 11665', 'Serbia', 1189.5, 1199.5, 1209.0, 'http://norris-harrison.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1114, 'improve', 1118, 'success', 'Tamara Hooper', 'Murphy', '1986-06-17', 'Fiji', 'https://ruiz.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1115, 'great', 1125.0, 'interview', 'Susan Vargas', 'Gibson', '1986-06-18', 'Sao Tome and Principe', 'http://santos.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1116, 'relate', 1132.0, 'shake', 'Angela Patterson', 'Rogers', '1986-06-19', 'Zambia', 'http://www.combs.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1117, 'respond', 1139.0, 'company', 'Catherine Green', 'Hobbs', '1986-06-20', 'Switzerland', 'http://www.caldwell-elliott.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1162, 'each', 1166, 'scientist', 'Tammy French', 'Martin', '1994-03-02', 'France', 'https://mason-snyder.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1163, 'fight', 1173.0, 'trade', 'Mary Peck', 'Parker', '1994-03-03', 'Kazakhstan', 'http://morris.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1164, 'seat', 1180.0, 'long', 'Joshua Holland', 'Curry', '1994-03-04', 'British Virgin Islands', 'http://williams.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1165, 'fear', 1187.0, 'avoid', 'Samantha Jones', 'Carroll', '1994-03-05', 'Lao People''s Democratic Republic', 'https://www.graham.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1122, 'https://jackson-lawson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1123, 'http://lane.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1124, 'https://gonzalez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1125, 'http://burke.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1170, 'https://morris-garcia.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1171, 'https://simpson.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1172, 'http://edwards.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1173, 'https://www.booth.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1126, 1122, 1130, 1098, 'Jeffrey Wood', '1990-10-21', 'learn', 'https://graham-simon.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1127, 1122, 1137.0, 1098, 'Gloria Atkinson', '1990-10-22', 'control', 'https://www.ramirez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1128, 1122, 1144.0, 1098, 'Ashley Yu', '1990-10-23', 'similar', 'https://johnson-rosales.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1129, 1122, 1151.0, 1098, 'Sandra Zimmerman', '1990-10-24', 'nearly', 'https://www.salinas-peterson.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1174, 1170, 1178, 1146, 'Peter Garrett', '1998-07-06', 'education', 'http://walker.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1175, 1170, 1185.0, 1146, 'Christina Dunn', '1998-07-07', 'security', 'http://www.cantu-carter.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1176, 1170, 1192.0, 1146, 'Jessica Wolfe', '1998-07-08', 'cold', 'https://sanchez-arnold.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1177, 1170, 1199.0, 1146, 'William Lynch', '1998-07-09', 'foreign', 'http://www.hill.com/');
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1126, 1114, 1134, 1138, '12:34.56', 1142);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1127, 1114, 1135, 1147.0, '12:34.56', 1155.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1128, 1114, 1136, 1156.0, '12:34.56', 1168.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1129, 1114, 1137, 1165.0, '12:34.56', 1181.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1174, 1162, 1182, 1186, NULL, 1190);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1175, 1162, 1183, 1195.0, NULL, 1203.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1176, 1162, 1184, 1204.0, NULL, 1216.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1177, 1162, 1185, 1213.0, NULL, 1229.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH lap_times_in_seconds AS (SELECT driverId, (CASE WHEN INSTR(time, ':') <> INSTR(SUBSTRING(time, INSTR(time, ':') + 1), ':') + INSTR(time, ':') THEN CAST(SUBSTRING(time, 1, INSTR(time, ':') - 1) AS REAL) * 3600 ELSE 0 END) + (CAST(SUBSTRING(time, INSTR(time, ':') - 2 * (INSTR(time, ':') = INSTR(SUBSTRING(time, INSTR(time, ':') + 1), ':') + INSTR(time, ':')), INSTR(time, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(time, INSTR(time, ':') + 1, INSTR(time, '.') - INSTR(time, ':') - 1) AS REAL)) + (CAST(SUBSTRING(time, INSTR(time, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM lapTimes) SELECT T2.forename, T2.surname FROM (SELECT driverId, MIN(time_in_seconds) AS min_time_in_seconds FROM lap_times_in_seconds GROUP BY driverId) AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId ORDER BY T1.min_time_in_seconds ASC, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Tammy French', 'Martin')
*/

-- Prediction Query
SELECT T2.forename, T2.surname FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId ORDER BY T1.milliseconds ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Tamara Hooper', 'Murphy')
*/