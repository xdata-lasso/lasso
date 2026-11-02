-- Schema DDL
CREATE TABLE "CLUB" (
    "CLUB_ID" INT,
    "NAME" TEXT,
    "REGION" TEXT,
    "START_YEAR" TEXT,
    PRIMARY KEY ("CLUB_ID")
);
CREATE TABLE "CLUB_RANK" (
    "RANK" FLOAT,
    "CLUB_ID" INT,
    "GOLD" FLOAT,
    "SILVER" FLOAT,
    "BRONZE" FLOAT,
    "TOTAL" FLOAT,
    PRIMARY KEY ("RANK", "CLUB_ID"),
    FOREIGN KEY ("CLUB_ID") REFERENCES "CLUB"("CLUB_ID")
);
CREATE TABLE "PLAYER" (
    "PLAYER_ID" INT,
    "CLUB_ID" INT,
    "NAME" TEXT,
    "POSITION" TEXT,
    "APPS" FLOAT,
    "TRIES" FLOAT,
    "GOALS" TEXT,
    "POINTS" FLOAT,
    PRIMARY KEY ("PLAYER_ID"),
    FOREIGN KEY ("CLUB_ID") REFERENCES "CLUB"("CLUB_ID")
);
CREATE TABLE "COMPETITION" (
    "COMPETITION_ID" INT,
    "YEAR" FLOAT,
    "COMPETITION_TYPE" TEXT,
    "COUNTRY" TEXT,
    PRIMARY KEY ("COMPETITION_ID")
);
CREATE TABLE "COMPETITION_RESULT" (
    "COMPETITION_ID" INT,
    "CLUB_ID_1" INT,
    "CLUB_ID_2" INT,
    "SCORE" TEXT,
    PRIMARY KEY ("COMPETITION_ID", "CLUB_ID_1", "CLUB_ID_2"),
    FOREIGN KEY ("COMPETITION_ID") REFERENCES "COMPETITION"("COMPETITION_ID"),
    FOREIGN KEY ("CLUB_ID_2") REFERENCES "CLUB"("CLUB_ID"),
    FOREIGN KEY ("CLUB_ID_1") REFERENCES "CLUB"("CLUB_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CLUB VALUES (1, 0, 0, 0);
INSERT INTO CLUB VALUES (0, 0, 0, 0);
INSERT INTO CLUB_RANK VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO CLUB_RANK VALUES (0, 1, 0, 0, 0, 0);
INSERT INTO PLAYER VALUES (0, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO PLAYER VALUES (-1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO COMPETITION VALUES (0, 21, 0, 22);
INSERT INTO COMPETITION VALUES (2, 18, -1, 19);
INSERT INTO COMPETITION_RESULT VALUES (2, 0, 0, 0);
INSERT INTO COMPETITION_RESULT VALUES (0, 1, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type FROM (SELECT competition_type, YEAR, MAX(n) AS n FROM (SELECT competition_id, YEAR, competition_type, country, competition_id_other, competition_id AS n FROM (SELECT LHS.competition_id AS competition_id, LHS.year AS YEAR, LHS.competition_type AS competition_type, LHS.country AS country, RHS.competition_id AS competition_id_other FROM competition AS LHS INNER JOIN (SELECT competition_id, COUNT(*) AS n FROM competition GROUP BY competition_id) AS RHS ON (LHS.competition_id = RHS.n))) GROUP BY competition_type, YEAR) ORDER BY competition_type;

/*
Gold Result:
*/

-- Prediction Query
SELECT Competition_type FROM competition GROUP BY Competition_type ORDER BY COUNT(*) DESC, Competition_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/