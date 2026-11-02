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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2497, 'friend', 'Bailey Stewart', 'USNV Hernandez
FPO AE 14495', 'Iraq', 2501.5, 2505.5, 2509, 'https://carr-newton.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2498, 'author', 'Monica Cannon', '949 Caitlyn Fort
West Christopherfort, DC 66341', 'Singapore', 2514.5, 2520.5, 2526.0, 'http://www.bryant-rich.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2499, 'onto', 'Jennifer Jenkins', '526 Wells Estates Apt. 306
West Stephaniebury, WA 88494', 'Armenia', 2527.5, 2535.5, 2543.0, 'https://www.hughes.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2500, 'no', 'Timothy Shannon', 'Unit 3127 Box 9757
DPO AE 56541', 'New Caledonia', 2540.5, 2550.5, 2560.0, 'https://wilkerson-ayala.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2663, 'with', 'Andrew Webb', '71894 Rebecca Place
South Shawnfort, OK 96683', 'Saint Kitts and Nevis', 2667.5, 2671.5, 2675, 'https://www.baker.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2664, 'office', 'Kevin Nixon', '4209 Acosta Port Suite 079
New Brett, LA 97150', 'Northern Mariana Islands', 2680.5, 2686.5, 2692.0, 'https://alvarez-vaughan.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2665, 'part', 'Nicholas Fox', '1281 King Ridges Suite 440
New Gregshire, WA 20310', 'Chad', 2693.5, 2701.5, 2709.0, 'http://thornton.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2666, 'hit', 'Nicole Ramirez', '43728 Matthew Corner Apt. 927
Townsendbury, TN 58196', 'Cote d''Ivoire', 2706.5, 2716.5, 2726.0, 'http://reyes-stewart.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2513, 'main', 'Amy Black', 'Isle of Man', 'http://mosley.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2514, 'compare', 'Ronald Hayes', 'Gibraltar', 'https://wong.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2515, 'knowledge', 'Ashley Osborne', 'Korea', 'http://www.cole.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2516, 'financial', 'Melissa Taylor', 'Anguilla', 'http://james.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2679, 'result', 'Heather Richard', 'Dominican Republic', 'http://vaughn.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2680, 'analysis', 'Marissa Nelson', 'Saint Martin', 'http://www.davis-garcia.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2681, 'bill', 'Robert Scott', 'Peru', 'https://www.campbell.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2682, 'whose', 'Julia Leonard', 'Sierra Leone', 'http://www.little.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2517, 'try', 2521, 'commercial', 'Amber Parker', 'Jimenez', '1973-06-11', 'Cuba', 'https://miller-greene.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2518, 'receive', 2528.0, 'trouble', 'Tonya Roberts', 'Aguirre', '1973-06-12', 'Namibia', 'https://www.lopez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2519, 'travel', 2535.0, 'check', 'Steven Horne', 'Franklin', '1973-06-13', 'Palestinian Territory', 'http://www.estrada.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2520, 'citizen', 2542.0, 'country', 'Preston Smith', 'Snyder', '1973-06-14', 'Lebanon', 'https://www.rodriguez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2683, 'case', 2687, 'we', 'Stephanie Dominguez', 'Morris', '1989-11-04', 'Grenada', 'https://www.jones-krause.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2684, 'how', 2694.0, 'raise', 'John Mayer', 'Martin', '1989-11-05', 'Bahamas', 'https://www.vasquez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2685, 'realize', 2701.0, 'others', 'Tammy Hill', 'Waters', '1989-11-06', 'Eritrea', 'http://green.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2686, 'south', 2708.0, 'suggest', 'Steven Carrillo', 'Reyes', '1989-11-07', 'Zimbabwe', 'https://www.hernandez-bowman.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2525, 'https://www.curry-ward.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2526, 'http://richardson-gray.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2527, 'https://www.ruiz-martinez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2528, 'https://clark.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2691, 'https://graves.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2692, 'http://graham-anthony.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2693, 'http://www.finley-meyers.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2694, 'http://maldonado-morales.com/');
INSERT INTO "status" ("statusid", "status") VALUES (2529, 'show');
INSERT INTO "status" ("statusid", "status") VALUES (2530, 'professional');
INSERT INTO "status" ("statusid", "status") VALUES (2531, 'newspaper');
INSERT INTO "status" ("statusid", "status") VALUES (2532, 'begin');
INSERT INTO "status" ("statusid", "status") VALUES (2695, 'history');
INSERT INTO "status" ("statusid", "status") VALUES (2696, 'nor');
INSERT INTO "status" ("statusid", "status") VALUES (2697, 'tonight');
INSERT INTO "status" ("statusid", "status") VALUES (2698, 'grow');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (933, 2525, 2536, 2497, 'Mr. Timothy Andersen', '1977-10-15', 'project', 'http://www.roberts.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2533, 2525, 2543.0, 2497, 'Lee Stewart', '1977-10-16', 'modern', 'http://www.duarte.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2534, 2525, 2550.0, 2497, 'Whitney Gomez', '1977-10-17', 'mind', 'http://www.harris.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2535, 2525, 2557.0, 2497, 'Justin Stone', '1977-10-18', 'system', 'https://wilson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2746, 2691, 2702, 2663, 'Joe Miranda', '1993-04-08', 'become', 'http://www.lee.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2699, 2691, 2709.0, 2663, 'Cassandra Williams', '1993-04-09', 'value', 'http://brown-fernandez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2700, 2691, 2716.0, 2663, 'Connor Dominguez', '1993-04-10', 'left', 'https://johnson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2701, 2691, 2723.0, 2663, 'Lydia Howard', '1993-04-11', 'simple', 'http://lewis.net/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2540, 933, 2517, 2513, 2544, 2548, 2552, 'individual', 2556, 2560.5, 2564, 'air', 2568, 2572, 2576, 'give', 'remember', 2529);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2541, 933, 2517, 2513, 2555.0, 2561.0, 2567.0, 'shake', 2575.0, 2581.5, 2587.0, 'there', 2595.0, 2601.0, 2607.0, 'these', 'measure', 2529);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2542, 933, 2517, 2513, 2566.0, 2574.0, 2582.0, 'outside', 2594.0, 2602.5, 2610.0, 'continue', 2622.0, 2630.0, 2638.0, 'ground', 'whom', 2529);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2543, 933, 2517, 2513, 2577.0, 2587.0, 2597.0, 'power', 2613.0, 2623.5, 2633.0, 'daughter', 2649.0, 2659.0, 2669.0, 'win', 'matter', 2529);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2706, 933, 2683, 2679, 2710, 2714, 2718, 'low', 2722, 2726.5, 2730, 'two', 2734, 2738, 2742, NULL, 'particularly', 2695);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2707, 933, 2683, 2679, 2721.0, 2727.0, 2733.0, 'yard', 2741.0, 2747.5, 2753.0, 'not', 2761.0, 2767.0, 2773.0, NULL, 'early', 2695);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2708, 933, 2683, 2679, 2732.0, 2740.0, 2748.0, 'resource', 2760.0, 2768.5, 2776.0, 'church', 2788.0, 2796.0, 2804.0, NULL, 'wish', 2695);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2709, 933, 2683, 2679, 2743.0, 2753.0, 2763.0, 'truth', 2779.0, 2789.5, 2799.0, 'sit', 2815.0, 2825.0, 2835.0, NULL, 'away', 2695);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.nationality FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 933 AND NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapSpeed DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('Cuba',)
*/

-- Prediction Query
SELECT d.nationality FROM results AS r JOIN drivers AS d ON r.driverId = d.driverId WHERE r.raceId = 933 ORDER BY r.fastestLapSpeed DESC, r.resultid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Grenada',)
*/