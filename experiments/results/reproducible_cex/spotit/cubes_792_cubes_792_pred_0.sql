-- Schema DDL
CREATE TABLE "STADIUM" (
    "ID" INT,
    "NAME" TEXT,
    "HOME_GAMES" INT,
    "AVERAGE_ATTENDANCE" FLOAT,
    "TOTAL_ATTENDANCE" FLOAT,
    "CAPACITY_PERCENTAGE" FLOAT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "GAME" (
    "ID" INT,
    "STADIUM_ID" INT,
    "SEASON" INT,
    "DATE" TEXT,
    "HOME_TEAM" TEXT,
    "AWAY_TEAM" TEXT,
    "SCORE" TEXT,
    "COMPETITION" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("STADIUM_ID") REFERENCES "STADIUM"("ID")
);
CREATE TABLE "INJURY_ACCIDENT" (
    "ID" INT,
    "GAME_ID" INT,
    "PLAYER" TEXT,
    "INJURY" TEXT,
    "NUMBER_OF_MATCHES" TEXT,
    "SOURCE" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("GAME_ID") REFERENCES "GAME"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STADIUM VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO STADIUM VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO GAME VALUES (-1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO GAME VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO INJURY_ACCIDENT VALUES (0, -1, 19, 20, 17, 21);
INSERT INTO INJURY_ACCIDENT VALUES (1, -1, 11, 12, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_source_ FROM (SELECT number_of_matches, COUNT(DISTINCT SOURCE) AS n_distinct FROM injury_accident GROUP BY number_of_matches) ORDER BY count_distinct_source_;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT SOURCE) FROM injury_accident;

/*
Prediction Result:
(1,)
*/