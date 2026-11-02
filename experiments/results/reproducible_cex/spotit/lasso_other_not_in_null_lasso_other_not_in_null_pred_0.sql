-- Schema DDL
CREATE TABLE "TEAMS" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "USERS" (
    "ID" INT,
    "TEAM_ID" INT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO TEAMS VALUES (0, 8);
INSERT INTO TEAMS VALUES (1, 9);
INSERT INTO USERS VALUES (0, NULL);
INSERT INTO USERS VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM users WHERE NOT team_id IN (SELECT id FROM teams);

/*
Gold Result:
*/

-- Prediction Query
SELECT u.id FROM users AS u LEFT JOIN teams AS t ON u.team_id = t.id WHERE t.id IS NULL;

/*
Prediction Result:
(0,)
*/