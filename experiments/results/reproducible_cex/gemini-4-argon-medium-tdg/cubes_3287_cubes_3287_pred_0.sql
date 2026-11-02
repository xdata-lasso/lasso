-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN, GROUP BY (followers, name), filtering n <> 1, and ORDER BY (name, count___).
-- Includes users with 0 tweets (to test INNER vs LEFT JOIN), 1 tweet (to test n <> 1 boundary), and >1 tweets.
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'Alice', 'alice@example.com', 1, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (2, 'Bob', 'bob@example.com', 1, 20);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (3, 'Charlie', 'charlie@example.com', 2, 30);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (4, 'Alice', 'alice2@example.com', 2, 50);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (101, 1, 'Hello world', '2023-01-01 10:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (102, 2, 'Tweet 1', '2023-01-01 11:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (103, 2, 'Tweet 2', '2023-01-01 12:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (104, 4, 'Alice 2 Tweet 1', '2023-01-01 13:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (105, 4, 'Alice 2 Tweet 2', '2023-01-01 14:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (106, 4, 'Alice 2 Tweet 3', '2023-01-01 15:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT followers, name, COUNT(*) AS n FROM (SELECT LHS.id AS id, LHS.uid AS UID, LHS.text AS text, LHS.createdate AS createdate, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM tweets AS LHS INNER JOIN user_profiles AS RHS ON (LHS.uid = RHS.uid)) GROUP BY followers, name) WHERE (n <> 1) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 3)
('Bob', 2)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid HAVING COUNT(*) > 1;

/*
Prediction Result:
('Bob', 2)
('Alice', 3)
*/