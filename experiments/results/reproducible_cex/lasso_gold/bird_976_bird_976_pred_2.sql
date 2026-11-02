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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2329, 'final', 'Teresa Jones', '569 Rios Turnpike
Toddhaven, MP 72389', 'Benin', 2337.5, 2345.5, 2353, 'http://smith.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2330, 'live', 'Judith Miller', '242 Perez Landing Suite 025
Stephenburgh, RI 21576', 'Cambodia', 2350.5, 2360.5, 2370.0, 'https://www.murray.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2331, 'pressure', 'Donna Frye', '22231 Victoria Ports Apt. 745
East Anna, AZ 87736', 'Cote d''Ivoire', 2363.5, 2375.5, 2387.0, 'http://spencer-williams.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2332, 'hold', 'Donald Terry', '57828 Martinez Burg Suite 727
Ericside, NY 43922', 'Gabon', 2376.5, 2390.5, 2404.0, 'https://singh.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2333, 'such', 'Shaun Meyer DDS', '4929 Morgan Creek Suite 028
West Angelbury, NV 47345', 'Lebanon', 2389.5, 2405.5, 2421.0, 'https://flowers.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2334, 'report', 'Wayne Weaver', '398 Kimberly Trafficway
Jamesland, ND 58888', 'Trinidad and Tobago', 2402.5, 2420.5, 2438.0, 'https://www.knox-newman.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2335, 'young', 'Gregory Wallace', '637 Morrison Pass
Lake Michaelberg, VT 56552', 'Malta', 2415.5, 2435.5, 2455.0, 'http://gamble-jones.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2336, 'room', 'Dorothy Brown', '45547 Jason Mills Suite 742
Chandlerchester, DC 77463', 'Grenada', 2428.5, 2450.5, 2472.0, 'https://burton-alvarez.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2424, 'affect', 'James Stevens', 'Unit 5009 Box 0255
DPO AP 77042', 'Isle of Man', 2432.5, 2440.5, 2448, 'http://www.sanchez.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2425, 'almost', 'Justin Dalton', '1655 Bell Shore Apt. 334
Lake Cameronport, DE 44750', 'Ethiopia', 2445.5, 2455.5, 2465.0, 'https://lucas-johnson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2426, 'law', 'Michael Henry', '76986 Smith Mountains Apt. 569
Morrisville, AS 64511', 'France', 2458.5, 2470.5, 2482.0, 'https://www.green.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2427, 'up', 'Mike Freeman', '7852 Cox Mews
South Cynthia, WY 10373', 'Oman', 2471.5, 2485.5, 2499.0, 'http://www.tucker.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2428, 'who', 'Michael Keller', '4049 Ballard Road
Lake Meganville, OR 44651', 'Central African Republic', 2484.5, 2500.5, 2516.0, 'https://lester.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2429, 'by', 'Laura Alvarez', '3514 Reynolds Plains Suite 366
Colleenmouth, TN 72271', 'Equatorial Guinea', 2497.5, 2515.5, 2533.0, 'http://cameron.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2430, 'identify', 'Katie Myers', '829 Lewis View
Adamsside, AS 81034', 'Poland', 2510.5, 2530.5, 2550.0, 'http://wilkerson-young.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2431, 'listen', 'Wesley Jensen MD', '083 Ford Garden Apt. 466
Michelleland, SC 27181', 'Brazil', 2523.5, 2545.5, 2567.0, 'https://mclaughlin.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2361, 'hour', 2369, 'party', 'Isaac Fields', 'Campbell', '1994-08-21', 'South Africa', 'http://moon-wilson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2362, 'music', 2376.0, 'article', 'Amber Carter', 'Maxwell', '1994-08-22', 'Ukraine', 'http://collins-cox.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2363, 'significant', 2383.0, 'child', 'Angela Lee', 'Jenkins', '1994-08-23', 'Nicaragua', 'https://www.torres.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2364, 'parent', 2390.0, 'front', 'Pamela George', 'Mccall', '1994-08-24', 'Portugal', 'http://www.martinez-anderson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2365, 'adult', 2397.0, 'unit', 'Frank Stewart', 'Martin', '1994-08-25', 'Switzerland', 'https://www.smith.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2366, 'through', 2404.0, 'central', 'Rebecca Nelson', 'Robinson', '1994-08-26', 'Zambia', 'http://www.johnson.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2367, 'event', 2411.0, 'heavy', 'Heidi Ferguson', 'Gordon', '1994-08-27', 'Tanzania', 'http://kerr.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2368, 'commercial', 2418.0, 'common', 'Charles Taylor', 'Decker', '1994-08-28', 'Martinique', 'https://www.patton.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2456, 'discover', 2464, 'environmental', 'Emily Coleman', 'Martinez', '1981-02-14', 'Bermuda', 'https://hill.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2457, 'charge', 2471.0, 'travel', 'Tracey Suarez', 'Camacho', '1981-02-15', 'Vietnam', 'https://love-mcdowell.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2458, 'both', 2478.0, 'perform', 'Heidi Baldwin', 'Mathews', '1981-02-16', 'Saudi Arabia', 'http://jones.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2459, 'continue', 2485.0, 'arrive', 'Alisha Rasmussen', 'Price', '1981-02-17', 'French Southern Territories', 'https://johnson.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2460, 'difficult', 2492.0, 'military', 'Sarah Bates', 'Browning', '1981-02-18', 'Tuvalu', 'http://www.gonzalez-torres.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2461, 'face', 2499.0, 'none', 'Melissa Mccormick', 'Long', '1981-02-19', 'United States Virgin Islands', 'http://www.wright.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2462, 'less', 2506.0, 'house', 'Juan Parker', 'Spence', '1981-02-20', 'Kazakhstan', 'https://mendoza-moss.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2463, 'issue', 2513.0, 'scene', 'Heidi Burnett', 'Scott', '1981-02-21', 'Norfolk Island', 'http://gonzalez-perry.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2377, 'http://www.bell.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2378, 'https://wyatt.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2379, 'http://www.weiss.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2380, 'http://www.jackson-webster.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2381, 'http://www.york.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2382, 'https://www.davenport.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (2383, 'http://www.rodriguez-rollins.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2384, 'https://www.taylor.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2472, 'https://walker.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2473, 'http://www.gonzalez-haynes.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2474, 'http://patterson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2475, 'http://www.higgins.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2476, 'https://www.reeves.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2477, 'https://anderson-gates.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2478, 'http://byrd.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2479, 'http://young-hayes.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2385, 2377, 2393, 2329, 'Angela Snyder', '1973-05-06', 'indicate', 'http://www.hester-morgan.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2386, 2378, 2400.0, 2330, 'Jesus Fitzgerald', '1973-05-07', 'institution', 'https://www.massey.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2387, 2379, 2407.0, 2331, 'Sarah Perez', '1973-05-08', 'run', 'https://harding.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2388, 2380, 2414.0, 2332, 'William Patterson', '1973-05-09', 'performance', 'https://tate.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2389, 2381, 2421.0, 2333, 'Stephanie Lang', '1973-05-10', 'blue', 'https://hall-dunlap.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2390, 2382, 2428.0, 2334, 'Holly Smith', '1973-05-11', 'site', 'http://www.jimenez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2391, 2383, 2435.0, 2335, 'Megan Sanders', '1973-05-12', 'wish', 'https://turner.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2392, 2384, 2442.0, 2336, 'Megan Wilson', '1973-05-13', 'wait', 'http://harris-bates.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2480, 2472, 2488, 2424, 'Michael Ellis', '1989-10-22', 'president', 'http://gordon.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2481, 2473, 2495.0, 2425, 'Casey Morris', '1989-10-23', 'I', 'http://www.page-hamilton.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2482, 2474, 2502.0, 2426, 'Melissa Reeves', '1989-10-24', 'five', 'http://good.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2483, 2475, 2509.0, 2427, 'Nancy Scott', '1989-10-25', 'remain', 'https://orr-baker.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2484, 2476, 2516.0, 2428, 'Anthony Cook', '1989-10-26', 'hospital', 'https://stewart.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2485, 2477, 2523.0, 2429, 'Terry Barajas', '1989-10-27', 'cause', 'https://www.hernandez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2486, 2478, 2530.0, 2430, 'Tracy George', '1989-10-28', 'operation', 'http://martin-mcdonald.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2487, 2479, 2537.0, 2431, 'Amber King', '1989-10-29', 'partner', 'https://www.kelly-fletcher.info/');
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2385, 2361, 1, 2408, 'mother', 2416);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2386, 2362, 2401, 2417.0, 'every', 2429.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2387, 2363, 2402, 2426.0, 'occur', 2442.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2388, 2364, 2403, 2435.0, 'gun', 2455.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2389, 2365, 2404, 2444.0, 'table', 2468.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2390, 2366, 2405, 2453.0, 'trade', 2481.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2391, 2367, 2406, 2462.0, 'now', 2494.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2392, 2368, 2407, 2471.0, 'office', 2507.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2480, 2456, 1, 2503, NULL, 2511);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2481, 2457, 2496, 2512.0, 'mind', 2524.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2482, 2458, 2497, 2521.0, 'service', 2537.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2483, 2459, 2498, 2530.0, 'trial', 2550.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2484, 2460, 2499, 2539.0, 'choose', 2563.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2485, 2461, 2500, 2548.0, 'candidate', 2576.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2486, 2462, 2501, 2557.0, 'happy', 2589.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2487, 2463, 2502, 2566.0, 'better', 2602.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT driverId FROM lapTimes WHERE lap = 1 ORDER BY time, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 5;

/*
Gold Result:
(2456,)
(2361,)
*/

-- Prediction Query
SELECT t1.driverid FROM laptimes AS t1 INNER JOIN (SELECT driverid, MIN(time) AS min_time FROM laptimes WHERE lap = 1 GROUP BY driverid) AS t2 ON t1.driverid = t2.driverid AND t1.time = t2.min_time WHERE t1.lap = 1 ORDER BY t2.min_time ASC, t1.raceid NULLS LAST, t1.driverid NULLS LAST, t1.lap NULLS LAST LIMIT 5;

/*
Prediction Result:
(2361,)
*/