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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4094, 'run', 'Blake Mendez', '0405 James River
Ginashire, AZ 04516', 'Niger', 4102.5, 4110.5, 4118, 'https://www.oconnor.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4095, 'real', 'Mary Murray', '8255 King Pine
Murrayfurt, ID 18897', 'Ethiopia', 4115.5, 4125.5, 4135.0, 'https://www.kirk.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4096, 'let', 'Katherine Weaver', '32894 Greer Forges Apt. 891
Richardview, CO 90215', 'Canada', 4128.5, 4140.5, 4152.0, 'https://wu.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4097, 'benefit', 'Laura Kim', '85725 Jackson Ports Apt. 693
West Alyssa, WY 90473', 'Spain', 4141.5, 4155.5, 4169.0, 'https://sosa.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4098, 'line', 'Ryan Hood Jr.', '186 Diaz Rue
Stonefurt, PR 73728', 'Benin', 4154.5, 4170.5, 4186.0, 'https://ramos.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4099, 'world', 'Christina Gamble', '4430 Kristopher Road Apt. 891
South Carolburgh, AR 26603', 'Singapore', 4167.5, 4185.5, 4203.0, 'https://barry.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4100, 'power', 'Mason Flores', '340 Mary Fords Suite 415
Shawnmouth, GU 43461', 'Hungary', 4180.5, 4200.5, 4220.0, 'https://cobb-skinner.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4101, 'face', 'Jennifer Lopez', '259 Lisa Mountains
East Laurenmouth, PR 42092', 'Nauru', 4193.5, 4215.5, 4237.0, 'http://www.rubio-lozano.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4197, 'feeling', 'Elizabeth Brown', '6417 Rodney Canyon
New Connorstad, NV 14578', 'Oman', 4205.5, 4213.5, 4221, 'https://www.charles-sosa.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4198, 'enjoy', 'Michael Bolton', '150 Miller Pass
South Shawnbury, AR 61049', 'Kyrgyz Republic', 4218.5, 4228.5, 4238.0, 'http://www.williams-murray.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4199, 'artist', 'Jeffery Thompson', '04584 Evans Unions Suite 213
North Annetteburgh, MI 70190', 'Hong Kong', 4231.5, 4243.5, 4255.0, 'http://www.jenkins.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4200, 'him', 'John Rodriguez', '6694 Johnson Crest Apt. 533
Mooremouth, KS 57841', 'Bosnia and Herzegovina', 4244.5, 4258.5, 4272.0, 'https://www.acevedo.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4201, 'whatever', 'Danielle Hamilton', '15918 Mariah Squares Suite 000
Richardchester, CT 41212', 'Zimbabwe', 4257.5, 4273.5, 4289.0, 'https://www.waller.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4202, 'who', 'Justin Hammond', 'Unit 9011 Box 0797
DPO AP 61758', 'Djibouti', 4270.5, 4288.5, 4306.0, 'https://www.chang.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4203, 'special', 'Kayla Williams', '04938 Lori Port Suite 905
Lake Whitney, CA 42007', 'Switzerland', 4283.5, 4303.5, 4323.0, 'http://brooks.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4204, 'land', 'Thomas Sparks', '9980 Lucas Rapid
Noblefurt, WY 79944', 'Swaziland', 4296.5, 4318.5, 4340.0, 'http://williams.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4126, 'task', 'Tyler Anderson', 'Luxembourg', 'http://www.robinson.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4127, 'century', 'Sonya Wilcox', 'Portugal', 'http://www.martinez.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4128, 'among', 'Sheena Jones', 'Jamaica', 'http://burns-harris.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4129, 'food', 'Gerald Johnson', 'San Marino', 'https://patel.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4130, 'hotel', 'Mark Peters', 'Albania', 'http://buchanan.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4131, 'purpose', 'Brian Turner', 'Bulgaria', 'https://francis-cox.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4132, 'peace', 'Kelly Reyes', 'Chad', 'https://www.moore-duncan.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4133, 'unit', 'Whitney Henry', 'France', 'https://www.davis.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4229, 'them', 'Megan Garza', 'Peru', 'http://moore.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4230, 'couple', 'Lindsay Henderson', 'Micronesia', 'http://daniels-martinez.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4231, 'current', 'Brittany Barber', 'Venezuela', 'http://ross.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4232, 'physical', 'Tony Santiago', 'Palestinian Territory', 'https://www.foster-hernandez.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4233, 'interesting', 'Henry Reeves', 'Syrian Arab Republic', 'https://www.johnson-whitaker.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4234, 'south', 'Richard Tyler', 'Mayotte', 'https://www.lutz.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4235, 'coach', 'Henry Williams', 'Georgia', 'http://campos.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4236, 'much', 'Maria Thompson', 'Guadeloupe', 'https://www.lewis.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4134, 'idea', 4142, 'less', 'Lauren Lopez', 'Clarke', '1986-08-21', 'Grenada', 'https://rodriguez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4136, 'we', 4149.0, 'dinner', 'Alyssa White', 'Foley', '1986-08-22', 'Eritrea', 'http://www.hernandez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4137, 'really', 4156.0, 'decide', 'Tyler Browning', 'Fernandez', '1986-08-23', 'Morocco', 'http://daniel-barber.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4138, 'once', 4163.0, 'level', 'Jason Jackson', 'Case', '1986-08-24', 'Saint Barthelemy', 'http://www.ware.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4139, 'including', 4170.0, 'store', 'Jeffery Murphy', 'Adams', '1986-08-25', 'Tokelau', 'https://gordon.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4140, 'often', 4177.0, 'should', 'Angela Turner', 'Hardy', '1986-08-26', 'Greenland', 'https://young.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4141, 'trouble', 4184.0, 'director', 'Briana Mosley', 'Ford', '1986-08-27', 'Papua New Guinea', 'http://www.smith.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4237, 'court', 4191.0, 'with', 'Jack Brandt', 'Manning', '1986-08-28', 'Nepal', 'https://www.wyatt.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4135, 'a', 4245, 'family', 'Shelley Terry', 'Nelson', '1973-02-14', 'United States Virgin Islands', 'https://www.moreno-carpenter.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4238, 'animal', 4252.0, 'five', 'Richard Butler', 'Gutierrez', '1973-02-15', 'Greece', 'http://lutz-fleming.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4239, 'environmental', 4259.0, 'mission', 'Julie Yang', 'Abbott', '1973-02-16', 'Germany', 'https://jenkins-murphy.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4240, 'institution', 4266.0, 'everybody', 'Tara Jones', 'Garcia', '1973-02-17', 'Bouvet Island (Bouvetoya)', 'https://www.wilkins.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4241, 'state', 4273.0, 'practice', 'Melody Wheeler', 'Nguyen', '1973-02-18', 'Belgium', 'https://avila-morgan.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4242, 'themselves', 4280.0, 'bill', 'Kimberly Williams', 'Lopez', '1973-02-19', 'Russian Federation', 'https://oconnell-lee.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4243, 'school', 4287.0, 'laugh', 'Susan Smith', 'Bennett', '1973-02-20', 'Holy See (Vatican City State)', 'http://sanchez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4244, 'company', 4294.0, 'friend', 'Roy Thomas', 'Baker', '1973-02-21', 'Palau', 'https://dickerson.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (4150, 'https://www.wiggins.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4151, 'http://www.ray.org/');
INSERT INTO "seasons" ("year", "url") VALUES (4152, 'https://www.turner.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4153, 'http://www.morrow.info/');
INSERT INTO "seasons" ("year", "url") VALUES (4154, 'http://www.watkins.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4155, 'https://www.hernandez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4156, 'https://goodwin-taylor.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4157, 'http://www.reyes.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4253, 'https://www.smith.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (4254, 'http://www.thompson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4255, 'https://benson-wells.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (4256, 'http://jones.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4257, 'http://www.bartlett-christian.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4258, 'https://www.hodges.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4259, 'http://black.net/');
INSERT INTO "seasons" ("year", "url") VALUES (4260, 'https://www.griffin-gamble.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (18, 4150, 4165, 4094, 'Amanda Williamson', '1994-05-06', 'father', 'https://www.ortega.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4158, 4151, 4172.0, 4095, 'Chad Cooper', '1994-05-07', 'control', 'https://www.larsen.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4159, 4152, 4179.0, 4096, 'Kendra Kim', '1994-05-08', 'black', 'https://james.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4160, 4153, 4186.0, 4097, 'Timothy Francis', '1994-05-09', 'believe', 'http://maxwell.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4161, 4154, 4193.0, 4098, 'Edward Lee', '1994-05-10', 'strategy', 'http://www.novak.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4162, 4155, 4200.0, 4099, 'Daniel Smith', '1994-05-11', 'open', 'https://www.mcconnell-dunn.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4163, 4156, 4207.0, 4100, 'Matthew Ortega', '1994-05-12', 'indicate', 'https://farmer-anderson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4164, 4157, 4214.0, 4101, 'Joseph Hernandez', '1994-05-13', 'win', 'https://www.osborne.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4261, 4254, 4275.0, 4198, 'Charles Rodriguez', '1981-10-23', 'early', 'https://www.bruce.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4262, 4255, 4282.0, 4199, 'Damon King', '1981-10-24', 'most', 'http://www.michael.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4263, 4256, 4289.0, 4200, 'Stacey Peterson', '1981-10-25', 'garden', 'https://www.gonzales-ayala.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4264, 4257, 4296.0, 4201, 'Michael Blair', '1981-10-26', 'environment', 'http://may.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4265, 4258, 4303.0, 4202, 'Kim Murray', '1981-10-27', 'subject', 'http://www.bowers.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4266, 4259, 4310.0, 4203, 'Robert Jackson', '1981-10-28', 'soldier', 'https://www.hughes.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4267, 4260, 4317.0, 4204, 'Dr. Carrie Anderson', '1981-10-29', 'anyone', 'http://english.com/');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4174, 18, 4134, 4126, 4181, 4189, 'wife', 'president', 'guess');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4175, 4158, 4135, 4127, 4192.0, 4202.0, 'candidate', 'set', 'every');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4176, 4159, 4136, 4128, 4203.0, 4215.0, 'high', 'bed', 'their');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4177, 4160, 4137, 4129, 4214.0, 4228.0, 'measure', 'lawyer', 'program');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4178, 4161, 4138, 4130, 4225.0, 4241.0, 'during', 'last', 'doctor');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4179, 4162, 4139, 4131, 4236.0, 4254.0, 'onto', 'performance', 'science');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4180, 4163, 4140, 4132, 4247.0, 4267.0, 'fall', 'itself', 'see');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4276, 4164, 4141, 4133, 4258.0, 4280.0, 'compare', 'rate', 'trial');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4173, 18, 4135, 4229, 4182, 4190, 'wife', 'turn', 'night');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4277, 4261, 4238, 4230, 4295.0, 4305.0, 'authority', 'individual', 'develop');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4278, 4262, 4239, 4231, 4306.0, 4318.0, 'scene', 'few', 'ten');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4279, 4263, 4240, 4232, 4317.0, 4331.0, 'sit', 'my', 'nor');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4280, 4264, 4241, 4233, 4328.0, 4344.0, 'body', 'audience', 'until');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4281, 4265, 4242, 4234, 4339.0, 4357.0, 'myself', 'consider', 'may');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4282, 4266, 4243, 4235, 4350.0, 4370.0, 'authority', 'religious', 'sea');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4283, 4267, 4244, 4236, 4361.0, 4383.0, 'senior', 'late', 'administration');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 18 ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Gold Result:
('a',)
('idea',)
*/

-- Prediction Query
SELECT T1.driverRef FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 18 ORDER BY T2.q1 DESC, T1.driverid NULLS LAST, T2.qualifyid NULLS LAST LIMIT 5;

/*
Prediction Result:
('idea',)
('a',)
*/