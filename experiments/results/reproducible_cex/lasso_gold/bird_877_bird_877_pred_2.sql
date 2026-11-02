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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3743, 'bad', 'Nicholas Mayo', 'Unit 5716 Box 1768
DPO AP 03368', 'Egypt', 3747.5, 3751.5, 3755, 'https://miller-thornton.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3744, 'year', 'Nathan Williams', '240 Laura Square Apt. 678
East Samuelhaven, MS 74228', 'Swaziland', 3760.5, 3766.5, 3772.0, 'https://www.villanueva-phillips.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3745, 'office', 'Joshua King', '432 Ernest Forge Apt. 878
Kevinbury, LA 93333', 'Martinique', 3773.5, 3781.5, 3789.0, 'http://cross.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3746, 'present', 'Sarah Meadows', '30834 Danielle Harbors
West Morgan, AR 84703', 'Afghanistan', 3786.5, 3796.5, 3806.0, 'https://www.sandoval.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3826, 'their', 'Victor Padilla', '13109 Hernandez Falls Suite 284
Jenkinsmouth, NV 85022', 'Botswana', 3830.5, 3834.5, 3838, 'https://www.campbell.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3827, 'door', 'Alexander Hanna', '20092 Alex Village Suite 784
Jennachester, GA 36129', 'Bosnia and Herzegovina', 3843.5, 3849.5, 3855.0, 'http://www.miller-hudson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3828, 'arrive', 'Michael Bates', 'Unit 8623 Box 6903
DPO AA 24578', 'Belarus', 3856.5, 3864.5, 3872.0, 'https://www.edwards.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3829, 'skin', 'Ryan Harrell', '775 Wilcox Expressway
Port Nathanchester, ID 35879', 'Guyana', 3869.5, 3879.5, 3889.0, 'https://porter-edwards.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3759, 'skill', 'Christine Ramos', 'Bermuda', 'http://www.henry.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3760, 'even', 'Damon Soto', 'Lithuania', 'https://www.roth.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3761, 'true', 'Jennifer Griffin', 'Kuwait', 'http://www.jones.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3762, 'protect', 'Jessica Hernandez', 'Tokelau', 'https://www.rose.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3842, 'she', 'Erin Mosley', 'Pitcairn Islands', 'http://www.aguirre.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3843, 'heart', 'Kathryn Hampton', 'Kyrgyz Republic', 'http://floyd-morgan.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3844, 'carry', 'Robert Woods', 'Belgium', 'https://www.schroeder.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3845, 'scientist', 'Amanda Martin', 'Turks and Caicos Islands', 'http://www.burton.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3764, 'black', 3767, 'then', 'Candice Ramirez', 'Malone', '1985-02-04', 'Cape Verde', 'http://hunt-weber.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3765, 'huge', 3774.0, 'quickly', 'Rebecca Smith', 'Stafford', '1977-05-17', 'Azerbaijan', 'https://www.barr.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3766, 'the', 3781.0, 'cause', 'Kimberly Meyers', 'Ochoa', '1977-05-18', 'Mayotte', 'https://gomez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3846, 'source', 3788.0, 'energy', 'Angela Taylor', 'Parker', '1977-05-19', 'Niue', 'https://www.jackson-rodriguez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3763, 'space', 3768, 'want', 'Debra Mays', 'Martinez', '1985-02-04', 'Ireland', 'http://www.garcia.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3847, 'officer', 3857.0, 'between', 'Brandon White', 'Carroll', '1985-02-02', 'Togo', 'https://www.gutierrez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3848, 'trip', 3864.0, 'former', 'Deanna Kennedy', 'Williams', '1985-02-03', 'Niger', 'http://www.nicholson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3849, 'station', 3871.0, 'condition', 'Shawn Santos', 'Trevino', '1977-05-16', 'United States Virgin Islands', 'https://www.ross.info/');
INSERT INTO "seasons" ("year", "url") VALUES (3771, 'https://gilbert.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3772, 'http://www.hernandez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3773, 'https://www.mcdaniel.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3774, 'https://wood.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3854, 'http://mcdonald-nichols.info/');
INSERT INTO "seasons" ("year", "url") VALUES (3855, 'http://www.dennis.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (3856, 'http://brown-peterson.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3857, 'https://www.figueroa.net/');
INSERT INTO "status" ("statusid", "status") VALUES (3775, 'story');
INSERT INTO "status" ("statusid", "status") VALUES (3776, 'able');
INSERT INTO "status" ("statusid", "status") VALUES (3777, 'training');
INSERT INTO "status" ("statusid", "status") VALUES (3778, 'worker');
INSERT INTO "status" ("statusid", "status") VALUES (3858, 'clearly');
INSERT INTO "status" ("statusid", "status") VALUES (3859, 'different');
INSERT INTO "status" ("statusid", "status") VALUES (3860, 'out');
INSERT INTO "status" ("statusid", "status") VALUES (3861, 'almost');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (872, 3771, 3782, 3743, 'Paula Thomas', '1981-09-20', 'future', 'https://steele-gutierrez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3779, 3771, 3789.0, 3743, 'Jeremy Robles', '1981-09-21', 'image', 'http://www.barnes-crawford.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3780, 3771, 3796.0, 3743, 'Robin Wilson', '1981-09-22', 'head', 'https://www.miller-espinoza.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3781, 3771, 3803.0, 3743, 'Nicholas Thomas', '1981-09-23', 'from', 'http://www.ward.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3862, 3854, 3872.0, 3826, 'Veronica Lewis', '1989-06-06', 'authority', 'https://www.bailey.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3863, 3854, 3879.0, 3826, 'Alexander Blake', '1989-06-07', 'interview', 'https://www.kim.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3864, 3854, 3886.0, 3826, 'David Thompson', '1989-06-08', 'beat', 'http://www.contreras.com/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3786, 872, 3764, 3759, 3790, 3794, 3798, 'open', 3802, 3806.5, 3810, 'time', 3814, 3818, 3822, 'financial', 'tonight', 3775);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3788, 872, 3764, 3759, 3801.0, 3807.0, 3813.0, 'matter', 3821.0, 3827.5, 3833.0, 'start', 3841.0, 3847.0, 3853.0, 'magazine', 'ok', 3775);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3789, 872, 3764, 3759, 3812.0, 3820.0, 3828.0, 'happy', 3840.0, 3848.5, 3856.0, 'tell', 3868.0, 3876.0, 3884.0, 'charge', 'word', 3775);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3869, 872, 3764, 3759, 3823.0, 3833.0, 3843.0, 'herself', 3859.0, 3869.5, 3879.0, 'chair', 3895.0, 3905.0, 3915.0, 'thing', 'eight', 3775);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3787, 872, 3763, 3842, 3873, 3877, 3881, 'address', 3885, 3889.5, 3893, 'choose', 3897, 3901, 3905, 'structure', 'little', 3858);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3870, 872, 3763, 3842, 3884.0, 3890.0, 3896.0, 'city', 3904.0, 3910.5, 3916.0, 'money', 3924.0, 3930.0, 3936.0, 'represent', 'tough', 3858);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3871, 872, 3763, 3842, 3895.0, 3903.0, 3911.0, 'low', 3923.0, 3931.5, 3939.0, 'free', 3951.0, 3959.0, 3967.0, 'everyone', 'car', 3858);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3872, 872, 3763, 3842, 3906.0, 3916.0, 3926.0, 'world', 3942.0, 3952.5, 3962.0, 'build', 3978.0, 3988.0, 3998.0, 'near', 'listen', 3858);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 872 AND NOT T2.time IS NULL ORDER BY T1.dob DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('Debra Mays', 'Martinez')
*/

-- Prediction Query
SELECT d.driverId, d.forename, d.surname, d.dob FROM results AS r JOIN drivers AS d ON r.driverId = d.driverId WHERE r.raceId = 872 AND NOT r.time IS NULL ORDER BY d.dob DESC, r.resultid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
(3764, 'Candice Ramirez', 'Malone', '1985-02-04')
*/