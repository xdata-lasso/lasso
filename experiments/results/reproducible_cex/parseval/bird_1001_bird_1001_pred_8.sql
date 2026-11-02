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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2008, 757448742, 1, '4nrq', '2023-01-30', 'fqyp', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483648, 2008, -921187550, 1, 'bbp02eutliqa', '2024-10-16', 'ryytoo3', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2008, 602161869, 1, 'xa', '2025-11-03', 'yfdrz', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2008, -1496556994, 1, 'i', '2025-08-02', 'h', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2008, -2072838897, -2147483648, 'foa', '2020-07-07', '0', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 2008, -2136247961, -2147483648, 'la3', '2022-08-04', 'v8u', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483642, 2008, 362376128, -2147483648, 'mu2ne578lf', '2023-10-17', 'yz7zzbe8yvk', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 2008, 2061558815, -2147483648, '5amsorlwyngc', '2024-10-05', 'j', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483640, 2008, -413043724, 1, 'k1yoeyo6l0h', '2020-07-14', '6fuqy', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 1, 2018368241, -2147483648, 'xw1rxe9yfk7', '2022-11-15', '162', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483638, 2008, -516345261, 1, 'o', '2021-04-24', 'u06dza', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2008, 1291298007, -2147483648, 'tdqr', '2021-03-30', '5wli', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483636, 2008, -1260548409, 1, 'p490', '2024-01-23', 'm', 'url_13');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 1, -1101814296, -2147483648, 'lvrisurz0k', '2020-02-06', 'qtncgc8s3b7', 'url_14');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483634, 2008, 180947503, -2147483648, 'dmdbdh', '2023-05-27', 'j47nxar50', 'url_15');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, 2008, 1754053934, -2147483648, 'v', '2023-11-10', 'yqro', 'url_16');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483632, 2008, -1582954378, -2147483648, 'rpo', '2023-07-07', 't63', 'url_17');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, 2008, -526608193, -2147483648, 'vjwq49yrnx', '2023-04-20', '6dvdxdo2v7', 'url_18');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483630, 2008, 1770139230, -2147483648, 'gvplj9fjvu', '2023-08-07', '7k10', 'url_19');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, 1, 1069076646, -2147483648, 'ak162oca', '2021-02-09', 'eev', 'url_20');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483628, 2008, -410809407, -2147483648, 'u49', '2021-10-18', 'boe8cd', 'url_21');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (13, 2008, -958249959, -2147483648, 'uez', '2020-06-24', 'ehia3', 'url_22');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483626, 2008, 806158445, 1, 'vb7vpc0xff', '2023-12-12', 'r1es', 'url_23');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'tilbn', 462974032, 'posiie5unw6k', 't2__35b35a', 't2__9659f3', '2021-12-14', 'a9', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, '00t5c4e', 1274489983, 'gce', 't2__35b35a', 't2__9659f3', '2025-03-28', '6nium52zb', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'rljsl0b4y', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', '2021-09-16', 'hwbdvlph', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'k3zbily', 638024588, '6vck6ah0f8js', 't2__35b35a', 't2__9659f3', '2023-11-21', 'lq7xb7', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, 'sj3ayxp1q430', 1923912467, 'jh3den8c68', '8vacx7', 'f', '2023-07-08', 'w1of77pz', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '7z2zezjo7wg', 1248858185, '5', 'sxcmr0o', 'ztdgj5i3lq5l', '2022-06-10', 'im5k', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'v42q7sx58b4p', 319284352, '3auvm', 'rpd', 'wzw', '2025-06-18', 'h', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, 'uzkb52', -277407746, 'nlas6e', 'lboeowii1z5', 'xih6', '2025-08-17', 'q2xlyoto', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, '5rmkio18', 769234989, '8ftp6ewtqx', 'njabym', 'n2mfx7h', '2025-03-14', 'p6sto1cj', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, 'sqtgelcuqb', 1374676344, 'f2ccukjq1', 'uik1y', 'hb08hlst1pq', '2022-07-23', 'iztv', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (9, 'sj', -1652411404, 'zxdp', 'nmwfwx', 'rlawk', '2024-09-05', '14r5dqtsmg97', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (10, 'xyfvmjwpp26', 1913338832, '3', 'j', '0ju0h3r133ir', '2024-11-25', 'x', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (11, 'z2my1ogyv1r', -1712532464, 'axc1clu', 'gly7', '8oitxeilpe0', '2024-10-18', 'cy7od033d', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (12, '4u', 426006253, 'll', 'w', 'dpu5v0', '2020-10-14', 'u', 'url_14');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (13, 'sf9', 1494789426, 'g01hu', 'j7f', '8kqhiu5gm8', '2021-02-03', 'b5qjls', 'url_15');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '9hl7', 'name_1', 'klex14ji', '7zwau2dwyr');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', 'Marina Bay Street Circuit', '9n8', '4', 249.706432, 99.523333, -734455130, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '4h', 'Marina Bay Street Circuit', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, -1910425938, 'url_2');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2008, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: qualifying --
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1, 1, 2, -2147483648, -1021749117, 392822403, 'yu78', '9', 't1__faa8b5');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483648, 1, 3, -2147483648, 1298861365, 1968874827, 'nqcx5h', 'cprj', 't1__f09558');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (0, 1, 2, -2147483648, -792947627, -1898531797, '9fjgq8n2f', 'dqv0gcb9', 't1__faa8b5');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-1, 3, 0, -2147483648, -1738458256, -1714354341, '8', 'yzt1afgogrit', 't1__faa8b5');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2, 1, 1, -2147483648, 820970595, 1421303999, 'j', 'e1io', 't1__faa8b5');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3, 4, 4, -2147483648, 195202164, 1817366143, '7p2r94gt', '2m', NULL);

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4, 5, 5, -2147483648, 234957614, 823835795, '05a9n0jxf', 'fwsz', 'o');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483641, -2147483642, 4, -2147483648, -1197954156, -2019656607, '0k32o', 'w', 't1__aab784');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (5, 6, 6, -2147483648, 205676091, -2094843966, '96', 'aqb0tbindz39', 'ajz9t');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483639, 1, 0, -2147483648, 1148916014, -1988582944, 'mbc3td', 'u6bd0w9603', 't1__aab784');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (6, 7, 7, -2147483648, -1643065004, -1438303683, 'zys7dyyd1jmg', 'jach8qta8y3', '1');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483637, -2147483640, 4, -2147483648, 614314115, 306260487, 'y', '3qdpu', 't1__aab784');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (7, 8, 8, -2147483648, 44959255, -74691962, '78aqqlu', '8', 'tb');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483635, -2147483640, 1, -2147483648, -1057355067, -1004098188, '6bjeuuwsj8k', 'h85', 't1__aab784');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (8, 9, 9, -2147483648, -1019350771, -225571092, '0pj6ddly', 'u6iph', 'k');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483633, -2147483638, 4, -2147483648, 1154884242, 1352531282, 'vwq51oa', 'sb3uoi1p', 't1__aab784');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (9, 10, 10, -2147483648, 1498496406, 370054768, 'i9esap8p', 'gckqwtsr54', '6qje');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483631, 5, 1, -2147483648, 328574939, 1464469520, 'nzg3rjkw', 'ns47j2ja8dc', 't1__aab784');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (10, 11, 11, -2147483648, 935816178, -1919535047, 'nhed29', 'qv2', 'u331spxpw');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483629, -2147483634, 5, -2147483648, -1725714389, -1248881581, '6id', 'p61l', 't1__aab784');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (11, 12, 12, -2147483648, 824044840, -214587907, '29835xo', 'pa', 'cxdb2f0c296x');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483627, 4, 5, -2147483648, 1177967285, -2001463367, '6cfperxa', '1sjv8nv3d', 't1__aab784');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (12, 13, 13, -2147483648, -924570154, -99415515, 'i3hl7j', '3y795ybv', '3kr3w4jn2');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483625, -2147483636, 13, -2147483648, 643485636, -1693332814, 'jacgmukfb5', 'f41', 't1__aab784');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('vqx58pz0f', '8jegd21vy9ux')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM circuits AS c JOIN races AS r ON c.circuitId = r.circuitId JOIN qualifying AS q ON r.raceId = q.raceId JOIN drivers AS d ON q.driverId = d.driverId WHERE c.name = 'Marina Bay Street Circuit' AND r.year = 2008 AND q.position = 1 AND q.q3 = (SELECT MIN(q3) FROM qualifying WHERE raceId = r.raceId) ORDER BY q.position, c.circuitid NULLS LAST, r.raceid NULLS LAST, q.qualifyid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/