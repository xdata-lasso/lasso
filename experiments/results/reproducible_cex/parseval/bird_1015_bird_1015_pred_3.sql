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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -992890117, 1, 'Austrian Grand Prix', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, -1264842910, 1, 'Austrian Grand Prix', '2022-11-09', 'nqcx5h', 'C');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, -1106350634, 1, 'Austrian Grand Prix', '2021-08-31', 'u0dz7', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, -516345261, 1, 'Austrian Grand Prix', '2020-07-18', 'ohvu06dza3', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, -2147483648, -252690330, 4, 't2__6f29ea', '2022-09-17', 'uzhsrwbbp6lu', 'url_5');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'p', 13244799, 'hvdltt', 'lbn', 'rmdp', '2022-07-21', 'siie5unw6k', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'fa9', 'name_1', '00t5c4e', 'cigce376nium');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483647, 'f8jegd2', 'vy9uxj4', 'wb', 'v', 185.427628, 243.480613, 1581736075, 'url_2');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3, 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 187.71278, 789.269201, -405743609, 'url_3');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2, '5i3', 'q5l', 'pim5', '58q', 975.929586, 923.138524, 1615073310, 'url_4');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_5');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '52zbuo4nrq');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, -2147483648, -2147483648, 418417917, -1031969798, -1106983592, '5bbp0', 743312762, 825.231787, -1822992503, 'liqa1', 2074205376, 274769912, -188151580, 't1__9eddbd', 'hl72klex1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, -2147483648, -453362185, 481163439, 2123196517, 'dwyrq13pyu78', 244829661, 182.777264, -904834265, 'b4yp5qi', -227162283, 2056419640, 222415430, '1', 'x58pz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, -2147483648, -2147483648, 894242932, -211209314, -1056308489, 'gcb98oz', 1443629118, 463.845085, 1686459626, 'lyr', 1038566008, 32204797, -1672720816, 't1__9eddbd', '8j', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 1, -2147483648, -2147483648, -1388029300, -566887085, 602161869, 'xa', 1294666887, 379.883722, 1427161052, 'z16ni', 2011234363, -1483100200, -7597509, 't1__df0046', 'h5ogrgjd8yz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, -2147483648, -2147483648, -1794176801, -1194675273, -946046410, 'tsj3ayxp1q4', -1538707438, 774.445116, -163600466, 'n8', 195720193, 1774087382, 1732258051, '1', 'afu5w1of7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 1, -2147483648, -2147483648, 1992637800, -820614248, 481546706, 'g6', -242584410, 415.494881, -698610044, 'q8qdjpe1io22', 2004147439, -691774480, -1523347137, '1', 'ttg6bnou5zi3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, -2147483648, -2147483648, -95808609, -244633520, 418247369, 'jla', 1919033056, 904.028668, -1428186898, 'uttmu2ne5', -1402164108, 2123471885, -526633767, 't1__9eddbd', 'zzbe8yvkv', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, -2147483648, -2147483648, 79330142, 1735561423, 756202403, '8b4pmaus3au', -699574669, 160.717227, 274891948, 'pdjwzw5chn9', 101754718, 628082526, -1245584612, '1', 'xfo', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, -2147483648, 2015094998, 1010672881, -1197954156, '0', 375841374, 162.575651, -225238282, 'w', 440115543, 292557306, 709097796, 't1__9eddbd', 'lwyng', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 1, -2147483648, -2147483648, 453340472, 211603887, -413043724, 'k1yoeyo6l0h', -1942581013, 506.13059, -795975227, 'xuzkb52', -277407746, -670154354, -2140468103, '1', 'elboeowii', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 1, -2147483648, -2147483648, -1552469358, 7342822, -1034034171, 'lyotow', 205676091, 735.218284, -2094843966, '96', 1044710644, 966412849, -2061634386, 't1__9eddbd', 'bindz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, -2147483648, -2147483648, 1376887048, 261633665, 748154000, 'cgumbc', 1295379066, 749.454983, 40558455, 'vzxw1rxe', -505019168, 1968783602, 125495479, '1', '162', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, -2147483648, -2147483648, 789756515, -1160642134, 769234989, '8ftp6ewtqx', 2013745856, 2.747847, 917362079, 'mzn2mfx', 1243701948, -156175571, 1220047834, 't1__9eddbd', '6sto1cj8sh5k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 3, -2147483648, -2147483648, 1487347213, 1328948152, -1923069176, 'jmgjach8qt', 620355627, 839.760651, -531872415, '1', 339193890, -493230039, -2081662466, '1', '3qdpu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, -2147483648, -2147483648, 1139012231, -951706262, -1324935647, 'wlic7dn2np', -384749431, 55.861048, -934098178, 'gelcu', 422046500, -1750715330, 277649518, 't1__9eddbd', 'cukjq1quik1y', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, -2147483648, -2147483648, 166124233, 1862197286, 1040753276, 'pqomizt', 1793241362, 17.438617, -1304516770, 'z78', -2128972904, -1043357093, -753065777, '1', 'ftb8r9114', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, -2147483648, -2147483648, -1537647691, 364280973, 1592061050, 'sj8kjh', 1138926079, 358.01048, 486475144, 'vrisurz0ka', 1384307628, 1388796595, -881085433, 't1__9eddbd', '7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 1, -2147483648, -2147483648, -2070247503, -1629148699, 103252327, 'ar50hs', -1515201134, 5.946198, 1195320303, 'dpunmw', -1782325492, -544173163, -958321297, '1', 'w', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, 1, -2147483648, -2147483648, 572453185, 1348973408, -911953404, '97', -2098439423, 392.952848, -1148194959, 'pj6ddly', 1813965704, 719861381, 1193656937, 't1__9eddbd', 'phdku2gir31v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 3, -2147483648, -2147483648, -299585625, -2014514218, -1184608964, 'pavcvwn', 1971816668, 251.461344, 1491006943, 'lrpou', 1368469085, 3208964, -471198540, '1', 'mjwpp2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, -2147483648, -2147483648, 960696718, 1663074182, -352678633, 'r133ir1a', -569461411, 379.844141, 1498496406, 'l2i9', -1837449583, 1299933788, 679285124, 't1__9eddbd', 'k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 1, -2147483648, -2147483648, 1339281953, -69263912, 17776256, 'ekt', -1892701926, 211.896872, -460035045, '3rjkwns47j2j', -1881008758, -1955129162, -1015337060, '1', 'yrnxs6dvd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, -2147483648, -2147483648, 1805923837, -699779308, -1368221491, 'fjvuun7k1', -251621840, 887.571765, -1720233199, '1rgeza', 423028705, -316078323, -754769711, 't1__9eddbd', 'ly', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 1, -2147483648, -2147483648, -563920971, 1484825817, 1009703228, '19cy7od', 693108667, 457.405588, -1882121644, 'hdsvnhed29lq', -159572656, 1991810359, -1125491025, '1', 'pw30bgwkxgi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 1, -2147483648, -2147483648, -1318740197, -306339789, -177551902, '162', 950497469, 14.163977, -1722214030, 'ev', -582813835, -572986964, 387548943, 't1__9eddbd', 'kuboe8cde', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 3, -2147483648, -2147483648, -1417040770, 858308694, 625191846, 'w', 1868665501, 58.4493, 1104707112, '0eduy9', -699425950, -432771718, 516500236, '1', '835xoepac', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 1, -2147483648, -2147483648, -344881050, -537413388, 2011754567, 'et8xjhcf46c', 312333412, 702.984684, -977983676, '6', -329270684, -1517724233, -1265768652, 't1__9eddbd', 'ddrokuez', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 1, -2147483648, -2147483648, 2006256976, 660144343, -169414942, 'mvb7vpc0xffw', 1983060779, 271.763231, 1202197697, 'ksf9q', -213453775, -1721445347, -314024594, '1', 'ij7f8k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 3, -2147483648, -2147483648, -1728059226, 1652765764, 854201197, 'lsa', -924570154, 476.853022, -635922435, 'hl7j43y7', 209963559, -480726958, 191797158, 't1__9eddbd', 'r3w', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, -2147483648, -2147483648, -561387633, -1496507520, 2062713020, 'gmukfb5if4', 143843552, 752.638633, -1819463450, 'f', 1176294340, -1429883874, -1844939963, '1', 'sltut6lu2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 3, -2147483648, -2147483648, 1995395561, -1550947002, 858757143, 'enii0fmb', 1859885644, 494.754011, -1023455371, '27xh8', 1875923360, -286884572, 2132634715, 't1__9eddbd', '53sb59ls1e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, -2147483648, -2147483648, 1134827548, 320743233, -1016026459, 'yy', -422857559, 856.229597, -105243240, 'nnw4', 355299538, -343271949, -619134105, '1', 'k0b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, -2147483648, -2147483648, 1022316699, -1519375860, -1398612932, 'lzh42', -1241530177, 141.090523, 411661379, 'i5m', 1253306312, 1070662443, 683746439, 't1__9eddbd', '38gfxswb2d0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 3, -2147483648, -2147483648, -613511812, 1705750528, 1769687183, 'p5qo1', 749598659, 772.856748, 902707245, 'kd4k', 825979697, -1565247126, -419727501, '1', '90nhsp9gobb6', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 1, -2147483648, -2147483648, 1774110337, -1099209475, -478462425, 'aayv', 754506713, 383.561972, -895541641, '0fs3q', -1271681267, 355859046, -1500616, 't1__9eddbd', 'rlxcrwfx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, -2147483648, -1684242660, 145428926, 624911807, 'qme2wb1b3vu', 795347051, 502.32467, 61145737, 'imolt07', 354693690, 399119867, 207340898, '1', '50q8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, -2147483648, -43429869, -1887578409, 498429250, 'ew092p', -115832402, 968.222028, 2074088791, 'vil21xsa', -49162316, -1580770288, -1158897957, '1', 'uy023lwh99', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 3, -2147483648, -2147483648, 1981331984, -561057335, 1072042049, 'xd4s', -1531362377, 849.088145, -1580370971, 'wnd6dvygw', -2083332040, -1732139002, 104130853, 't1__9eddbd', 'y3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, -2147483648, -2147483648, -1567310198, 1484560348, 373735911, 'qx6j6d4', 1950702818, 704.233498, 109383153, '4s2a', -1532823638, -755912743, 46301377, '1', 'j90tef', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 1, -2147483648, -2147483648, -1063799979, 1585107626, 1885635119, 'qzabivuum', -670250982, 523.725702, -2091687257, '0jw', -1674574732, 1874367397, 1342717090, 't1__9eddbd', 'fzrv1ll', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 3, -2147483648, -2147483648, -693758664, 2045017461, 513178845, '6n0', 355372240, 175.259612, 641545472, 'xeeinmbciv5', -1191120749, 2110758629, 764470079, '1', 'v3r3u', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 1, -2147483648, -2147483648, -390950704, 858882953, 1930622140, 'mjrssbh72404', 1550708132, 460.92401, -383974656, '1', -1232267276, -1034606204, 359389091, 't1__9eddbd', 'w', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 3, -2147483648, -2147483648, -384734946, 1690470489, -1965798280, '1c8', 1951564466, 332.024179, -1908930700, 'p0760ugk2h', 287341380, -425575477, -1123211891, 't1__9eddbd', 'lcg9a4g', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483605, 1, -2147483648, -2147483648, 371075029, -644805902, 1292525363, 'tqhjd5ma', -2058646672, 697.875635, -976424792, 'tzdlb6i422te', 1549626896, -29153411, 1707379853, '1', '9dwt1havc2c4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 1, -2147483648, -2147483648, -1857994268, -1501533097, -106120329, 't99kvnbh', -681931530, 503.140593, -1082755849, 'fndtw', 232457376, 782631880, -131110552, 't1__9eddbd', 'fiof8o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, 3, -2147483648, -2147483648, -1022360195, -1517836823, -2124619836, 'fhj8zr6k53', 376872332, 494.491571, -1799118529, 'f1ur8kz', 903854855, -1701090371, -1531116262, '1', '7fznqcuex', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483602, 1, -2147483648, -2147483648, -2006745200, -1815891316, -758991421, 'vdb', 1337608681, 665.243078, -1664812348, '3o', -508328860, 638054085, -1585881270, 't1__9eddbd', 'ly46upl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483601, 3, -2147483648, -2147483648, 410371541, -1497850316, 1616702542, '11y', 1685354754, 249.359688, -455334817, '7xrv4pmpjj', -705547449, 1806134886, -266037807, 't1__9eddbd', 'rn6j72vkweg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483600, 1, -2147483648, -2147483648, -1256487758, 1220359260, 1847668366, 'pbgwojnh', -679517978, 950.070484, 1213984698, 'dx5hn', 67983002, -171251505, -1142502602, '1', 'zbgyxt0tw', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483599, 1, -2147483648, -2147483648, 823950453, -20815215, -116159477, '1q9w43ial8s8', -215535291, 240.15456, 1229352231, '9fodt9kcq2ia', -2093375165, 1733360461, 29713329, 't1__9eddbd', 'k8qazkjyfxso', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483598, 1, -2147483648, -2147483648, 1633213040, -56395913, 2039485050, 'p3q', 127564856, 367.275481, -1716375595, '24vu6v8', 1646694792, 1349767879, 1277665386, '1', 'u8yb4qp', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483597, 1, -2147483648, -2147483648, -1919962183, 366905309, 1391466884, 'hwhlh5i1dt', 1718452961, 198.109922, 2109623518, 'lhw6lv7j4', -209713762, -270252656, -1027442241, NULL, 'uw42p20g', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483596, 1, -2147483648, -2147483648, -1625071271, 1991996064, -913925363, 'e6hvzbo', -1186198336, 185.139354, 22415446, 'sijufc2vfgh', 1608670538, 2113178098, -2074048065, NULL, 'xi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 4, -2147483648, -2147483648, -1377057208, -841692980, -1364429300, 'nprmdposii', -1823627488, 327.753528, -1209887326, 'klfa9000t', 1408123494, -1964997180, 1149850321, 'e', '76nium52', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T2.name FROM races AS T2 INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN results AS T1 ON T2.raceId = T1.raceId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
*/

-- Prediction Query
SELECT races.name FROM races INNER JOIN lapTimes ON races.raceId = lapTimes.raceId WHERE races.name = 'Austrian Grand Prix' ORDER BY lapTimes.time ASC, races.raceid NULLS LAST, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 1;

/*
Prediction Result:
*/