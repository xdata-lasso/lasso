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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4093, 'val_4097', 'Laura Ford', '86928 Nolan Unions
Martinport, VI 07502', 'val_4101', 4105.5, 4109.5, 4113, 'http://howard-arias.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4094, 'val_4098', 'Carol Vazquez', '72002 Christina Plain
Lake Sara, IN 18231', 'val_4102', 4118.5, 4124.5, 4130.0, 'http://lee.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4095, 'val_4099', 'Jose Fletcher', '41447 Pena Street
Lake Michelle, WA 14880', 'val_4103', 4131.5, 4139.5, 4147.0, 'http://mercado-russell.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4096, 'val_4100', 'Patricia Stark', '930 Jill Street Apt. 203
West Sharonberg, IN 17697', 'val_4104', 4144.5, 4154.5, 4164.0, 'http://www.joyce.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4205, 'val_4209', 'Michael Baker', '637 Damon Springs Apt. 081
Bentleystad, PW 22391', 'val_4213', 4217.5, 4221.5, 4225, 'https://www.johnson.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4206, 'val_4210', 'Christie Sparks', '58718 Flores Fords
Lisaview, WA 23598', 'val_4214', 4230.5, 4236.5, 4242.0, 'http://www.parker.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4207, 'val_4211', 'Jason Wilson', '4701 Lee Estates Apt. 865
East Rebecca, NH 59872', 'val_4215', 4243.5, 4251.5, 4259.0, 'http://www.johnson-turner.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (4208, 'val_4212', 'Stacey Lewis', '5633 Smith Harbors Apt. 052
Randolphland, AK 48668', 'val_4216', 4256.5, 4266.5, 4276.0, 'http://www.rice-burton.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4117, 'val_4121', 'Ronald Bryant', 'val_4125', 'https://www.evans-grimes.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4118, 'val_4122', 'Steven Davis', 'val_4126', 'http://www.raymond.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4119, 'val_4123', 'Bonnie Jones', 'val_4127', 'http://harvey.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4120, 'val_4124', 'Christopher George', 'val_4128', 'http://www.mcmillan.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4229, 'val_4233', 'Christopher Johnson Jr.', 'val_4237', 'https://www.anderson-brooks.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4230, 'val_4234', 'Gregory Fletcher', 'val_4238', 'https://www.hernandez.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4231, 'val_4235', 'Jeanette Knox', 'val_4239', 'http://harrison.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4232, 'val_4236', 'Matthew Johnston', 'val_4240', 'https://www.lopez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4130, 'val_4133', 4137, 'val_4141', 'Anthony Sullivan', 'Brock', '1991-05-18', 'val_4145', 'http://smith-holland.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4131, 'val_4134', 4144.0, 'val_4142', 'Tracy Butler', 'Maxwell', '1991-05-16', 'val_4146', 'http://anderson.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4132, 'val_4135', 4151.0, 'val_4143', 'Jennifer Finley', 'Sanford', '1991-05-17', 'val_4147', 'http://taylor.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4241, 'val_4136', 4158.0, 'val_4144', 'Amanda Hall', 'Carrillo', '1974-06-04', 'val_4148', 'https://hernandez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4129, 'val_4245', 4138, 'val_4253', 'Renee Gallegos', 'Orozco', '1991-05-18', 'val_4257', 'https://gill.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4242, 'val_4246', 4256.0, 'val_4254', 'Andrew Smith', 'Castro', '1974-06-05', 'val_4258', 'https://www.ramos-baker.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4243, 'val_4247', 4263.0, 'val_4255', 'James Gomez', 'Hayden', '1974-06-06', 'val_4259', 'http://www.haas.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4244, 'val_4248', 4270.0, 'val_4256', 'Samantha Spencer', 'Mccarthy', '1974-06-07', 'val_4260', 'http://www.carter.org/');
INSERT INTO "seasons" ("year", "url") VALUES (4165, 'https://myers.info/');
INSERT INTO "seasons" ("year", "url") VALUES (4166, 'https://matthews-jacobson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4167, 'https://www.rasmussen-kim.org/');
INSERT INTO "seasons" ("year", "url") VALUES (4168, 'https://hughes-chandler.net/');
INSERT INTO "seasons" ("year", "url") VALUES (4277, 'http://ross.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4278, 'https://www.cross-gibbs.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4279, 'https://carroll-lloyd.com/');
INSERT INTO "seasons" ("year", "url") VALUES (4280, 'https://www.madden-adams.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4169, 4165, 4173, 4093, 'Robert Jordan', '1970-02-23', 'val_4177', 'https://www.lopez-ross.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4171, 4165, 4180.0, 4093, 'Beth Thompson', '1970-02-24', 'val_4178', 'https://james.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4172, 4165, 4187.0, 4093, 'Alex Wolfe', '1970-02-25', 'val_4179', 'http://www.berg-hill.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4281, 4165, 4194.0, 4093, 'Gary Roberson', '1970-02-26', 'val_4180', 'https://www.white-martinez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4170, 4277, 4285, 4205, 'Tamara Peterson', '1970-02-23', 'val_4289', 'https://www.woods.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4282, 4277, 4292.0, 4205, 'Alan Mahoney', '1982-03-13', 'val_4290', 'http://hamilton.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4283, 4277, 4299.0, 4205, 'Nathan Vargas', '1982-03-14', 'val_4291', 'http://taylor.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4284, 4277, 4306.0, 4205, 'Frank Payne', '1982-03-15', 'val_4292', 'http://everett.com/');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4181, 4169, 4130, 4117, 4185, 4189, 'val_4193', 'val_4197', 'val_4201');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4183, 4169, 4130, 4117, 4196.0, 4202.0, 'val_4194', 'val_4198', 'val_4202');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4184, 4169, 4130, 4117, 4207.0, 4215.0, 'val_4195', 'val_4199', 'val_4203');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4293, 4169, 4130, 4117, 4218.0, 4228.0, 'val_4196', 'val_4200', 'val_4204');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4182, 4170, 4129, 4229, 4297, 4301, 'val_4305', 'val_4309', 'val_4313');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4294, 4170, 4129, 4229, 4308.0, 4314.0, 'val_4306', 'val_4310', 'val_4314');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4295, 4170, 4129, 4229, 4319.0, 4327.0, 'val_4307', 'val_4311', 'val_4315');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4296, 4170, 4129, 4229, 4330.0, 4340.0, 'val_4308', 'val_4312', 'val_4316');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.year, T3.name, T3.date, T3.time FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T1.driverId = (SELECT driverId FROM drivers ORDER BY dob DESC, drivers.driverid NULLS LAST LIMIT 1) ORDER BY T3.date ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
(4277, 'Tamara Peterson', '1970-02-23', 'val_4289')
*/

-- Prediction Query
SELECT r.year, r.name AS race_name, r.date AS race_date, r.time AS race_time FROM qualifying AS q INNER JOIN races AS r ON q.raceId = r.raceId INNER JOIN drivers AS d ON q.driverId = d.driverId WHERE d.dob = (SELECT MAX(dob) FROM drivers) ORDER BY r.date ASC, q.qualifyid NULLS LAST, r.raceid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
(4165, 'Robert Jordan', '1970-02-23', 'val_4177')
*/