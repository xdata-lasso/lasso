-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1011, '103 Galloway Walk
Port Craig, KY 59930', 'Holly Wood', 1011, 1012, 1013, 1014);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1018, '327 Nelson Route
Lake Mark, WI 07832', 'Andrew Stewart', 1011, 1015, 1016, 1017);
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1012, 1011, 'Derek Zuniga', 'raise', 'away');
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1015, 1011, 'Daniel Hahn', 'under', 'serious');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT stadium_id) AS n_distinct FROM (SELECT concert_id, concert_name, theme, stadium_id, YEAR, stadium_id_other, LOCATION, name, lowest, average, highest, stadium_id AS capacity FROM (SELECT concert_id, concert_name, theme, stadium_id, YEAR, stadium_id_other, LOCATION, name, lowest, average, concert_id AS highest FROM (SELECT LHS.concert_id AS concert_id, LHS.concert_name AS concert_name, LHS.theme AS theme, LHS.stadium_id AS stadium_id, LHS.year AS YEAR, RHS.stadium_id AS stadium_id_other, RHS.location AS LOCATION, RHS.name AS name, RHS.lowest AS lowest, RHS.average AS average FROM concert AS LHS INNER JOIN stadium AS RHS ON (LHS.concert_id = RHS.highest AND LHS.stadium_id = RHS.capacity))))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM concert WHERE stadium_id = (SELECT stadium_id FROM stadium ORDER BY capacity DESC, stadium.stadium_id NULLS LAST LIMIT 1);

/*
Prediction Result:
(2,)
*/