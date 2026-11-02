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
INSERT INTO STADIUM VALUES (1, 0, 0, 0, 0, 0, 0);
INSERT INTO STADIUM VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO SINGER VALUES (0, 13, 14, 15, 16, 0, 0);
INSERT INTO SINGER VALUES (1, 1, 17, 18, 19, 0, 0);
INSERT INTO CONCERT VALUES (-1, 1, 11, 12, 2014);
INSERT INTO CONCERT VALUES (0, 0, NULL, 10, 2014);
INSERT INTO SINGER_IN_CONCERT VALUES (-1, 1);
INSERT INTO SINGER_IN_CONCERT VALUES (0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, LHS.concert_id AS concert_id, LHS.concert_name AS concert_name, LHS.theme AS theme, LHS.stadium_id AS stadium_id, LHS.year AS YEAR FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, LHS.concert_id AS concert_id, RHS.concert_name AS concert_name, RHS.theme AS theme, RHS.stadium_id AS stadium_id, RHS.year AS YEAR FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, RHS.concert_id AS concert_id FROM singer AS LHS INNER JOIN singer_in_concert AS RHS ON (LHS.singer_id = RHS.singer_id)) AS LHS INNER JOIN concert AS RHS ON (LHS.concert_id = RHS.concert_id)) AS LHS INNER JOIN (SELECT * FROM concert WHERE (YEAR = 2014)) AS RHS ON (LHS.concert_id = RHS.concert_id AND LHS.concert_name = RHS.concert_name AND LHS.theme = RHS.theme AND LHS.stadium_id = RHS.stadium_id AND LHS.year = RHS.year)) ORDER BY name;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT T2.name FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id = T2.singer_id JOIN concert AS T3 ON T1.concert_id = T3.concert_id WHERE T3.year = 2014;

/*
Prediction Result:
('1',)
('13',)
*/