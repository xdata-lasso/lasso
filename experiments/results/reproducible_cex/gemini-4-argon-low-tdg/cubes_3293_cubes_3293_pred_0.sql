-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'ZeroTweets', 'z@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'OneTweet', 'o@test.com', 1, 20);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'TwoTweets', 't@test.com', 1, 30);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'ThreeTweets', 'th@test.com', 1, 40);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 2, 'Only one', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 3, 'First of two', '2023-01-01 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 3, 'Second of two', '2023-01-01 12:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (104, 4, 'First of three', '2023-01-01 13:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (105, 4, 'Second of three', '2023-01-01 14:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (106, 4, 'Third of three', '2023-01-01 15:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT followers, name, COUNT(*) AS n FROM (SELECT LHS.id AS id, LHS.uid AS UID, LHS.text AS text, LHS.createdate AS createdate, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM tweets AS LHS INNER JOIN user_profiles AS RHS ON (LHS.uid = RHS.uid)) GROUP BY followers, name) WHERE (n <> 1) ORDER BY name;

/*
Gold Result:
('ThreeTweets',)
('TwoTweets',)
*/

-- Prediction Query
SELECT T1.name FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid HAVING COUNT(*) > 1;

/*
Prediction Result:
('TwoTweets',)
('ThreeTweets',)
*/