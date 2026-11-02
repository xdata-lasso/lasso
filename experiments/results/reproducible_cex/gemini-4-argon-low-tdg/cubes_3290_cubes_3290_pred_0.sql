-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN vs LEFT JOIN, duplicate user names with different tweet counts,
-- NULL values in tweet columns (COUNT(*) vs COUNT(text)/COUNT(createdate)),
-- duplicate tweet texts (COUNT(*) vs COUNT(DISTINCT text)),
-- and ORDER BY tie-breaking on count___.
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'Alice', 'alice1@example.com', 10, 5);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (2, 'Alice', 'alice2@example.com', 20, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (3, 'Bob', 'bob@example.com', 10, 0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (4, 'Charlie', 'charlie@example.com', 30, 2);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (101, 1, 'Hello', '2023-01-01 10:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (102, 1, 'Hello', '2023-01-01 10:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (103, 1, NULL, NULL);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (104, 2, 'First tweet', '2023-01-02 11:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (105, 4, 'Charlie tweet 1', '2023-01-03 12:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (106, 4, 'Charlie tweet 2', '2023-01-04 12:00:00');
INSERT INTO "follows" ("f1", "f2") VALUES (1, 2);
INSERT INTO "follows" ("f1", "f2") VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.uid AS UID, LHS.name AS name, LHS.email AS email, LHS.partitionid AS partitionid, LHS.followers AS followers, RHS.n AS n FROM user_profiles AS LHS INNER JOIN (SELECT UID, COUNT(*) AS n FROM tweets GROUP BY UID) AS RHS ON (LHS.uid = RHS.uid)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 3)
('Charlie', 2)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid;

/*
Prediction Result:
('Alice', 3)
('Alice', 1)
('Charlie', 2)
*/