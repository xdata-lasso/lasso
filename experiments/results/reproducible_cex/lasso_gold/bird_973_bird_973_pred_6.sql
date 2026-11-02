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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1001, 'purpose', 'Leslie Johnson', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'Iraq', 1014.5, 1027.5, 1040, 'https://santiago.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1002, 'brother', 'David Guzman', '503 Linda Locks
Carlshire, FM 94599', 'British Indian Ocean Territory (Chagos Archipelago)', 1027.5, 1042.5, 1057.0, 'https://powers.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1003, 'ago', 'Michelle Miles', '7242 Julie Plain Suite 969
Coxberg, NY 65187', 'Western Sahara', 1040.5, 1057.5, 1074.0, 'https://www.ellis.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1004, 'site', 'Jerry Ramirez', '22691 James Mountain
Tashatown, TX 94967', 'Tuvalu', 1053.5, 1072.5, 1091.0, 'http://www.baker.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1005, 'face', 'Olivia Moore', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'Montenegro', 1066.5, 1087.5, 1108.0, 'https://kim.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1006, 'election', 'Donald Lewis', '809 Burns Creek
Natashaport, IA 08093', 'Egypt', 1079.5, 1102.5, 1125.0, 'http://garcia.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1007, 'dog', 'Ashley James', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'Mozambique', 1092.5, 1117.5, 1142.0, 'http://jacobs-robbins.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1008, 'chair', 'Gregory Baker', '465 Lam Mission
East Jeffreymouth, AK 77611', 'Nepal', 1105.5, 1132.5, 1159.0, 'https://whitehead-mathis.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1009, 'since', 'Joe Martinez', '10310 Jones Freeway
Elizabethborough, ND 17843', 'Armenia', 1118.5, 1147.5, 1176.0, 'https://smith.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1010, 'blue', 'Angela Carter', '76311 Gomez Loop Suite 010
Chandlerville, IA 25613', 'Niger', 1131.5, 1162.5, 1193.0, 'http://thornton.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1011, 'require', 'Stacey Ward', '62473 Scott Wall Apt. 080
Port Melindaburgh, MT 64154', 'Belgium', 1144.5, 1177.5, 1210.0, 'http://tran.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1012, 'sit', 'Benjamin Stanley', '26064 Mitchell Square Suite 234
North Beth, ND 08490', 'Italy', 1157.5, 1192.5, 1227.0, 'http://fleming.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1013, 'wait', 'Victoria Wyatt', '97882 Susan Common
North Brooke, TX 31329', 'Palestinian Territory', 1170.5, 1207.5, 1244.0, 'https://brady.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1053, 'such', 1066, 'treat', 'Robert Stevens', 'Jones', '1980-12-31', 'Spanish', 'https://www.carroll.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1054, 'talk', 1073.0, 'simple', 'Robert Perez', 'Beck', '1981-01-01', 'Spanish', 'https://www.floyd-lawson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1055, 'cost', 1080.0, 'energy', 'Corey Murphy', 'Rivera', '1980-12-31', 'Spanish', 'https://lowe-dixon.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1056, 'upon', 1087.0, 'example', 'Tracy Ramirez', 'Edwards', '1981-01-01', 'Spanish', 'http://beck.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1057, 'itself', 1094.0, 'collection', 'Jennifer Zavala', 'Charles', '1980-12-31', 'Spanish', 'https://www.hernandez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1058, 'country', 1101.0, 'store', 'Teresa Wilson', 'Cortez', '1981-01-01', 'Spanish', 'https://www.perry-soto.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1059, 'window', 1108.0, 'science', 'Cassandra Estes', 'Evans', '1980-12-31', 'Spanish', 'https://sanchez-douglas.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1060, 'go', 1115.0, 'box', 'Brian Hamilton', 'Parker', '1981-01-01', 'Spanish', 'http://thompson.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1061, 'stay', 1122.0, 'idea', 'Emily Obrien', 'Ortiz', '1980-12-31', 'Spanish', 'https://www.wright.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1062, 'word', 1129.0, 'turn', 'Janice Ray', 'Powell', '1981-01-01', 'Spanish', 'https://briggs.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1063, 'its', 1136.0, 'American', 'Michael Smith', 'Phillips', '1980-12-31', 'Spanish', 'https://www.hensley.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1064, 'suffer', 1143.0, 'town', 'Kimberly Ball', 'Martinez', '1981-01-01', 'Spanish', 'https://www.gonzales-reeves.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1065, 'relationship', 1150.0, 'many', 'Megan Diaz', 'Fisher', '1980-12-31', 'Spanish', 'https://orozco-miller.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1079, 'http://hernandez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1080, 'https://clark.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1081, 'http://smith-bell.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1082, 'https://www.robinson-graham.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1083, 'https://shelton.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1084, 'http://www.vargas-alvarado.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1085, 'https://www.white-green.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1086, 'http://rogers-hobbs.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1087, 'https://ruiz.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1088, 'http://santos.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1089, 'http://www.combs.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1090, 'http://www.caldwell-elliott.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1091, 'https://jackson-lawson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1092, 1079, 1105, 1001, 'Carla Collins', '1970-01-01', 'that', 'https://johnson-rosales.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1093, 1080, 1112.0, 1002, 'Tanya Johnston', '1970-01-02', 'side', 'https://www.salinas-peterson.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1094, 1081, 1119.0, 1003, 'Jaime David', '1970-01-03', 'person', 'https://www.vaughan.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1095, 1082, 1126.0, 1004, 'Kevin Rivas', '1970-01-04', 'executive', 'http://joseph.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1096, 1083, 1133.0, 1005, 'Michael Turner', '1970-01-05', 'future', 'http://sanchez.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1097, 1084, 1140.0, 1006, 'Renee Hogan', '1970-01-06', 'together', 'https://pierce.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1098, 1085, 1147.0, 1007, 'Amanda Patel', '1970-01-07', 'else', 'https://www.griffith.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1099, 1086, 1154.0, 1008, 'Andrea Holland', '1970-01-08', 'then', 'http://www.rodgers.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1100, 1087, 1161.0, 1009, 'Jason Henry', '1970-01-09', 'worry', 'https://www.phillips.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1101, 1088, 1168.0, 1010, 'Jack Snow', '1970-01-10', 'before', 'https://www.ferguson.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1102, 1089, 1175.0, 1011, 'Christian Thompson', '1970-01-11', 'family', 'https://www.oneill.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1103, 1090, 1182.0, 1012, 'Marie Gilbert', '1970-01-12', 'little', 'https://alexander-lopez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1104, 1091, 1189.0, 1013, 'Patricia Marshall', '1970-01-13', 'either', 'https://short.info/');
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1092, 1053, 1118, 1131, 'back', 'keep', 1144);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1093, 1054, 1119, 1140.0, 'part', 'police', 1159.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1094, 1055, 1120, 1149.0, 'professional', 'pick', 1174.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1095, 1056, 1121, 1158.0, 'rich', 'street', 1189.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1096, 1057, 1122, 1167.0, 'argue', 'present', 1204.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1097, 1058, 1123, 1176.0, 'civil', 'draw', 1219.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1098, 1059, 1124, 1185.0, 'church', 'stand', 1234.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1099, 1060, 1125, 1194.0, 'order', 'necessary', 1249.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1100, 1061, 1126, 1203.0, 'fly', 'husband', 1264.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1101, 1062, 1127, 1212.0, 'bed', 'when', 1279.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1102, 1063, 1128, 1221.0, 'by', 'level', 1294.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1103, 1064, 1129, 1230.0, 'open', 'finish', 1309.0);
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1104, 1065, 1130, 1239.0, 'south', 'trade', 1324.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'Spanish' AND STRFTIME('%Y', T2.dob) < '1982' ORDER BY T1.time DESC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 10;

/*
Gold Result:
(1065,)
(1056,)
(1055,)
(1054,)
(1060,)
(1064,)
(1061,)
(1058,)
(1059,)
(1063,)
*/

-- Prediction Query
SELECT d.forename, d.surname FROM drivers AS d JOIN laptimes AS la ON d.driverId = la.driverId WHERE d.nationality = 'Spanish' AND STRFTIME('%Y', d.dob) < '1982' GROUP BY d.driverId ORDER BY MAX(la.time) DESC, d.forename NULLS LAST, d.surname NULLS LAST LIMIT 10;

/*
Prediction Result:
*/