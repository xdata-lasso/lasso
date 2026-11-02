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
INSERT INTO FOLLOWS VALUES (0, 1);
INSERT INTO FOLLOWS VALUES (0, 0);
INSERT INTO TWEETS VALUES (0, 1, 18, NULL);
INSERT INTO TWEETS VALUES (1, 0, 21, 22);
INSERT INTO USER_PROFILES VALUES (1, 0, 17, 0, 0);
INSERT INTO USER_PROFILES VALUES (0, 0, 20, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT followers, name, COUNT(*) AS n FROM (SELECT LHS.id AS id, LHS.uid AS UID, LHS.text AS text, LHS.createdate AS createdate, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM tweets AS LHS INNER JOIN user_profiles AS RHS ON (LHS.uid = RHS.uid)) GROUP BY followers, name) WHERE (n <> 1) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT T1.name FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid HAVING COUNT(*) > 1;

/*
Prediction Result:
*/