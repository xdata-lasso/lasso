-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1014, 'Lindsey Roman', 'Saint Lucia', 'Calvin Nielsen', 'bar', 1015, 1016);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1024, 'Lindsey Roman', 'Saint Lucia', 'Calvin Nielsen', 'bar', 1015, 1016);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1052, 'Sarah Romero', 'Congo', 'Phillip Ryan', 'start', 1053, 1054);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1062, 'Sarah Romero', 'Congo', 'Phillip Ryan', 'start', 1053, 1054);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1017, '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'Michael Miles', 1018, 1019, 1020, 1021);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1023, '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'Michael Miles', 1018, 1019, 1020, 1021);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1055, 'PSC 0957, Box 0154
APO AE 08093', 'Keith Miller', 1056, 1057, 1058, 1059);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1061, 'PSC 0957, Box 0154
APO AE 08093', 'Keith Miller', 1056, 1057, 1058, 1059);
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1022, 1017, 'Andrea Reid', 'none', 'shoulder');
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1026, 1017, 'Andrea Reid', 'none', 'shoulder');
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1060, 1055, NULL, 'no', 'space');
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1064, 1055, NULL, 'no', 'space');
INSERT INTO "singer_in_concert" ("concert_id", "singer_id") VALUES (1022, 1014);
INSERT INTO "singer_in_concert" ("concert_id", "singer_id") VALUES (1060, 1052);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT concert_name, theme, n AS count___ FROM (SELECT LHS.concert_id AS concert_id, LHS.n AS n, RHS.concert_name AS concert_name, RHS.theme AS theme, RHS.stadium_id AS stadium_id, RHS.year AS YEAR FROM (SELECT concert_id, COUNT(*) AS n FROM singer_in_concert GROUP BY concert_id) AS LHS LEFT JOIN concert AS RHS ON (LHS.concert_id = RHS.concert_id)) ORDER BY concert_name, theme NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 'no', 1)
('Andrea Reid', 'none', 1)
*/

-- Prediction Query
SELECT t2.concert_name, t2.theme, COUNT(*) FROM singer_in_concert AS t1 JOIN concert AS t2 ON t1.concert_id = t2.concert_id GROUP BY t2.concert_id;

/*
Prediction Result:
('Andrea Reid', 'none', 1)
(None, 'no', 1)
*/