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
INSERT INTO TWEETS VALUES (0, 1, 0, 0);
INSERT INTO TWEETS VALUES (-1, 1, 0, 0);
INSERT INTO USER_PROFILES VALUES (1, 0, 0, 0, 0);
INSERT INTO USER_PROFILES VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT email, name, COUNT(*) AS n FROM (SELECT f1, f2, name, email, partitionid, followers, f1 AS UID FROM (SELECT LHS.f1 AS f1, LHS.f2 AS f2, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM follows AS LHS INNER JOIN user_profiles AS RHS ON (LHS.f1 = RHS.uid))) GROUP BY email, name) WHERE (n > 1) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('0', '0')
*/

-- Prediction Query
SELECT T1.name, T1.email FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid = T2.f1 GROUP BY T2.f1 HAVING COUNT(*) > 1;

/*
Prediction Result:
*/