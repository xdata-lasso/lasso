-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Alice', 'alice1@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Alice', 'alice2@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Bob', 'common@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'Charlie', 'common@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'Duplicate', 'dup@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (6, 'Duplicate', 'dup@test.com', 2, 20);
INSERT INTO follows (f1, f2) VALUES (1, 3);
INSERT INTO follows (f1, f2) VALUES (2, 3);
INSERT INTO follows (f1, f2) VALUES (3, 1);
INSERT INTO follows (f1, f2) VALUES (4, 1);
INSERT INTO follows (f1, f2) VALUES (5, 1);
INSERT INTO follows (f1, f2) VALUES (6, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT email, name, COUNT(*) AS n FROM (SELECT f1, f2, name, email, partitionid, followers, f1 AS UID FROM (SELECT LHS.f1 AS f1, LHS.f2 AS f2, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM follows AS LHS INNER JOIN user_profiles AS RHS ON (LHS.f1 = RHS.uid))) GROUP BY email, name) WHERE (n > 1) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('Duplicate', 'dup@test.com')
*/

-- Prediction Query
SELECT T1.name, T1.email FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid = T2.f1 GROUP BY T2.f1 HAVING COUNT(*) > 1;

/*
Prediction Result:
*/