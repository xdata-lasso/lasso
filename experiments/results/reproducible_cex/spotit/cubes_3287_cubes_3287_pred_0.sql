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
INSERT INTO FOLLOWS VALUES (0, -1);
INSERT INTO FOLLOWS VALUES (-1, -1);
INSERT INTO TWEETS VALUES (0, -1, 23, 24);
INSERT INTO TWEETS VALUES (-1, 0, 26, 27);
INSERT INTO USER_PROFILES VALUES (-1, 1, 22, 0, 0);
INSERT INTO USER_PROFILES VALUES (0, 1, 25, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT followers, name, COUNT(*) AS n FROM (SELECT LHS.id AS id, LHS.uid AS UID, LHS.text AS text, LHS.createdate AS createdate, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM tweets AS LHS INNER JOIN user_profiles AS RHS ON (LHS.uid = RHS.uid)) GROUP BY followers, name) WHERE (n <> 1) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('1', 2)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid HAVING COUNT(*) > 1;

/*
Prediction Result:
*/