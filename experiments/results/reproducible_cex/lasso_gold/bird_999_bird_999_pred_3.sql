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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1802, 'any', 'Alexis Noble', '541 Beck Run
North Randy, ME 95657', 'Canada', 1806.5, 1810.5, 1814, 'https://www.mosley.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1803, 'bit', 'Jesus Braun', '1103 Miller Ramp
New Erin, AL 01557', 'Uruguay', 1819.5, 1825.5, 1831.0, 'https://edwards-taylor.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1804, 'produce', 'Zachary Blankenship', '2713 Davis Valley
North Lawrenceport, DC 50665', 'Isle of Man', 1832.5, 1840.5, 1848.0, 'http://www.burke.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1805, 'step', 'Elizabeth Baxter', '218 Chelsey Expressway
Bellborough, SC 98578', 'Nicaragua', 1845.5, 1855.5, 1865.0, 'https://www.lawson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1886, 'public', 'Amy Bates', 'USNS Chan
FPO AP 14784', 'Norfolk Island', 1890.5, 1894.5, 1898, 'https://www.osborn.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1887, 'ten', 'Eddie Rosales', '7561 Oconnell Fords
Parkerview, PR 16218', 'Wallis and Futuna', 1903.5, 1909.5, 1915.0, 'http://www.martinez-dunlap.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1888, 'indeed', 'Jenna Decker', '903 Hernandez Station Apt. 568
Lake Kentburgh, AK 53505', 'Oman', 1916.5, 1924.5, 1932.0, 'http://foster.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1889, 'bad', 'Jesse Hall', '71210 Maria Forges
East Madison, MN 90453', 'Belize', 1929.5, 1939.5, 1949.0, 'https://www.hill.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1818, 'water', 'David Little', 'China', 'http://www.jones.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1819, 'student', 'Stephen Smith', 'Serbia', 'https://marquez.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1820, 'education', 'Eugene Hughes', 'Latvia', 'http://www.miller-miller.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1821, 'miss', 'Jennifer Payne', 'Zimbabwe', 'http://willis-hines.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1902, 'already', 'Edward Jenkins', 'South Africa', 'https://harrington.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1903, 'positive', 'Amy Ramirez', 'Andorra', 'https://johnson.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1904, 'president', 'Curtis Wilkerson', 'Hong Kong', 'http://stokes.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1905, 'practice', 'Lydia Pham', 'Slovenia', 'https://www.garcia.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1822, 'force', 1826, 'throughout', 'Jeffrey Chavez', 'Mills', '1989-01-09', 'Brunei Darussalam', 'https://www.rogers.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1823, 'say', 1833.0, 'edge', 'Ellen Harmon', 'Logan', '1989-01-10', 'San Marino', 'http://proctor.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1824, 'leave', 1840.0, 'article', 'Barbara Zimmerman', 'Le', '1989-01-11', 'Slovakia (Slovak Republic)', 'https://www.villarreal-jackson.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1825, 'show', 1847.0, 'election', 'Carla Benton', 'Jackson', '1989-01-12', 'Tunisia', 'https://www.craig.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1906, 'exactly', 1910, 'whose', 'Colleen Bradford PhD', 'Haynes', '1997-09-17', 'Comoros', 'https://henry.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1907, 'none', 1917.0, 'since', 'Ryan Bruce', 'Meza', '1997-09-18', 'Taiwan', 'http://www.fox.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1908, 'team', 1924.0, 'arrive', 'Kevin Drake', 'Elliott', '1997-09-19', 'Sudan', 'http://www.love-sellers.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1909, 'strong', 1931.0, 'south', 'Suzanne Johnson', 'Hart', '1997-09-20', 'Turkmenistan', 'http://www.willis.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1830, 'http://www.williams.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1831, 'http://www.tran.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1832, 'http://butler.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1833, 'https://www.watson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1914, 'https://www.bush-bates.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1915, 'http://morris-daugherty.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1916, 'https://mann.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1917, 'https://www.chapman.com/');
INSERT INTO "status" ("statusid", "status") VALUES (1834, 'dog');
INSERT INTO "status" ("statusid", "status") VALUES (1835, 'summer');
INSERT INTO "status" ("statusid", "status") VALUES (1836, 'name');
INSERT INTO "status" ("statusid", "status") VALUES (1837, 'institution');
INSERT INTO "status" ("statusid", "status") VALUES (1918, 'care');
INSERT INTO "status" ("statusid", "status") VALUES (1919, 'cost');
INSERT INTO "status" ("statusid", "status") VALUES (1920, 'shoulder');
INSERT INTO "status" ("statusid", "status") VALUES (1921, 'ability');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1838, 1830, 1842, 1802, 'John Campbell', '1993-05-13', 'perhaps', 'http://www.smith.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1839, 1830, 1849.0, 1802, 'Erin Tran', '1993-05-14', 'minute', 'http://franco.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1840, 1830, 1856.0, 1802, 'Curtis Elliott', '1993-05-15', 'spring', 'https://harris.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1841, 1830, 1863.0, 1802, 'Marcus Marshall', '1993-05-16', 'stand', 'https://www.dawson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1922, 1914, 1926, 1886, 'Tiffany Myers', '1972-02-21', 'skill', 'https://www.mcclure.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1923, 1914, 1933.0, 1886, 'Traci Johnson DDS', '1972-02-22', 'bank', 'https://www.clark-steele.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1924, 1914, 1940.0, 1886, 'Tracy Walker', '1972-02-23', 'economy', 'https://www.smith.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1925, 1914, 1947.0, 1886, 'Taylor Taylor', '1972-02-24', 'hand', 'https://bell-bennett.info/');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1846, 1838, 1822, 1818, 1850, 1854, 1858, 'will', 1862, 1866.5, 1870, 'nature', 1874, 1878, 1882, 'hotel', 'partner', 1834);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1847, 1838, 1822, 1818, 1861.0, 1867.0, 1873.0, 'each', 1881.0, 1887.5, 1893.0, 'itself', 1901.0, 1907.0, 1913.0, 'low', 'beyond', 1834);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1848, 1838, 1822, 1818, 1872.0, 1880.0, 1888.0, 'watch', 1900.0, 1908.5, 1916.0, 'school', 1928.0, 1936.0, 1944.0, 'small', 'mouth', 1834);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1849, 1838, 1822, 1818, 1883.0, 1893.0, 1903.0, 'through', 1919.0, 1929.5, 1939.0, 'war', 1955.0, 1965.0, 1975.0, 'become', 'cell', 1834);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1930, 1922, 1906, 1902, 1934, 1938, 1942, 'story', 1946, 1950.5, 1954, 'son', 1958, 1962, 1966, NULL, 'live', 1918);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1931, 1922, 1906, 1902, 1945.0, 1951.0, 1957.0, 'treat', 1965.0, 1971.5, 1977.0, 'right', 1985.0, 1991.0, 1997.0, NULL, 'back', 1918);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1932, 1922, 1906, 1902, 1956.0, 1964.0, 1972.0, 'participant', 1984.0, 1992.5, 2000.0, 'down', 2012.0, 2020.0, 2028.0, NULL, 'successful', 1918);
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1933, 1922, 1906, 1902, 1967.0, 1977.0, 1987.0, 'rather', 2003.0, 2013.5, 2023.0, 'commercial', 2039.0, 2049.0, 2059.0, NULL, 'along', 1918);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapTime ASC, T1.raceid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('John Campbell',)
*/

-- Prediction Query
SELECT T2.name FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId ORDER BY T1.fastestLapTime ASC, T1.resultid NULLS LAST, T2.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Tiffany Myers',)
*/