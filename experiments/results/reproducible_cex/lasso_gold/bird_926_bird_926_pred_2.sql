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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1085, 'phone', 'Kevin Mills', '911 William Curve Suite 135
Ericside, VT 40152', 'United Arab Emirates', 1089.5, 1093.5, 1097, 'http://www.deleon-henson.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1086, 'among', 'Christina Moran', '841 Joseph Coves
West Juan, IL 94559', 'Guinea-Bissau', 1102.5, 1108.5, 1114.0, 'http://www.cherry.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1087, 'president', 'James Powers', '740 Cynthia Village Suite 005
Lake Tina, GA 97655', 'Cote d''Ivoire', 1115.5, 1123.5, 1131.0, 'http://www.middleton.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1088, 'beat', 'Eugene Walton', '011 Amy Village Suite 982
Andersonport, MN 05730', 'Pitcairn Islands', 1128.5, 1138.5, 1148.0, 'https://www.rodriguez.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1101, 'decision', 'Robert Savage', 'Tajikistan', 'http://www.white-estes.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1102, 'technology', 'Matthew Ross', 'Mauritania', 'http://www.hamilton.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1103, 'why', 'Benjamin Ayala', 'Greenland', 'http://lee.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1104, 'magazine', 'Jordan Frazier', 'Wallis and Futuna', 'http://jones-beck.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1105, 'Lewis', 1109, 'price', 'Steve Sanchez', 'Hamilton', '1978-09-09', 'British Virgin Islands', 'https://powell-phillips.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1106, 'Lewis', 1116.0, 'former', 'Steve Sanchez', 'Hamilton', '1978-09-10', 'Saint Helena', 'http://bentley.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1107, 'Lewis', 1123.0, 'record', 'Steve Sanchez', 'Hamilton', '1978-09-11', 'French Southern Territories', 'https://bass.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1108, 'Lewis', 1130.0, 'thus', 'Steve Sanchez', 'Hamilton', '1978-09-12', 'Madagascar', 'https://ramos-lewis.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1113, 'http://www.robertson-schultz.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1114, 'http://www.collins.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1115, 'http://atkinson.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1116, 'http://ross-hernandez.com/');
INSERT INTO "status" ("statusid", "status") VALUES (1117, 'walk');
INSERT INTO "status" ("statusid", "status") VALUES (1118, 'social');
INSERT INTO "status" ("statusid", "status") VALUES (1119, 'traditional');
INSERT INTO "status" ("statusid", "status") VALUES (1120, 'speech');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1121, 1113, 1125, 1085, 'Paula Robinson', '1982-02-13', 'operation', 'https://griffin.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1122, 1113, 1132.0, 1085, 'Melissa Marshall', '1982-02-14', 'physical', 'https://www.ramirez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1123, 1113, 1139.0, 1085, 'Sylvia Martinez', '1982-02-15', 'free', 'https://reeves.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1124, 1113, 1146.0, 1085, 'John Schmidt', '1982-02-16', 'someone', 'https://miller.com/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1129, 1121, 1105, 1101, 1133, 1137, 1141, 'seat', 1145, 1149.5, 1153, 'involve', 1157, 1161, 1165, 'just', 'kitchen', 1117);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1130, 1121, 1105, 1101, 1144.0, 1150.0, 1156.0, 'difficult', 1164.0, 1170.5, 1176.0, 'give', 1184.0, 1190.0, 1196.0, 'assume', 'improve', 1117);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1131, 1121, 1105, 1101, 1155.0, 1163.0, 1171.0, 'attack', 1183.0, 1191.5, 1199.0, 'occur', 1211.0, 1219.0, 1227.0, 'design', 'west', 1117);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1132, 1121, 1105, 1101, 1166.0, 1176.0, 1186.0, 'join', 1202.0, 1212.5, 1222.0, 'man', 1238.0, 1248.0, 1258.0, 'there', 'pattern', 1117);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.fastestLapTime FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T1.forename = 'Lewis' AND T1.surname = 'Hamilton' AND NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapTime ASC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT MIN("results"."fastestlaptime") FROM "drivers" INNER JOIN "results" ON "drivers"."driverid" = "results"."driverid" WHERE "drivers"."forename" = 'Lewis' AND "drivers"."surname" = 'Hamilton';

/*
Prediction Result:
(None,)
*/