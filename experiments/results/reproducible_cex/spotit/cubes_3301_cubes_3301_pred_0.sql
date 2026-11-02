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
INSERT INTO FOLLOWS VALUES (1, 1);
INSERT INTO FOLLOWS VALUES (1, 0);
INSERT INTO TWEETS VALUES (-1, 1, 0, 0);
INSERT INTO TWEETS VALUES (0, 0, 0, 0);
INSERT INTO USER_PROFILES VALUES (1, 0, 0, 0, 1000);
INSERT INTO USER_PROFILES VALUES (0, 0, 0, 0, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM user_profiles WHERE (followers >= 1000) ORDER BY name, user_profiles.uid NULLS LAST;

/*
Gold Result:
('0', '0')
('0', '0')
*/

-- Prediction Query
SELECT name, email FROM user_profiles WHERE followers > 1000;

/*
Prediction Result:
*/