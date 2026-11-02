-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT/OUTER JOIN (users with 0 tweets),
-- duplicate names with different UIDs (GROUP BY name vs GROUP BY uid),
-- duplicate names with identical tweet counts (SELECT DISTINCT vs SELECT),
-- and secondary sorting on count___ when names are equal.
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Alice', 'alice1@test.com', 10, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Alice', 'alice2@test.com', 20, 200);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Bob', 'bob1@test.com', 10, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'Bob', 'bob2@test.com', 30, 60);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'Charlie', 'charlie@test.com', 10, 10);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 1, 'Hello world', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 1, 'Second tweet', '2023-01-02 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 1, 'Third tweet', '2023-01-03 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (104, 2, 'Alice 2 tweet', '2023-01-01 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (105, 3, 'Bob 1 tweet', '2023-01-01 12:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (106, 4, 'Bob 2 tweet', '2023-01-01 13:00:00');
INSERT INTO follows (f1, f2) VALUES (1, 2);
INSERT INTO follows (f1, f2) VALUES (2, 3);
INSERT INTO follows (f1, f2) VALUES (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.uid AS UID, LHS.name AS name, LHS.email AS email, LHS.partitionid AS partitionid, LHS.followers AS followers, RHS.n AS n FROM user_profiles AS LHS INNER JOIN (SELECT UID, COUNT(*) AS n FROM tweets GROUP BY UID) AS RHS ON (LHS.uid = RHS.uid)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 3)
('Bob', 1)
('Bob', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid;

/*
Prediction Result:
('Alice', 3)
('Alice', 1)
('Bob', 1)
('Bob', 1)
*/