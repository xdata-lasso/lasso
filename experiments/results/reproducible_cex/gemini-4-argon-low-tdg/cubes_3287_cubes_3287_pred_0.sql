-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, grouping, HAVING/WHERE boundary (n=0, n=1, n=2, n=3), and INNER vs LEFT/RIGHT JOIN
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'ZeroTweets', 'z@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'OneTweet', 'o@test.com', 1, 20);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'TwoTweets', 't@test.com', 1, 30);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'ThreeTweets', 'th@test.com', 1, 40);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 2, 'Hello', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 3, 'Tweet 1', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 3, 'Tweet 2', '2023-01-02 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (104, 4, 'Msg 1', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (105, 4, 'Msg 2', '2023-01-02 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (106, 4, 'Msg 3', '2023-01-03 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (107, NULL, 'Orphan tweet', '2023-01-04 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (108, NULL, 'Orphan tweet 2', '2023-01-05 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT followers, name, COUNT(*) AS n FROM (SELECT LHS.id AS id, LHS.uid AS UID, LHS.text AS text, LHS.createdate AS createdate, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM tweets AS LHS INNER JOIN user_profiles AS RHS ON (LHS.uid = RHS.uid)) GROUP BY followers, name) WHERE (n <> 1) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('ThreeTweets', 3)
('TwoTweets', 2)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid HAVING COUNT(*) > 1;

/*
Prediction Result:
('TwoTweets', 2)
('ThreeTweets', 3)
*/