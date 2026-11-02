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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1949, 'bag', 'Debra Valentine', '2846 Karen Crossroad Apt. 867
New Michaelburgh, NH 16277', 'Vietnam', 1957.5, 1965.5, 1973, 'http://www.montgomery-miller.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1950, 'once', 'Susan Porter', '0036 Mark Ridge Suite 284
West Thomas, RI 45471', 'Turkey', 1970.5, 1980.5, 1990.0, 'https://www.rojas.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1951, 'word', 'Nicolas Salas', '3655 Ramirez Falls Apt. 931
Lindaside, NE 50424', 'Lebanon', 1983.5, 1995.5, 2007.0, 'http://www.johnson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1952, 'could', 'Dale Wright', '0267 Wendy Vista
Kristenport, KS 74181', 'Mexico', 1996.5, 2010.5, 2024.0, 'https://donovan.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1953, 'maybe', 'Brittney Rodriguez', '1203 Woods Roads
South Julieview, MN 47727', 'Austria', 2009.5, 2025.5, 2041.0, 'http://curry.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1954, 'former', 'Megan Alvarado', '0615 Barbara Run Apt. 455
Hamptonmouth, FM 10778', 'Anguilla', 2022.5, 2040.5, 2058.0, 'https://fernandez-ballard.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1955, 'health', 'Pamela Weaver', '2256 Sweeney Cliffs Apt. 253
Loganport, VT 35559', 'Sierra Leone', 2035.5, 2055.5, 2075.0, 'https://green-torres.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1956, 'discover', 'John Oliver', '7598 Gutierrez Ferry Apt. 234
East Garrettville, CT 08862', 'Indonesia', 2048.5, 2070.5, 2092.0, 'http://harrison-smith.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2044, 'oil', 'Harold Edwards', '488 Clinton Mount
Ericview, MN 76805', 'Saint Vincent and the Grenadines', 2052.5, 2060.5, 2068, 'https://www.hale.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2045, 'interest', 'Erika Watson PhD', '1969 Jessica Stream Suite 727
New Dawnton, VA 76035', 'Mauritania', 2065.5, 2075.5, 2085.0, 'http://brown.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2046, 'mother', 'Nicholas Franklin', '5661 Julie Vista
Lake Kimberlyfurt, AR 40449', 'Croatia', 2078.5, 2090.5, 2102.0, 'https://www.pena-smith.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2047, 'green', 'Cindy Cannon', '925 Eric Spring Suite 799
East Ryanfurt, FL 17827', 'Costa Rica', 2091.5, 2105.5, 2119.0, 'https://smith.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2048, 'really', 'Dawn Nixon', '086 Miller Parkway Suite 227
South Randall, OK 26204', 'Mayotte', 2104.5, 2120.5, 2136.0, 'http://bray.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2049, 'coach', 'James Barber', '14659 Daniel Loop
Diazborough, MD 45658', 'Mali', 2117.5, 2135.5, 2153.0, 'http://www.mason.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2050, 'none', 'Ms. Kelly Holder', '2597 Scott Viaduct
East Gina, FL 99818', 'Sao Tome and Principe', 2130.5, 2150.5, 2170.0, 'http://www.nielsen.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2051, 'plan', 'Eric Walker', '03924 Matthew Unions
West Shannontown, MA 27896', 'Eritrea', 2143.5, 2165.5, 2187.0, 'https://moore.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1981, 'your', 1989, 'final', 'Justin Foster', 'Dean', '1988-10-03', 'Saint Lucia', 'https://floyd-jimenez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1982, 'someone', 1996.0, 'picture', 'Omar Price', 'Lopez', '1988-10-04', 'Algeria', 'https://www.miller-christensen.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1983, 'me', 2003.0, 'during', 'Dennis Henderson', 'Smith', '1988-10-05', 'Djibouti', 'http://jones-harrison.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1984, 'firm', 2010.0, 'style', 'Phillip Kent', 'Williams', '1988-10-06', 'Bermuda', 'https://martinez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1985, 'act', 2017.0, 'account', 'Melinda Mitchell', 'Nichols', '1988-10-07', 'Canada', 'https://rojas.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1986, 'space', 2024.0, 'official', 'Rhonda Gutierrez', 'Garcia', '1988-10-08', 'American Samoa', 'https://www.wade.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1987, 'law', 2031.0, 'hour', 'Catherine Roberts', 'Adams', '1988-10-09', 'Lithuania', 'https://www.chandler.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1988, 'success', 2038.0, 'current', 'Lisa Nelson', 'Espinoza', '1988-10-10', 'Cuba', 'https://evans.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2076, 'eat', 2084, 'impact', 'Steven Sandoval', 'Forbes', '1975-04-19', 'British Indian Ocean Territory (Chagos Archipelago)', 'https://turner-reese.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2077, 'more', 2091.0, 'voice', 'James Yu', 'Daugherty', '1975-04-20', 'Colombia', 'http://www.anderson.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2078, 'fact', 2098.0, 'teacher', 'Lori Perez', 'Thomas', '1975-04-21', 'Ghana', 'https://www.hall.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2079, 'task', 2105.0, 'all', 'Christian Waller', 'Fitzpatrick', '1975-04-22', 'Taiwan', 'http://banks.info/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2080, 'assume', 2112.0, 'yet', 'Erin Daniels', 'Stark', '1975-04-23', 'Turkmenistan', 'http://www.perez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2081, 'process', 2119.0, 'one', 'Charles Weaver', 'Stewart', '1975-04-24', 'Cameroon', 'https://newton.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2082, 'even', 2126.0, 'far', 'Shari Parker', 'Grant', '1975-04-25', 'Antarctica (the territory South of 60 deg S)', 'http://www.camacho-burns.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2083, 'unit', 2133.0, 'down', 'Kelly Taylor', 'Fry', '1975-04-26', 'Serbia', 'https://www.sullivan-williams.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1997, 'http://www.hamilton.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1998, 'http://smith.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1999, 'https://www.townsend-wright.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2000, 'http://brown.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2001, 'http://www.hall-holden.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2002, 'https://www.norris.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2003, 'https://www.mann-hansen.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2004, 'https://www.lopez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2092, 'https://crosby.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2093, 'http://wilcox-williams.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2094, 'https://www.hughes.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2095, 'https://wilkerson-ayala.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2096, 'https://www.phillips-ellison.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2097, 'http://hayes.org/');
INSERT INTO "seasons" ("year", "url") VALUES (2098, 'http://morris-johnson.info/');
INSERT INTO "seasons" ("year", "url") VALUES (2099, 'http://wright.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2005, 1997, 2013, 1949, 'Linda Valencia', '1996-07-11', 'fear', 'http://www.white.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2006, 1998, 2020.0, 1950, 'Joseph Cole', '1996-07-12', 'future', 'http://garcia.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2007, 1999, 2027.0, 1951, 'Kimberly Gibson', '1996-07-13', 'it', 'https://diaz.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2008, 2000, 2034.0, 1952, 'Katie Gross', '1996-07-14', 'put', 'http://www.henry.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2009, 2001, 2041.0, 1953, 'Lisa Diaz', '1996-07-15', 'fund', 'https://bauer-brown.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2010, 2002, 2048.0, 1954, 'Erica Brown', '1996-07-16', 'bring', 'https://www.jones.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2011, 2003, 2055.0, 1955, 'Sabrina Lee', '1996-07-17', 'big', 'http://www.hall.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2012, 2004, 2062.0, 1956, 'Pamela Moore', '1996-07-18', 'necessary', 'http://garcia.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2100, 2092, 2108, 2044, 'Becky Wilson', '1983-01-04', 'produce', 'https://www.jimenez-jimenez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2101, 2093, 2115.0, 2045, 'Jack Mills', '1983-01-05', 'course', 'https://www.chapman.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2102, 2094, 2122.0, 2046, 'Richard Hunt', '1983-01-06', 'buy', 'https://burke.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2103, 2095, 2129.0, 2047, 'Jamie James', '1983-01-07', 'way', 'http://www.estrada.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2104, 2096, 2136.0, 2048, 'Susan Cunningham', '1983-01-08', 'catch', 'https://www.rodriguez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2105, 2097, 2143.0, 2049, 'Brittany Melton', '1983-01-09', 'degree', 'https://www.curry-ward.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2106, 2098, 2150.0, 2050, 'Michael Barnes', '1983-01-10', 'about', 'http://richardson-gray.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2107, 2099, 2157.0, 2051, 'Randy Griffin', '1983-01-11', 'prevent', 'https://www.ruiz-martinez.com/');
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2005, 1981, 1, 2123, 'boy', 2131);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2006, 1982, 2021, 2037.0, 'owner', 2049.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2007, 1983, 2022, 2046.0, 'owner', 2062.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2008, 1984, 2023, 2055.0, 'owner', 2075.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2009, 1985, 2024, 2064.0, 'owner', 2088.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2010, 1986, 2025, 2073.0, 'owner', 2101.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2011, 1987, 2026, 2082.0, 'owner', 2114.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2012, 1988, 2027, 2091.0, 'owner', 2127.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2100, 2076, 1, 2028, 'boy', 2036);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2101, 2077, 2116, 2132.0, 'owner', 2144.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2102, 2078, 2117, 2141.0, 'owner', 2157.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2103, 2079, 2118, 2150.0, 'owner', 2170.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2104, 2080, 2119, 2159.0, 'owner', 2183.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2105, 2081, 2120, 2168.0, 'owner', 2196.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2106, 2082, 2121, 2177.0, 'owner', 2209.0);
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2107, 2083, 2122, 2186.0, 'owner', 2222.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT driverId FROM lapTimes WHERE lap = 1 ORDER BY time, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 5;

/*
Gold Result:
(1981,)
(2076,)
*/

-- Prediction Query
SELECT driverId FROM lapTimes WHERE lap = 1 AND NOT milliseconds IS NULL ORDER BY milliseconds ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 5;

/*
Prediction Result:
(2076,)
(1981,)
*/