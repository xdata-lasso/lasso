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
INSERT INTO BASKETBALL_MATCH VALUES (-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO BASKETBALL_MATCH VALUES (0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO UNIVERSITY VALUES (0, 0, 0, 0, 0, NULL, 0, NULL);
INSERT INTO UNIVERSITY VALUES (1, 0, 0, NULL, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT enrollment, primary_conference FROM (SELECT * FROM (SELECT * FROM university ORDER BY affiliation DESC, university.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT enrollment, primary_conference FROM university ORDER BY founded, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0, '0')
*/