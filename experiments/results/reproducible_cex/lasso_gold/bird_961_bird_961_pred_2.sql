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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2892, 'cause', 'Matthew Carter', '4924 Kristina Forks Suite 540
West Justin, GA 81586', 'United Arab Emirates', 2896.5, 2900.5, 2904, 'https://www.williamson-robinson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2893, 'matter', 'Shane Hall', 'PSC 8422, Box 2231
APO AE 42001', 'Philippines', 2909.5, 2915.5, 2921.0, 'http://franklin.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2894, 'hand', 'Maria Jenkins', '5238 Elizabeth Key Apt. 578
New Kevin, PW 03767', 'Micronesia', 2922.5, 2930.5, 2938.0, 'http://johnson.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2895, 'kitchen', 'Matthew Nguyen', '75208 Holland Hill Suite 492
Morganville, VA 63282', 'Brazil', 2935.5, 2945.5, 2955.0, 'http://henry.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2976, 'decision', 'Paul Ramirez', '2801 Samantha Vista
Richardsonshire, HI 58128', 'Saint Vincent and the Grenadines', 2980.5, 2984.5, 2988, 'https://www.gonzalez-anthony.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2977, 'religious', 'Heather Wyatt', '56638 Rick Trace
Davidville, NC 18315', 'Uganda', 2993.5, 2999.5, 3005.0, 'http://www.hardy-ramirez.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2978, 'air', 'Lisa Wagner', '480 Mark Crescent Suite 479
Gloriamouth, IN 73103', 'Chile', 3006.5, 3014.5, 3022.0, 'https://alvarez-morrison.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2979, 'believe', 'Robert Hines', '17520 Powers Locks Suite 811
South Richard, OR 13833', 'Bahrain', 3019.5, 3029.5, 3039.0, 'https://tate.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2908, 'much', 'Charles Nash', 'Kenya', 'https://houston.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2909, 'yet', 'Jake Mitchell', 'France', 'http://www.wells-dillon.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2910, 'arrive', 'William Sawyer', 'Central African Republic', 'http://smith.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2911, 'reflect', 'Nicholas Wallace', 'Sri Lanka', 'https://www.murray.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2992, 'enough', 'Brandy Garcia', 'Belarus', 'http://jimenez.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2993, 'might', 'Barry Gregory', 'Panama', 'http://www.beard-wilson.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2994, 'modern', 'Janet Shelton', 'Somalia', 'https://stevens-johnson.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2995, 'during', 'Marco Davis', 'Lao People''s Democratic Republic', 'https://www.jordan-edwards.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2912, 'I', 2916, 'test', 'Justin Ford', 'Vasquez', '1977-06-21', 'Lithuania', 'https://graham.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2913, 'figure', 2923.0, 'the', 'Aaron Baker', 'Watts', '1977-06-22', 'Bangladesh', 'https://www.martin-brown.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2914, 'once', 2930.0, 'they', 'Sandra Kennedy', 'Sanchez', '1977-06-23', 'Netherlands Antilles', 'https://www.martin-nelson.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2915, 'military', 2937.0, 'pay', 'Stephanie Butler', 'Wilson', '1977-06-24', 'Samoa', 'https://www.carter-fowler.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2996, 'method', 3000, 'notice', 'Katie Myers', 'Harmon', '1985-03-06', 'Guinea-Bissau', 'http://www.collins.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2997, 'break', 3007.0, 'owner', 'Wesley Jensen MD', 'Vance', '1985-03-07', 'Isle of Man', 'https://robertson.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2998, 'outside', 3014.0, 'many', 'Erica Johnson', 'Peterson', '1985-03-08', 'Azerbaijan', 'http://hudson-morris.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2999, 'Republican', 3021.0, 'or', 'Russell Bailey', 'Davis', '1985-03-09', 'Ecuador', 'https://www.leonard.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2920, 'http://www.george.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2921, 'https://marsh.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2922, 'https://peterson-bartlett.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2923, 'http://www.walker.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3004, 'http://montes-harris.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3005, 'http://williams-davies.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (3006, 'http://www.richard.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3007, 'https://reed.com/');
INSERT INTO "status" ("statusid", "status") VALUES (2924, 'road');
INSERT INTO "status" ("statusid", "status") VALUES (2925, 'theory');
INSERT INTO "status" ("statusid", "status") VALUES (2926, 'never');
INSERT INTO "status" ("statusid", "status") VALUES (2927, 'night');
INSERT INTO "status" ("statusid", "status") VALUES (3008, 'mother');
INSERT INTO "status" ("statusid", "status") VALUES (3009, 'summer');
INSERT INTO "status" ("statusid", "status") VALUES (3010, 'lead');
INSERT INTO "status" ("statusid", "status") VALUES (3011, 'record');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2929, 2920, 2932, 2892, 'Christina Morales', '1981-10-02', 'picture', 'http://garner.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2930, 2920, 2939.0, 2892, 'Thomas Wilson', '1981-10-03', 'necessary', 'http://www.perez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2931, 2920, 2946.0, 2892, 'Alan Bailey', '1981-10-04', 'source', 'https://www.smith.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3012, 2920, 2953.0, 2892, 'Brenda Ramos', '1981-10-05', 'guess', 'http://www.johnson.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2928, 3004, 2933, 2976, 'Michaela Lang', '1989-07-10', 'than', 'https://www.gonzalez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3013, 3004, 3023.0, 2976, 'Jody Hines', '1989-07-11', 'situation', 'https://dalton-pruitt.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3014, 3004, 3030.0, 2976, 'Albert Warner', '1989-07-12', 'manage', 'https://lucas-scott.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3015, 3004, 3037.0, 2976, 'Laura Lewis', '1989-07-13', 'executive', 'http://wilson.com/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2936, 2929, 2912, 2908, 2940, 2944, 2948, 'personal', 2952, 2956.5, 2960, 'environment', 2964, 2968, 2972, 'action', 'candidate', 2924);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2938, 2929, 2912, 2908, 2951.0, 2957.0, 2963.0, 'artist', 2971.0, 2977.5, 2983.0, 'animal', 2991.0, 2997.0, 3003.0, 'somebody', 'wife', 2924);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2939, 2929, 2912, 2908, 2962.0, 2970.0, 2978.0, 'manager', 2990.0, 2998.5, 3006.0, 'fish', 3018.0, 3026.0, 3034.0, 'big', 'play', 2924);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3020, 2929, 2912, 2908, 2973.0, 2983.0, 2993.0, 'by', 3009.0, 3019.5, 3029.0, 'region', 3045.0, 3055.0, 3065.0, 'stay', 'describe', 2924);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2937, 2928, 2996, 2992, 3024, 3028, 3032, 'else', 3036, 3040.5, 3044, 'majority', 2964, 3052, 3056, 'knowledge', 'explain', 3008);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3021, 2928, 2996, 2992, 3035.0, 3041.0, 3047.0, 'subject', 3055.0, 3061.5, 3067.0, 'mention', 3075.0, 3081.0, 3087.0, 'radio', 'century', 3008);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3022, 2928, 2996, 2992, 3046.0, 3054.0, 3062.0, 'their', 3074.0, 3082.5, 3090.0, 'opportunity', 3102.0, 3110.0, 3118.0, 'defense', 'evening', 3008);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3023, 2928, 2996, 2992, 3057.0, 3067.0, 3077.0, 'force', 3093.0, 3103.5, 3113.0, 'least', 3129.0, 3139.0, 3149.0, 'collection', 'fall', 3008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.year FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE NOT T2.milliseconds IS NULL ORDER BY T2.milliseconds, T1.raceid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('Michaela Lang', 3004)
*/

-- Prediction Query
SELECT T2.name, T2.year FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.milliseconds IS NULL ORDER BY T1.milliseconds ASC, T1.resultid NULLS LAST, T2.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Christina Morales', 2920)
*/