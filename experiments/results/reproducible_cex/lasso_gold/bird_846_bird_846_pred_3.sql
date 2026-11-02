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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3579, 'surface', 'Tracy Welch', '2801 Terri Greens
New Barbara, ID 92247', 'Bahamas', 3587.5, 3595.5, 3603, 'http://www.harding.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3580, 'growth', 'Maurice Salazar', '25326 Guzman Parkways
Jefferyview, GU 45689', 'Guinea', 3600.5, 3610.5, 3620.0, 'https://www.mccoy-sutton.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3581, 'truth', 'Charles Hardin', '442 Bryan Park
Raventon, RI 99545', 'Botswana', 3613.5, 3625.5, 3637.0, 'http://www.campbell.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3582, 'when', 'Charlene Higgins', '701 Chapman Lake
New Josemouth, NV 47439', 'Gibraltar', 3626.5, 3640.5, 3654.0, 'https://smith.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3583, 'prepare', 'Jeffrey Jennings', '7475 Jeremy Extension Apt. 567
Nguyenfurt, NH 61369', 'Romania', 3639.5, 3655.5, 3671.0, 'http://www.barker-kent.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3584, 'clearly', 'Mitchell Hughes', '660 Kristina Light
South Michael, NE 87240', 'Lesotho', 3652.5, 3670.5, 3688.0, 'https://peterson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3585, 'pass', 'Cheryl Roth', 'PSC 2923, Box 1067
APO AE 36007', 'New Caledonia', 3665.5, 3685.5, 3705.0, 'https://www.watkins.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3586, 'produce', 'Kathleen Mccarthy', '6248 Perez Oval
Reynoldsburgh, NM 87767', 'French Guiana', 3678.5, 3700.5, 3722.0, 'https://www.dixon-davis.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3682, 'today', 'Rodney Gilmore', '081 Thomas Cliffs
Johnfurt, ME 27927', 'Czech Republic', 3690.5, 3698.5, 3706, 'http://www.taylor.org/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3683, 'success', 'Kimberly Stone DDS', '00041 Jacob Trail
North Jonville, NE 47361', 'Guam', 3703.5, 3713.5, 3723.0, 'http://richardson-hale.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3684, 'painting', 'Joshua Dunlap', '945 Brooks Hollow
Harveyfort, SC 81084', 'Tonga', 3716.5, 3728.5, 3740.0, 'https://www.wells-ramirez.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3685, 'chair', 'Melinda French', '75504 Callahan Lights Apt. 699
Stacyfort, AK 50304', 'Tanzania', 3729.5, 3743.5, 3757.0, 'https://www.miller.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3686, 'team', 'Gabriel Copeland MD', '74811 Jennifer Stravenue Apt. 765
New Tracey, AZ 42820', 'Lithuania', 3742.5, 3758.5, 3774.0, 'https://calhoun.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3687, 'describe', 'Kelly Weiss', '96102 Selena Mills Apt. 827
Heidifurt, AS 70711', 'Reunion', 3755.5, 3773.5, 3791.0, 'http://www.hudson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3688, 'thank', 'Gregory Russell', '9187 Rachel Hill
North Kelly, MA 56433', 'Yemen', 3768.5, 3788.5, 3808.0, 'https://baker.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3689, 'room', 'Ashley Bowman', '37730 Parsons Valley
Port Nicholas, ME 24444', 'United States Minor Outlying Islands', 3781.5, 3803.5, 3825.0, 'https://www.williams.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3611, 'price', 'Deborah Cole', 'British Indian Ocean Territory (Chagos Archipelago)', 'https://cardenas.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3612, 'fund', 'Raven Hill', 'French Polynesia', 'https://www.pearson.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3613, 'beat', 'Ryan Brown', 'Saint Pierre and Miquelon', 'https://griffin.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3614, 'newspaper', 'Mark Murphy', 'Congo', 'http://rodriguez-hill.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3615, 'military', 'Karen Thomas', 'South Georgia and the South Sandwich Islands', 'http://martin-anderson.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3616, 'maintain', 'Francisco Galloway', 'Madagascar', 'http://www.tran-wood.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3617, 'vote', 'Kimberly Holloway', 'Finland', 'https://www.hamilton.org/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3618, 'your', 'Tina Harper', 'Egypt', 'http://cunningham-carroll.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3714, 'activity', 'Lauren Smith', 'Niue', 'https://www.williams-flores.biz/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3715, 'hot', 'Breanna Mccall', 'Sao Tome and Principe', 'http://www.barber.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3716, 'as', 'Rebecca Lopez', 'Isle of Man', 'http://avery.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3717, 'Mrs', 'John Garcia', 'Taiwan', 'http://mejia-reynolds.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3718, 'story', 'Mark Weaver', 'Guyana', 'https://campbell-santos.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3719, 'actually', 'Brianna Martinez', 'Wallis and Futuna', 'https://wyatt-harrison.info/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3720, 'budget', 'Shannon Jones', 'Sweden', 'https://www.rogers-holt.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3721, 'network', 'Victoria Knight', 'Estonia', 'http://adams.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3619, 'arrive', 3627, 'blue', 'Greg Jones', 'Best', '1993-05-10', 'Rwanda', 'http://miller.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3620, 'series', 3634.0, 'necessary', 'Antonio Butler', 'Taylor', '1993-05-11', 'Armenia', 'https://www.herrera.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3621, 'cause', 3641.0, 'common', 'Melissa Kelley', 'Flores', '1993-05-12', 'Cook Islands', 'https://brooks.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3622, 'model', 3648.0, 'yard', 'Daniel Moore', 'Hughes', '1993-05-13', 'Namibia', 'https://murphy.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3623, 'within', 3655.0, 'easy', 'Sheila Perez', 'Walters', '1993-05-14', 'Argentina', 'http://johnson-morrison.net/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3624, 'author', 3662.0, 'best', 'Michael Johnson', 'Foster', '1993-05-15', 'Cote d''Ivoire', 'https://www.rodriguez.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3625, 'challenge', 3669.0, 'here', 'Melissa Mendoza', 'Dixon', '1993-05-16', 'Denmark', 'http://www.fitzgerald.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3626, 'civil', 3676.0, 'ground', 'Peter Dodson', 'Roberts', '1993-05-17', 'Liechtenstein', 'https://brown-sims.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3722, 'drive', 3730, 'happen', 'Kyle Santiago', 'Brooks', '1980-10-03', 'Honduras', 'https://silva.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3723, 'form', 3737.0, 'follow', 'Louis Buchanan', 'Myers', '1980-10-04', 'Suriname', 'https://www.fuller-burns.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3724, 'western', 3744.0, 'dark', 'Melissa Lee', 'Love', '1980-10-05', 'India', 'https://edwards-taylor.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3725, 'game', 3751.0, 'that', 'Michelle Tran', 'Randolph', '1980-10-06', 'Afghanistan', 'https://www.boone.com/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3726, 'what', 3758.0, 'government', 'Joel Meyer', 'Peterson', '1980-10-07', 'Comoros', 'https://www.frost.biz/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3727, 'education', 3765.0, 'national', 'Nathan Carter', 'Scott', '1980-10-08', 'Sudan', 'http://www.knight.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3728, 'others', 3772.0, 'require', 'Kyle Schultz', 'Jones', '1980-10-09', 'Vietnam', 'https://allen-robinson.org/');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3729, 'cut', 3779.0, 'its', 'Stephen Pacheco', 'Martinez', '1980-10-10', 'Equatorial Guinea', 'https://hernandez.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3635, 'https://www.johnson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3636, 'http://price.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3637, 'http://hoffman-mitchell.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3638, 'http://www.farrell.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3639, 'http://turner.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3640, 'http://www.richardson.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3641, 'https://ramirez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3642, 'https://www.turner.info/');
INSERT INTO "seasons" ("year", "url") VALUES (3738, 'https://www.shaffer.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3739, 'http://www.duncan.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3740, 'https://www.sanchez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3741, 'http://martin.com/');
INSERT INTO "seasons" ("year", "url") VALUES (3742, 'http://www.parker.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (3743, 'https://www.garcia.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (3744, 'https://stevenson.org/');
INSERT INTO "seasons" ("year", "url") VALUES (3745, 'https://www.hubbard.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (18, 3635, 3650, 3579, 'Stacy Mcbride', '1972-02-18', 'part', 'https://pham.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3643, 3636, 3657.0, 3580, 'Thomas Garner', '1972-02-19', 'watch', 'http://www.west.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3644, 3637, 3664.0, 3581, 'Amanda Galvan', '1972-02-20', 'another', 'https://baldwin.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3645, 3638, 3671.0, 3582, 'Adrian Miller', '1972-02-21', 'realize', 'https://george.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3646, 3639, 3678.0, 3583, 'Sergio Riley', '1972-02-22', 'at', 'http://winters.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3647, 3640, 3685.0, 3584, 'Debra Warner', '1972-02-23', 'speech', 'https://carpenter.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3648, 3641, 3692.0, 3585, 'Nicholas Hernandez', '1972-02-24', 'under', 'https://olsen.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3649, 3642, 3699.0, 3586, 'Ronald Gutierrez DVM', '1972-02-25', 'fast', 'https://miller-king.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3746, 3739, 3760.0, 3683, 'Mr. Ryan Obrien MD', '1988-07-12', 'age', 'https://jackson.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3747, 3740, 3767.0, 3684, 'Lindsay Hale', '1988-07-13', 'improve', 'http://www.diaz-hodges.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3748, 3741, 3774.0, 3685, 'Richard Clark', '1988-07-14', 'hair', 'http://www.dominguez.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3749, 3742, 3781.0, 3686, 'Jared Wright', '1988-07-15', 'again', 'https://www.thomas-graham.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3750, 3743, 3788.0, 3687, 'David Burke', '1988-07-16', 'least', 'http://jackson-jones.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3751, 3744, 3795.0, 3688, 'Alexander Mcconnell', '1988-07-17', 'like', 'http://www.kelley-mcmahon.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3752, 3745, 3802.0, 3689, 'Michael Chavez', '1988-07-18', 'where', 'http://www.morrison.com/');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3658, 18, 3619, 3611, 3666, 3674, NULL, 'response', 'process');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3659, 3643, 3620, 3612, 3677.0, 3687.0, 'window', 'community', 'check');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3660, 3644, 3621, 3613, 3688.0, 3700.0, 'her', 'voice', 'place');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3661, 3645, 3622, 3614, 3699.0, 3713.0, 'quite', 'and', 'now');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3662, 3646, 3623, 3615, 3710.0, 3726.0, 'man', 'gun', 'project');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3663, 3647, 3624, 3616, 3721.0, 3739.0, 'little', 'move', 'theory');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3664, 3648, 3625, 3617, 3732.0, 3752.0, 'some', 'why', 'size');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3665, 3649, 3626, 3618, 3743.0, 3765.0, 'notice', 'trade', 'collection');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3761, 18, 3722, 3714, 3769, 3777, 'spring', 'home', 'Congress');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3762, 3746, 3723, 3715, 3780.0, 3790.0, 'exist', 'claim', 'space');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3763, 3747, 3724, 3716, 3791.0, 3803.0, 'technology', 'work', 'expert');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3764, 3748, 3725, 3717, 3802.0, 3816.0, 'stay', 'culture', 'must');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3765, 3749, 3726, 3718, 3813.0, 3829.0, 'none', 'else', 'tax');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3766, 3750, 3727, 3719, 3824.0, 3842.0, 'capital', 'across', 'against');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3767, 3751, 3728, 3720, 3835.0, 3855.0, 'on', 'gas', 'month');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3768, 3752, 3729, 3721, 3846.0, 3868.0, 'sort', 'top', 'mother');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 18 ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Gold Result:
('drive',)
('arrive',)
*/

-- Prediction Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T1.raceId = 18 AND NOT T1.q1 IS NULL ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Prediction Result:
('drive',)
*/