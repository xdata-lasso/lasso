-- Schema DDL
CREATE TABLE "FOLLOWS" (
    "F1" INT,
    "F2" INT,
    PRIMARY KEY ("F1", "F2"),
    FOREIGN KEY ("F2") REFERENCES "USER_PROFILES"("UID"),
    FOREIGN KEY ("F1") REFERENCES "USER_PROFILES"("UID")
);
CREATE TABLE "TWEETS" (
    "ID" INT,
    "UID" INT,
    "TEXT" TEXT,
    "CREATEDATE" DATETIME,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("UID") REFERENCES "USER_PROFILES"("UID")
);
CREATE TABLE "USER_PROFILES" (
    "UID" INT,
    "NAME" TEXT,
    "EMAIL" TEXT,
    "PARTITIONID" INT,
    "FOLLOWERS" INT,
    PRIMARY KEY ("UID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO FOLLOWS VALUES (1, 0);
INSERT INTO FOLLOWS VALUES (0, 1);
INSERT INTO TWEETS VALUES (0, 0, 0, 0);
INSERT INTO TWEETS VALUES (1, 0, 0, 0);
INSERT INTO USER_PROFILES VALUES (0, NULL, -1, 0, -1);
INSERT INTO USER_PROFILES VALUES (1, 0, -4, 0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT LHS.followers AS followers, RHS.uid AS UID, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers_other FROM (SELECT MIN(followers) AS followers FROM user_profiles) AS LHS CROSS JOIN user_profiles AS RHS) WHERE (followers >= followers_other) ORDER BY name, email NULLS LAST;

/*
Gold Result:
(None, '-1')
('0', '-4')
*/

-- Prediction Query
SELECT name, email FROM user_profiles ORDER BY followers, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, '-1')
*/