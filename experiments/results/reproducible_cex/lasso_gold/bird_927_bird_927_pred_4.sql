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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1804, 'participant', 'Mr. Michael Williams', '424 Diamond Glen
West Elizabethburgh, AR 52450', 'Canada', 1808.5, 1812.5, 1816, 'https://www.mosley.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1805, 'case', 'Richard Stevens', '1103 Miller Ramp
New Erin, AL 01557', 'Uruguay', 1821.5, 1827.5, 1833.0, 'https://edwards-taylor.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1806, 'others', 'Scott Alexander', '2713 Davis Valley
North Lawrenceport, DC 50665', 'Isle of Man', 1834.5, 1842.5, 1850.0, 'http://www.burke.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1807, 'together', 'Tyler Harris', '218 Chelsey Expressway
Bellborough, SC 98578', 'Nicaragua', 1847.5, 1857.5, 1867.0, 'https://www.lawson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1888, 'public', 'Amy Bates', 'USNS Chan
FPO AP 14784', 'Norfolk Island', 1892.5, 1896.5, 1900, 'https://www.osborn.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1889, 'ten', 'Eddie Rosales', '7561 Oconnell Fords
Parkerview, PR 16218', 'Wallis and Futuna', 1905.5, 1911.5, 1917.0, 'http://www.martinez-dunlap.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1890, 'indeed', 'Jenna Decker', '903 Hernandez Station Apt. 568
Lake Kentburgh, AK 53505', 'Oman', 1918.5, 1926.5, 1934.0, 'http://foster.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1891, 'bad', 'Jesse Hall', '71210 Maria Forges
East Madison, MN 90453', 'Belize', 1931.5, 1941.5, 1951.0, 'https://www.hill.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1820, 'step', 'Brian Porter MD', 'Serbia', 'http://www.jones.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1821, 'water', 'Vanessa Hatfield', 'Latvia', 'https://marquez.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1822, 'student', 'Bonnie Valencia', 'Zimbabwe', 'http://www.miller-miller.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1823, 'education', 'Holly Vega', 'Sierra Leone', 'http://willis-hines.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1904, 'already', 'Edward Jenkins', 'South Africa', 'https://harrington.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1905, 'positive', 'Amy Ramirez', 'Andorra', 'https://johnson.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1906, 'president', 'Curtis Wilkerson', 'Hong Kong', 'http://stokes.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1907, 'practice', 'Lydia Pham', 'Slovenia', 'https://www.garcia.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1824, 'force', 1828, 'throughout', 'Jeffrey Chavez', 'Mills', '1989-01-09', 'Brunei Darussalam', 'https://www.rogers.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1825, 'say', 1835.0, 'edge', 'Ellen Harmon', 'Logan', '1989-01-10', 'San Marino', 'http://proctor.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1826, 'leave', 1842.0, 'article', 'Barbara Zimmerman', 'Le', '1989-01-11', 'Slovakia (Slovak Republic)', 'https://www.villarreal-jackson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1827, 'show', 1849.0, 'election', 'Carla Benton', 'Jackson', '1989-01-12', 'Tunisia', 'https://www.craig.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1908, 'exactly', 1912, 'whose', 'Colleen Bradford PhD', 'Haynes', '1997-09-17', 'Comoros', 'https://henry.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1909, 'none', 1919.0, 'since', 'Ryan Bruce', 'Meza', '1997-09-18', 'Taiwan', 'http://www.fox.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1910, 'team', 1926.0, 'arrive', 'Kevin Drake', 'Elliott', '1997-09-19', 'Sudan', 'http://www.love-sellers.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1911, 'strong', 1933.0, 'south', 'Suzanne Johnson', 'Hart', '1997-09-20', 'Turkmenistan', 'http://www.willis.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1832, 'http://www.williams.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1833, 'http://www.tran.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1834, 'http://butler.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1835, 'https://www.watson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1916, 'https://www.bush-bates.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1917, 'http://morris-daugherty.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1918, 'https://mann.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1919, 'https://www.chapman.com/');
INSERT INTO "status" ("statusid", "status") VALUES (1836, 'dog');
INSERT INTO "status" ("statusid", "status") VALUES (1837, 'summer');
INSERT INTO "status" ("statusid", "status") VALUES (1838, 'name');
INSERT INTO "status" ("statusid", "status") VALUES (1839, 'any');
INSERT INTO "status" ("statusid", "status") VALUES (1920, 'care');
INSERT INTO "status" ("statusid", "status") VALUES (1921, 'cost');
INSERT INTO "status" ("statusid", "status") VALUES (1922, 'shoulder');
INSERT INTO "status" ("statusid", "status") VALUES (1923, 'ability');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1840, 1832, 1844, 1804, 'Andrea Marshall', '1993-05-13', 'majority', 'http://www.smith.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1841, 1832, 1851.0, 1804, 'Ryan Murphy', '1993-05-14', 'home', 'http://franco.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1842, 1832, 1858.0, 1804, 'Aimee Gonzalez', '1993-05-15', 'perhaps', 'https://harris.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1843, 1832, 1865.0, 1804, 'Elizabeth Dean', '1993-05-16', 'minute', 'https://www.dawson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1924, 1916, 1928, 1888, 'Tiffany Myers', '1972-02-21', 'skill', 'https://www.mcclure.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1925, 1916, 1935.0, 1888, 'Traci Johnson DDS', '1972-02-22', 'bank', 'https://www.clark-steele.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1926, 1916, 1942.0, 1888, 'Tracy Walker', '1972-02-23', 'economy', 'https://www.smith.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1927, 1916, 1949.0, 1888, 'Taylor Taylor', '1972-02-24', 'hand', 'https://bell-bennett.info/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1848, 1840, 1824, 1820, 1852, 1856, 1860, 'will', 1864, 1868.5, 1872, 'nature', 1876, 1880, 1884, 'hotel', 'partner', 1836);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1849, 1840, 1824, 1820, 1863.0, 1869.0, 1875.0, 'each', 1883.0, 1889.5, 1895.0, 'itself', 1903.0, 1909.0, 1915.0, 'low', 'beyond', 1836);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1850, 1840, 1824, 1820, 1874.0, 1882.0, 1890.0, 'watch', 1902.0, 1910.5, 1918.0, 'school', 1930.0, 1938.0, 1946.0, 'small', 'mouth', 1836);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1851, 1840, 1824, 1820, 1885.0, 1895.0, 1905.0, 'through', 1921.0, 1931.5, 1941.0, 'war', 1957.0, 1967.0, 1977.0, 'become', 'cell', 1836);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1932, 1924, 1908, 1904, 1936, 1940, 1944, 'story', 1948, 1952.5, 1956, 'right', 1960, 1964, 1968, NULL, 'back', 1920);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1933, 1924, 1908, 1904, 1947.0, 1953.0, 1959.0, 'treat', 1967.0, 1973.5, 1979.0, 'down', 1987.0, 1993.0, 1999.0, NULL, 'successful', 1920);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1934, 1924, 1908, 1904, 1958.0, 1966.0, 1974.0, 'rather', 1986.0, 1994.5, 2002.0, 'commercial', 2014.0, 2022.0, 2030.0, NULL, 'along', 1920);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1935, 1924, 1908, 1904, 1969.0, 1979.0, 1989.0, 'son', 2005.0, 2015.5, 2025.0, 'live', 2041.0, 2051.0, 2061.0, NULL, 'financial', 1920);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapSpeed DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('Jeffrey Chavez', 'Mills')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM drivers AS d JOIN results AS r ON d.driverId = r.driverId ORDER BY r.fastestLapSpeed DESC, d.driverid NULLS LAST, r.resultid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Colleen Bradford PhD', 'Haynes')
*/