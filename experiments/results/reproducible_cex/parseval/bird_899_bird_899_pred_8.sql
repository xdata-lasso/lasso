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
-- Inserting into table: races --
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, 1151980946, 2, 'a9', '1990-01-01', '00t5c4e', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, -1245682094, 2, 'x', '1990-01-01', '5hncprjtu0d', 'A');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, -1748371085, 2, 'q8', '1990-01-01', 'n2f3dqv0gcb9', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483645, -2147483648, -2078052421, 2, 'yrk', '1990-01-01', 'n6vck6ah0f', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483644, -2147483648, -1388029300, 2, 'xb72fxa7r', '1990-01-01', 'fdrz16n', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483643, -2147483648, -7597509, 2, 'h5ogrgjd8yz', '1990-01-01', '1afgo', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483642, -2147483648, 678047687, 2, '3ay', '1990-01-01', 'p1q430', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, -1125548818, 3, '94gth', '1990-01-01', '2mnajjla3o', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483640, -2147483648, 872694102, 1, 'tmu2n', '1990-01-01', '57', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, -2147483648, 697257217, 6, '7zzbe8y', '1990-01-01', 'kv42q7', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, -2147483648, 1735561423, 7, '58b4pmaus3a', '1990-01-01', 'vmkrpd', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, -2147483648, 1105964624, 4, 'w5chn9m', '1990-01-01', 'o705a9n0jxfo', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, -2147483648, -634585028, 5, 'do2zobb', '1990-01-01', 'q0k32od', 'url_13');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, -2147483648, -841692980, 8, 'bnp', '1990-01-01', 'mdpos', 'url_14');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, -2147483648, -1823627488, -2147483648, 'nw6klf', '1990-01-01', 'a9000t5c4eci', 'url_15');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2, '5k5swwqcgs', 't1__21dc14', '9n8', '4', 249.706432, 99.523333, -734455130, 'C');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '4h', 't1__21dc14', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, -1910425938, 'A');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'tilbn', 't1__21dc14', 'rmdp', 'siie', 489.397796, 933.422701, 44952191, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483645, 'e', 't1__21dc14', '76nium52', 'zbuo4nrqrof', 586.906897, 389.878901, -921187550, 'url_4');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483644, '2eutliqa11r', 't1__21dc14', 'ytoo3o9', 'l7', 443.457804, 774.422647, -1390245819, 'url_5');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483643, '7zw', 't1__21dc14', 'au2dwyrq13', 'yu78', 49.538289, 557.003843, -1362461264, 'url_6');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483642, 'yp5qi2rk', 't1__21dc14', '9v', 'x58pz', 410.133844, 88.474525, -1529584866, 'url_7');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483641, 'y9uxj4', 't1__21dc14', 'wb', 'v', 185.427628, 243.480613, 1581736075, 'url_8');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3, 'den8c68x', 'vacx7afu5', '1of77p', 'o72ctdc', 803.582738, 695.452114, -1284905200, 'url_9');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4, '62', 't1__8edfee', '0v', 'q8qdjpe1', 140.053935, 225.249964, 199672698, 'url_10');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (5, '7cvtjpt', 't1__8edfee', 'tg6bnou5zi', '6c4bfkfo', 12.330671, 774.96573, -1950324754, 'url_11');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (6, '7z2zezj', 't1__8edfee', '7wgx', '5', 377.388457, 372.754231, -405743609, 'url_12');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (7, 'g', 't1__8edfee', '5i3', 'q5l', 811.930904, 236.262879, -1556979799, 'url_13');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (9, '5k5swwqcgs', 't1__a745a9', '9n8', '4', 249.706432, 99.523333, -734455130, 'url_14');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (8, '4h', 't1__a745a9', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, -1910425938, 'url_15');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483633, '5k5swwqcgs', 't1__21dc14', '9n8', '4', 249.706432, 99.523333, -734455130, 'url_16');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483632, '4h', 't1__21dc14', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, -1910425938, 'url_17');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483631, 'tilbn', 't1__21dc14', 'rmdp', 'siie', 489.397796, 933.422701, 44952191, 'url_18');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483630, 'fa9', 't1__21dc14', '00t5c4e', 'cigce376nium', 779.28645, 566.030342, 742285925, 'url_19');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483629, 'u', 't1__21dc14', '4nrq', 'rofqyp5s5b', 22.720462, 990.777211, 882961052, 'url_20');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483628, '2eutliqa11r', 't1__21dc14', 'ytoo3o9', 'l7', 443.457804, 774.422647, -1390245819, 'url_21');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483627, 'x14ji7zwau2d', 't1__21dc14', 'yrq13p', 'u78d99r', 182.777264, 943.791649, -904834265, 'url_22');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483626, 'b4yp5qi', 't1__21dc14', 'rkf9vqx5', 'pz0f8jegd', 452.27611, 434.003102, 233994589, 'url_23');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483625, 'j4hwbd', 't1__21dc14', 'lph2gn', 'q', 345.35543, 250.856497, 555413010, 'url_24');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483624, '5hncprjtu0d', 't1__21dc14', '79fjgq8', 'n2f3dqv0gcb9', 540.154414, 874.028321, 1443629118, 'url_25');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483623, 'zbilyrkn', 't1__21dc14', '6vck6ah0f8js', 'wlq7xb', 598.428216, 949.322482, 602161869, 'url_26');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483622, 'xa', 't1__21dc14', '7ryfdrz16n', 'jja', 128.858335, 498.231061, -1625552518, 'url_27');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE STRFTIME('%Y', T2.date) BETWEEN '1990' AND '2000' GROUP BY T1.name HAVING COUNT(T2.raceId) = 4;

/*
Gold Result:
('t1__8edfee',)
*/

-- Prediction Query
SELECT c.name FROM circuits AS c JOIN races AS r ON c.circuitId = r.circuitId WHERE r.year BETWEEN 1990 AND 2000 GROUP BY c.name HAVING COUNT(r.raceId) = 4;

/*
Prediction Result:
*/