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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1088, 'like', 'Joanna Walton', '734 Jones Heights Apt. 455
East Edwardfurt, UT 20529', 'Croatia', 1092.5, 1096.5, 1100, 'https://king-miller.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1089, 'watch', 'Joanna Walton', '6587 Brown Village
Priceshire, UT 03061', 'Korea', 1105.5, 1111.5, 1117.0, 'http://santos.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1090, 'cold', 'Joanna Walton', '0546 Medina Street Apt. 734
Tuckerfurt, MA 88171', 'Greece', 1118.5, 1126.5, 1134.0, 'http://www.combs.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1091, 'six', 'Joanna Walton', '272 Rebecca Ramp Apt. 162
Whiteview, MS 43407', 'Guadeloupe', 1131.5, 1141.5, 1151.0, 'http://www.caldwell-elliott.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1116, 'science', 'Travis Miller', '377 Mcguire Course Suite 363
Elizabethstad, NJ 73045', 'Austria', 1120.5, 1124.5, 1128, 'https://www.morales.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1117, 'up', 'Travis Miller', '855 Nelson Glen Apt. 135
Lake Amandaburgh, ID 28862', 'El Salvador', 1133.5, 1139.5, 1145.0, 'http://www.shepherd.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1118, 'fact', 'Travis Miller', '989 Hooper Village Apt. 435
West Alexis, ND 17092', 'Wallis and Futuna', 1146.5, 1154.5, 1162.0, 'http://www.duran.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1119, 'only', 'Travis Miller', '427 Monique Ports
Taylormouth, MA 24665', 'Tokelau', 1159.5, 1169.5, 1179.0, 'https://evans-chapman.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1144, 'whom', 'Travis Miller', '75655 Mia Isle Suite 746
South Christopherview, MD 15695', 'Micronesia', 1148.5, 1152.5, 1156, 'http://www.barton-dickerson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1145, 'fall', 'Travis Miller', 'Unit 6808 Box 7603
DPO AP 47920', 'Cameroon', 1161.5, 1167.5, 1173.0, 'https://www.barber-monroe.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1146, 'course', 'Travis Miller', '703 Dunn Heights Suite 710
Lake Eric, OH 02293', 'Hungary', 1174.5, 1182.5, 1190.0, 'https://www.ryan-reed.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1147, 'pay', 'Travis Miller', '17127 Hicks Groves
Davenportfort, IA 60372', 'Comoros', 1187.5, 1197.5, 1207.0, 'https://kane-pollard.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1104, 'https://jackson-lawson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1105, 'http://lane.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1106, 'https://gonzalez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1107, 'http://burke.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1132, 'https://www.choi.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1133, 'https://www.allen.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1134, 'http://www.hayes-wheeler.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1135, 'http://www.mann-warner.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1160, 'https://www.williams-garner.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1161, 'https://www.hanna-martinez.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1162, 'https://www.garcia-lozano.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1163, 'http://booker.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1108, 1104, 1112, 1088, 'Jeffrey Wood', '1995-07-02', 'learn', 'https://graham-simon.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1109, 1104, 1119.0, 1088, 'Gloria Atkinson', '1995-07-03', 'control', 'https://www.ramirez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1110, 1104, 1126.0, 1088, 'Ashley Yu', '1995-07-04', 'similar', 'https://johnson-rosales.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1111, 1104, 1133.0, 1088, 'Sandra Zimmerman', '1995-07-05', 'nearly', 'https://www.salinas-peterson.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1136, 1132, 1140, 1116, 'David Baker', '1995-07-02', NULL, 'https://harrison.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1137, 1132, 1147.0, 1116, 'Leah Lara', '1995-07-03', NULL, 'https://miller-williams.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1138, 1132, 1154.0, 1116, 'Brian Walker', '1995-07-04', NULL, 'https://davis.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1139, 1132, 1161.0, 1116, 'Derek Thomas', '1995-07-05', NULL, 'http://williams.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1164, 1160, 1168, 1144, 'Michael Santos', '1995-07-02', 'authority', 'https://www.davis.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1165, 1160, 1175.0, 1144, 'Sarah Villarreal', '1995-07-03', 'easy', 'https://www.evans.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1166, 1160, 1182.0, 1144, 'Eugene Higgins', '1995-07-04', 'program', 'https://jordan-sanchez.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1167, 1160, 1189.0, 1144, 'Shelia Johnson', '1995-07-05', 'return', 'http://www.miller.org/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE STRFTIME('%Y', T2.date) BETWEEN '1990' AND '2000' GROUP BY T1.name HAVING COUNT(T2.raceId) = 4;

/*
Gold Result:
('Joanna Walton',)
*/

-- Prediction Query
SELECT circuits.name FROM circuits INNER JOIN races ON circuits.circuitid = races.circuitid WHERE STRFTIME('%Y', races.date) BETWEEN '1990' AND '2000' GROUP BY races.circuitid HAVING COUNT(races.raceid) = 4;

/*
Prediction Result:
('Joanna Walton',)
('Travis Miller',)
('Travis Miller',)
*/