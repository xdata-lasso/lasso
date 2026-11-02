-- Schema DDL
CREATE TABLE "SINGER" (
    "SINGER_ID" INT,
    "NAME" TEXT,
    "BIRTH_YEAR" FLOAT,
    "NET_WORTH_MILLIONS" FLOAT,
    "CITIZENSHIP" TEXT,
    PRIMARY KEY ("SINGER_ID")
);
CREATE TABLE "SONG" (
    "SONG_ID" INT,
    "SINGER_ID" INT,
    "TITLE" TEXT,
    "SALES" FLOAT,
    "HIGHEST_POSITION" FLOAT,
    PRIMARY KEY ("SONG_ID"),
    FOREIGN KEY ("SINGER_ID") REFERENCES "SINGER"("SINGER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SINGER VALUES (1, 17, 18, 19, 20);
INSERT INTO SINGER VALUES (0, -1, 23, 24, 25);
INSERT INTO SONG VALUES (-1, 0, 21, NULL, 22);
INSERT INTO SONG VALUES (0, 0, 26, 300000, 27);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.song_id AS song_id, LHS.title AS title, LHS.singer_id AS singer_id, LHS.sales AS sales, LHS.highest_position AS highest_position, RHS.name AS name, RHS.birth_year AS birth_year, RHS.net_worth_millions AS net_worth_millions, RHS.citizenship AS citizenship FROM song AS LHS LEFT JOIN singer AS RHS ON (LHS.singer_id = RHS.singer_id)) WHERE (sales >= 300000.0) ORDER BY name;

/*
Gold Result:
('-1',)
*/

-- Prediction Query
SELECT DISTINCT T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID WHERE T2.Sales > 300000;

/*
Prediction Result:
*/