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
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1033, 'cover', 'Savannah Garcia', 'Comoros', 'https://www.silva.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1034, 'family', 'Kimberly Smith', 'French Polynesia', 'http://www.miller.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1035, 'maintain', 'Paul Young', 'Cuba', 'https://www.sanchez.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1036, 'enjoy', 'John Hancock', 'Azerbaijan', 'https://santiago.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1037, 'two', 'Carmen Smith', 'Mozambique', 'https://powers.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1038, 'wind', 'Timothy Glover', 'Saint Pierre and Miquelon', 'https://www.ellis.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1039, 'bag', 'Michael Cross', 'Mauritius', 'http://www.baker.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1040, 'level', 'Mary Tucker', 'Bahamas', 'https://kim.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1041, 'population', 1049, 'firm', 'Brian Tran', 'Mckee', '1970-01-01', 'South Africa', 'http://henson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1042, 'surface', 1056.0, 'work', 'Larry Robbins', 'Gardner', '1970-01-02', 'Tokelau', 'http://www.keith.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1043, 'ready', 1063.0, 'record', 'Mark Baker', 'Davenport', '1970-01-03', 'Armenia', 'https://shields.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1044, 'newspaper', 1070.0, 'body', 'Taylor Mathis Jr.', 'Aguilar', '1970-01-04', 'United Arab Emirates', 'https://www.walker-velasquez.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1045, 'across', 1077.0, 'wrong', 'Donald Smith', 'Hernandez', '1970-01-05', 'Guinea-Bissau', 'https://walker.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1046, 'region', 1084.0, 'unit', 'Mandy Green', 'Anderson', '1970-01-06', 'Cote d''Ivoire', 'https://lin-rasmussen.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1047, 'technology', 1091.0, 'center', 'Kristen Patterson', 'Parker', '1970-01-07', 'Pitcairn Islands', 'https://zavala.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1048, 'once', 1098.0, 'everything', 'Benjamin Ware', 'Nolan', '1970-01-08', 'Egypt', 'https://www.estes.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1057, 'https://obrien-dixon.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1058, 'http://fletcher.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1059, 'http://jones-beck.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1060, 'https://www.mccullough.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1061, 'https://martinez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1062, 'https://bass.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1063, 'https://ramos-lewis.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1064, 'http://www.robertson-schultz.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (18, 1057, 1072, 1001, 'Trevor Young', '1978-09-09', 'safe', 'https://www.contreras-travis.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1065, 1058, 1079.0, 1002, 'Robert Hernandez', '1978-09-10', 'national', 'https://briggs.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1066, 1059, 1086.0, 1003, 'William Carr', '1978-09-11', 'majority', 'https://www.hensley.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1067, 1060, 1093.0, 1004, 'Joy Mercado', '1978-09-12', 'apply', 'https://www.gonzales-reeves.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1068, 1061, 1100.0, 1005, 'Michelle Cruz', '1978-09-13', 'onto', 'https://orozco-miller.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1069, 1062, 1107.0, 1006, 'Charles Watts', '1978-09-14', 'whose', 'http://hernandez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1070, 1063, 1114.0, 1007, 'Shannon Mcclure', '1978-09-15', 'thus', 'https://clark.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1071, 1064, 1121.0, 1008, 'Colleen Brock', '1978-09-16', 'campaign', 'http://smith-bell.biz/');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1080, 18, 1041, 1033, 1088, 1096, 'tonight', 'such', 'mention');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1081, 1065, 1042, 1034, 1099.0, 1109.0, 'wait', 'player', 'air');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1082, 1066, 1043, 1035, 1110.0, 1122.0, 'thing', 'water', 'improve');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1083, 1067, 1044, 1036, 1121.0, 1135.0, 'kind', 'discussion', 'great');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1084, 1068, 1045, 1037, 1132.0, 1148.0, 'nothing', 'method', 'relate');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1085, 1069, 1046, 1038, 1143.0, 1161.0, 'small', 'discuss', 'respond');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1086, 1070, 1047, 1039, 1154.0, 1174.0, 'simple', 'explain', 'success');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1087, 1071, 1048, 1040, 1165.0, 1187.0, 'office', 'least', 'interview');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 18 ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Gold Result:
('population',)
*/

-- Prediction Query
SELECT d.driverRef FROM qualifying AS q INNER JOIN drivers AS d ON q.driverId = d.driverId WHERE q.raceId = 20 ORDER BY q.q1 DESC, q.qualifyid NULLS LAST, d.driverid NULLS LAST LIMIT 5;

/*
Prediction Result:
*/