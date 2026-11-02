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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3661, 'really', 'Summer Carter', '03243 Carrie Forge
Joshuachester, CA 72570', 'British Virgin Islands', 3665.5, 3669.5, 3673, 'https://rice.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3662, 'a', 'Brenda Henry', '267 Shirley Springs Suite 283
Lake Jessicaborough, VT 49278', 'China', 3678.5, 3684.5, 3690.0, 'https://garcia.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3663, 'first', 'Thomas Shea', '2566 Tamara Gateway
West Davidville, TX 72376', 'Malta', 3691.5, 3699.5, 3707.0, 'http://byrd.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3664, 'young', 'Kayla Watts', '155 Thomas Union Apt. 401
Pettybury, MS 14263', 'Saint Lucia', 3704.5, 3714.5, 3724.0, 'https://www.smith-palmer.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3744, 'top', 'Carlos Johnson', '86041 Cox Keys Suite 350
North Aaron, TN 98117', 'Lebanon', 3748.5, 3752.5, 3756, 'http://www.pierce-king.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3745, 'perhaps', 'Tanya Simmons DDS', '4916 Johnny Overpass Suite 541
Lake Alexanderside, WI 17580', 'Senegal', 3761.5, 3767.5, 3773.0, 'https://soto-wilson.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3746, 'protect', 'Anthony Russell', '989 Allen Harbor Apt. 961
East Crystalville, AZ 77382', 'Saint Helena', 3774.5, 3782.5, 3790.0, 'http://mills-farley.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3747, 'church', 'Mark Hall', 'Unit 3371 Box 1895
DPO AA 95574', 'Aruba', 3787.5, 3797.5, 3807.0, 'http://ponce.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3677, 'card', 'Amy Swanson', 'Japan', 'https://www.russell-edwards.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3678, 'character', 'Michelle Wright', 'Saint Barthelemy', 'https://hayden.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3679, 'human', 'Michelle White', 'Turkmenistan', 'http://robertson-cuevas.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3680, 'out', 'Dr. Kathryn Hill', 'Denmark', 'http://jensen.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3760, 'rule', 'Joseph Palmer Jr.', 'Vanuatu', 'https://phillips.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3761, 'sit', 'Jordan Hart', 'Malaysia', 'http://www.williams.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3762, 'teacher', 'Lawrence Clark', 'Korea', 'http://www.ho-nelson.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3763, 'information', 'Kenneth Vargas', 'Macao', 'http://www.wilson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3682, 'send', 3685, 'cell', 'Anthony Cabrera', 'Palmer', '1998-08-11', 'Holy See (Vatican City State)', 'http://harris-soto.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3683, 'large', 3692.0, 'election', 'Lisa Oconnell', 'Farley', '1998-08-09', 'Bouvet Island (Bouvetoya)', 'http://leblanc.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3684, 'scientist', 3699.0, 'recently', 'Sierra Mills', 'Henderson', '1998-08-10', 'Guadeloupe', 'http://charles.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3764, 'nor', 3706.0, 'wife', 'Benjamin Franco', 'Gray', '1977-05-16', 'United States Minor Outlying Islands', 'https://rodriguez-bailey.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3681, 'your', 3686, 'hair', 'Shirley Rice', 'Rodriguez', '1998-08-11', 'Niue', 'http://www.evans-carter.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3765, 'season', 3775.0, 'water', 'Colleen Sanford', 'Reese', '1977-05-17', 'Micronesia', 'http://blair.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3766, 'usually', 3782.0, 'population', 'Wesley Medina', 'Reyes', '1977-05-18', 'Svalbard & Jan Mayen Islands', 'http://crawford.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3767, 'seven', 3789.0, 'financial', 'Paula Deleon', 'Valdez', '1977-05-19', 'Kenya', 'http://www.henry.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3689, 'https://garcia.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3690, 'http://www.martinez-freeman.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3691, 'https://www.foster-evans.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (3692, 'http://mayo.info/');
INSERT INTO "seasons" ("year", "url") VALUES (3772, 'https://www.roth.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3773, 'http://www.jones.info/');
INSERT INTO "seasons" ("year", "url") VALUES (3774, 'https://www.rose.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3775, 'http://smith-serrano.com/');
INSERT INTO "status" ("statusid", "status") VALUES (3693, 'challenge');
INSERT INTO "status" ("statusid", "status") VALUES (3694, 'health');
INSERT INTO "status" ("statusid", "status") VALUES (3695, 'small');
INSERT INTO "status" ("statusid", "status") VALUES (3696, 'her');
INSERT INTO "status" ("statusid", "status") VALUES (3776, 'cause');
INSERT INTO "status" ("statusid", "status") VALUES (3777, 'executive');
INSERT INTO "status" ("statusid", "status") VALUES (3778, 'product');
INSERT INTO "status" ("statusid", "status") VALUES (3779, 'add');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (872, 3689, 3700, 3661, 'Michelle Rodriguez', '1973-01-12', 'by', 'https://rodriguez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3697, 3689, 3707.0, 3661, 'Casey Fisher', '1973-01-13', 'mission', 'http://www.porter-saunders.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3698, 3689, 3714.0, 3661, 'Andre Wade', '1973-01-14', 'garden', 'http://bray-mclaughlin.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3699, 3689, 3721.0, 3661, 'Tina Bird', '1973-01-15', 'south', 'https://tucker-hodges.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3780, 3772, 3790.0, 3744, 'Sabrina Farrell', '1981-09-21', 'clear', 'https://www.tanner.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3781, 3772, 3797.0, 3744, 'Charles Malone', '1981-09-22', 'either', 'http://www.cruz-gomez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3782, 3772, 3804.0, 3744, 'Robin Parker', '1981-09-23', 'arrive', 'http://henson.com/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3704, 872, 3682, 3677, 3708, 3712, 3716, 'shoulder', 3720, 3724.5, 3728, 'fast', 3732, 3736, 3740, 'end', 'board', 3693);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3706, 872, 3682, 3677, 3719.0, 3725.0, 3731.0, 'much', 3739.0, 3745.5, 3751.0, 'treat', 3759.0, 3765.0, 3771.0, 'reflect', 'show', 3693);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3707, 872, 3682, 3677, 3730.0, 3738.0, 3746.0, 'culture', 3758.0, 3766.5, 3774.0, 'everyone', 3786.0, 3794.0, 3802.0, 'decide', 'morning', 3693);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3787, 872, 3682, 3677, 3741.0, 3751.0, 3761.0, 'enjoy', 3777.0, 3787.5, 3797.0, 'school', 3813.0, 3823.0, 3833.0, 'stay', 'popular', 3693);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3705, 872, 3681, 3760, 3791, 3795, 3799, 'break', 3803, 3807.5, 3811, 'heavy', 3815, 3819, 3823, 'wide', 'could', 3776);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3788, 872, 3681, 3760, 3802.0, 3808.0, 3814.0, 'door', 3822.0, 3828.5, 3834.0, 'ball', 3842.0, 3848.0, 3854.0, 'war', 'later', 3776);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3789, 872, 3681, 3760, 3813.0, 3821.0, 3829.0, 'blue', 3841.0, 3849.5, 3857.0, 'wind', 3869.0, 3877.0, 3885.0, 'animal', 'nice', 3776);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3790, 872, 3681, 3760, 3824.0, 3834.0, 3844.0, 'father', 3860.0, 3870.5, 3880.0, 'window', 3896.0, 3906.0, 3916.0, 'city', 'good', 3776);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 872 AND NOT T2.time IS NULL ORDER BY T1.dob DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('Shirley Rice', 'Rodriguez')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM results AS r JOIN drivers AS d ON r.driverId = d.driverId WHERE r.raceId = 872 AND NOT r.time IS NULL ORDER BY d.dob DESC, r.resultid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Anthony Cabrera', 'Palmer')
*/