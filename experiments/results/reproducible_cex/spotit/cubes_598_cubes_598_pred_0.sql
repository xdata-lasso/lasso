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
INSERT INTO SINGER VALUES (-1, 0, 0, 0, 0);
INSERT INTO SINGER VALUES (0, -1, 0, 0, 0);
INSERT INTO SONG VALUES (0, 0, 0, 0, 0);
INSERT INTO SONG VALUES (1, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM singer AS LHS WHERE NOT EXISTS(SELECT 1 FROM song AS RHS WHERE (LHS.singer_id = RHS.singer_id))) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE NOT Singer_ID IN (SELECT Singer_ID FROM song);

/*
Prediction Result:
('0',)
*/