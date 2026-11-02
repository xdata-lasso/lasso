-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483648, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

-- Inserting into table: sportsinfo --
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', -1022641847, -1726781632, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', 1610062532, -106629402, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', 809183447, 89267185, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', 1744686505, -1633151678, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', 1914020640, 1268590800, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', 1115440883, 1644814318, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, '1', -1349201381, 1019800248, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, '1', 1526238907, -1377057208, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'C', -1610064545, 429706943, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'O', 1236688122, 2087640001, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'O', -1137908826, -918961358, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, '!', -1823627488, -1209887326, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, '''', 1151980946, 1620389964, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, '''', 947159877, 1990080517, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, '!', -1964997180, 1149850321, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'G', 528680845, -1585009206, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'G', 283598170, 742285925, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'A', 757448742, -1179823637, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', 1, 1, 'spo_e6e7a8');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', 1, 1, 'spo_550528');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', 1, 1, 'spo_f50027');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, NULL, -1031969798, -1106983592, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, NULL, 902551284, 2107872094, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, NULL, 743312762, -1822992503, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', -1347802441, 1673584235, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', -314162272, 2137741668, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (-2147483648, 'spo_a4c47c', -188151580, 226938182, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sportname" FROM (SELECT "onscholarship", "sportname", COUNT(*) AS "n" FROM "sportsinfo" GROUP BY "onscholarship", "sportname") WHERE ("onscholarship" = 'Y' AND n > 1) ORDER BY sportname, "sportname" NULLS LAST;

/*
Gold Result:
(None,)
('!',)
("'",)
('1',)
('G',)
('O',)
('spo_a4c47c',)
*/

-- Prediction Query
SELECT sportname FROM Sportsinfo WHERE onscholarship = 'Y' GROUP BY sportname ORDER BY COUNT(*) DESC, sportname NULLS LAST LIMIT 1;

/*
Prediction Result:
('spo_a4c47c',)
*/