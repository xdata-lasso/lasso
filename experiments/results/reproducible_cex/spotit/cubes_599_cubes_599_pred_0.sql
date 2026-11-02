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
INSERT INTO SINGER VALUES (0, 8, 0, NULL, 0);
INSERT INTO SINGER VALUES (1, 7, 0, 0, 0);
INSERT INTO SONG VALUES (-1, 1, 0, 0, 0);
INSERT INTO SONG VALUES (0, 1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM singer ORDER BY net_worth_millions DESC, singer.singer_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('7',)
*/

-- Prediction Query
SELECT Name FROM singer ORDER BY Net_Worth_Millions DESC, singer.singer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('7',)
*/