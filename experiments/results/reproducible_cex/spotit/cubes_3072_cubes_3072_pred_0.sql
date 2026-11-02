-- Schema DDL
CREATE TABLE "BASKETBALL_MATCH" (
    "TEAM_ID" INT,
    "SCHOOL_ID" INT,
    "TEAM_NAME" TEXT,
    "ACC_REGULAR_SEASON" TEXT,
    "ACC_PERCENT" TEXT,
    "ACC_HOME" TEXT,
    "ACC_ROAD" TEXT,
    "ALL_GAMES" TEXT,
    "ALL_GAMES_PERCENT" INT,
    "ALL_HOME" TEXT,
    "ALL_ROAD" TEXT,
    "ALL_NEUTRAL" TEXT,
    PRIMARY KEY ("TEAM_ID"),
    FOREIGN KEY ("SCHOOL_ID") REFERENCES "UNIVERSITY"("SCHOOL_ID")
);
CREATE TABLE "UNIVERSITY" (
    "SCHOOL_ID" INT,
    "SCHOOL" TEXT,
    "LOCATION" TEXT,
    "FOUNDED" FLOAT,
    "AFFILIATION" TEXT,
    "ENROLLMENT" FLOAT,
    "NICKNAME" TEXT,
    "PRIMARY_CONFERENCE" TEXT,
    PRIMARY KEY ("SCHOOL_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO BASKETBALL_MATCH VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO BASKETBALL_MATCH VALUES (-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO UNIVERSITY VALUES (0, 14, 15, 16, 0, 20000, 17, 18);
INSERT INTO UNIVERSITY VALUES (-1, 7, 8, 9, 0, 20001, 10, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___, affiliation FROM (SELECT affiliation, COUNT(DISTINCT enrollment) AS n_distinct FROM (SELECT * FROM university WHERE (enrollment >= 20000.0)) GROUP BY affiliation) ORDER BY count___, affiliation NULLS LAST;

/*
Gold Result:
(2, '0')
*/

-- Prediction Query
SELECT COUNT(*), affiliation FROM university WHERE enrollment > 20000 GROUP BY affiliation;

/*
Prediction Result:
(1, '0')
*/