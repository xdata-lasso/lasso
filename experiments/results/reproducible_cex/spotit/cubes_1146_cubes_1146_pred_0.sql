-- Schema DDL
CREATE TABLE "GENRE" (
    "G_NAME" TEXT,
    "RATING" TEXT,
    "MOST_POPULAR_IN" TEXT,
    PRIMARY KEY ("G_NAME")
);
CREATE TABLE "ARTIST" (
    "ARTIST_NAME" TEXT,
    "PREFERRED_GENRE" TEXT,
    "COUNTRY" TEXT,
    "GENDER" TEXT,
    PRIMARY KEY ("ARTIST_NAME"),
    FOREIGN KEY ("PREFERRED_GENRE") REFERENCES "GENRE"("G_NAME")
);
CREATE TABLE "FILES" (
    "F_ID" FLOAT,
    "ARTIST_NAME" TEXT,
    "FILE_SIZE" TEXT,
    "DURATION" TEXT,
    "FORMATS" TEXT,
    PRIMARY KEY ("F_ID"),
    FOREIGN KEY ("ARTIST_NAME") REFERENCES "ARTIST"("ARTIST_NAME")
);
CREATE TABLE "SONG" (
    "SONG_NAME" TEXT,
    "GENRE_IS" TEXT,
    "F_ID" FLOAT,
    "ARTIST_NAME" TEXT,
    "COUNTRY" TEXT,
    "RATING" FLOAT,
    "LANGUAGES" TEXT,
    "RELEASEDATE" DATE,
    "RESOLUTION" FLOAT,
    PRIMARY KEY ("SONG_NAME"),
    FOREIGN KEY ("GENRE_IS") REFERENCES "GENRE"("G_NAME"),
    FOREIGN KEY ("F_ID") REFERENCES "FILES"("F_ID"),
    FOREIGN KEY ("ARTIST_NAME") REFERENCES "ARTIST"("ARTIST_NAME")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO GENRE VALUES (8, 0, 0);
INSERT INTO GENRE VALUES (9, 0, 0);
INSERT INTO ARTIST VALUES (3, 8, 0, 0);
INSERT INTO ARTIST VALUES (7, 8, 0, 0);
INSERT INTO FILES VALUES (6, 7, 0, 12, 2);
INSERT INTO FILES VALUES (10, 7, -1, 13, 1);
INSERT INTO SONG VALUES (4, 8, 10, 7, 26, 27, 28, '0001-01-01', 799);
INSERT INTO SONG VALUES (5, 9, 10, 7, 29, 30, 31, '0001-01-01', 799);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT file_size, formats FROM (SELECT LHS.song_name AS song_name, LHS.artist_name AS artist_name, LHS.country AS country, LHS.f_id AS f_id, LHS.genre_is AS genre_is, LHS.rating AS rating, LHS.languages AS languages, LHS.releasedate AS releasedate, LHS.resolution AS resolution, RHS.f_id AS f_id_other, RHS.file_size AS file_size, RHS.duration AS duration, RHS.formats AS formats FROM (SELECT * FROM song WHERE (resolution < 800.0)) AS LHS INNER JOIN files AS RHS ON (LHS.artist_name = RHS.artist_name)) ORDER BY file_size, formats NULLS LAST;

/*
Gold Result:
('-1', '1')
('-1', '1')
('0', '2')
('0', '2')
*/

-- Prediction Query
SELECT DISTINCT T1.file_size, T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id = T2.f_id WHERE T2.resolution < 800;

/*
Prediction Result:
('-1', '1')
*/