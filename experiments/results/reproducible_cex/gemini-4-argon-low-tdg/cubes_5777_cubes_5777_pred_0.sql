-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Charlie', 'charlie@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Alice', 'alice2@test.com', 1, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Alice', NULL, 2, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'Alice', 'alice1@test.com', 2, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'Bob', 'bob@test.com', 1, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (6, 'Dave', 'dave@test.com', 3, NULL);
INSERT INTO follows (f1, f2) VALUES (1, 2);
INSERT INTO follows (f1, f2) VALUES (1, 3);
INSERT INTO follows (f1, f2) VALUES (2, 3);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 2, 'Hello world', '2023-01-01 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT LHS.followers AS followers, RHS.uid AS UID, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers_other FROM (SELECT MIN(followers) AS followers FROM user_profiles) AS LHS CROSS JOIN user_profiles AS RHS) WHERE (followers >= followers_other) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('Alice', 'alice1@test.com')
('Alice', 'alice2@test.com')
('Alice', None)
('Bob', 'bob@test.com')
*/

-- Prediction Query
SELECT name, email FROM user_profiles ORDER BY followers, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Dave', 'dave@test.com')
*/