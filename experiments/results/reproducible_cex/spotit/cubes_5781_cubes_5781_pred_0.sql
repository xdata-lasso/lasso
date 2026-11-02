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
INSERT INTO FOLLOWS VALUES (0, 0);
INSERT INTO FOLLOWS VALUES (1, 1);
INSERT INTO TWEETS VALUES (1, 0, 0, 0);
INSERT INTO TWEETS VALUES (0, 0, 0, 0);
INSERT INTO USER_PROFILES VALUES (0, 1, 16, 0, 1);
INSERT INTO USER_PROFILES VALUES (1, 0, 17, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.uid AS UID, LHS.name AS name, LHS.email AS email, LHS.partitionid AS partitionid, LHS.followers AS followers, RHS.followers AS followers_other FROM user_profiles AS LHS CROSS JOIN (SELECT MAX(followers) AS followers FROM user_profiles) AS RHS) WHERE (followers >= followers_other) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT name FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/