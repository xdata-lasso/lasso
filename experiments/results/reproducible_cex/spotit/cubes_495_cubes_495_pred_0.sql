-- Schema DDL
CREATE TABLE "STADIUM" (
    "STADIUM_ID" INT,
    "LOCATION" TEXT,
    "NAME" TEXT,
    "CAPACITY" INT,
    "HIGHEST" INT,
    "LOWEST" INT,
    "AVERAGE" INT,
    PRIMARY KEY ("STADIUM_ID")
);
CREATE TABLE "SINGER" (
    "SINGER_ID" INT,
    "NAME" TEXT,
    "COUNTRY" TEXT,
    "SONG_NAME" TEXT,
    "SONG_RELEASE_YEAR" TEXT,
    "AGE" INT,
    "IS_MALE" INT,
    PRIMARY KEY ("SINGER_ID")
);
CREATE TABLE "CONCERT" (
    "CONCERT_ID" INT,
    "STADIUM_ID" TEXT,
    "CONCERT_NAME" TEXT,
    "THEME" TEXT,
    "YEAR" TEXT,
    PRIMARY KEY ("CONCERT_ID"),
    FOREIGN KEY ("STADIUM_ID") REFERENCES "STADIUM"("STADIUM_ID")
);
CREATE TABLE "SINGER_IN_CONCERT" (
    "CONCERT_ID" INT,
    "SINGER_ID" TEXT,
    PRIMARY KEY ("CONCERT_ID", "SINGER_ID"),
    FOREIGN KEY ("SINGER_ID") REFERENCES "SINGER"("SINGER_ID"),
    FOREIGN KEY ("CONCERT_ID") REFERENCES "CONCERT"("CONCERT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STADIUM VALUES (0, 22, 23, 0, 0, 0, 0);
INSERT INTO STADIUM VALUES (1, 27, 28, 0, 0, 0, 0);
INSERT INTO SINGER VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO SINGER VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO CONCERT VALUES (0, 0, 19, 20, 21);
INSERT INTO CONCERT VALUES (-1, 0, 24, 25, 26);
INSERT INTO SINGER_IN_CONCERT VALUES (-1, -1);
INSERT INTO SINGER_IN_CONCERT VALUES (0, -1);
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