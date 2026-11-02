-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1010, 'Lindsey Roman', 'Saint Lucia', 'Calvin Nielsen', 'bar', 1011, 1012);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1019, NULL, 'Uzbekistan', 'Kristin Cohen', 'threat', 1020, 1021);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1013, '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'Michael Miles', 1014, 1015, 1016, 1017);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1022, '05641 Robin Port
Jasonfort, MO 84760', 'Derek Wright', 1023, 1024, 1025, 1026);
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1018, 1013, 'Andrea Reid', 'none', 'shoulder');
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1027, 1022, 'Deborah Richards', 'water', 'past');
INSERT INTO "singer_in_concert" ("concert_id", "singer_id") VALUES (1018, 1010);
INSERT INTO "singer_in_concert" ("concert_id", "singer_id") VALUES (1027, 1019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, RHS.n AS n FROM singer AS LHS INNER JOIN (SELECT singer_id, COUNT(*) AS n FROM singer_in_concert GROUP BY singer_id) AS RHS ON (LHS.singer_id = RHS.singer_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Lindsey Roman', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id = T2.singer_id GROUP BY T2.singer_id;

/*
Prediction Result:
('Lindsey Roman', 1)
(None, 1)
*/