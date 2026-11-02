-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping by f1 vs grouping by f2 (f1 counts: 3, 2, 1, 1; f2 counts: 2, 2, 2, 1)
-- 2. Ordering by count___ ASC vs DESC vs ordering by f1 (f1=10 has count 3, f1=20 has count 2, f1=30 and f1=40 have count 1)
-- 3. Duplicate count preservation (SELECT vs SELECT DISTINCT: count 1 appears twice)
-- 4. Unreferenced users in user_profiles (uid 50) to kill mutants doing LEFT JOIN from user_profiles (which would yield 0 or extra 1s)
-- 5. Conflicting 'followers' column values in user_profiles to kill mutants querying user_profiles.followers instead of counting follows
-- 6. Conflicting tweets table counts to kill mutants querying tweets instead of follows
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (10, 'Alice', 'alice@example.com', 1, 99);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (20, 'Bob', 'bob@example.com', 1, 88);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (30, 'Charlie', 'charlie@example.com', 2, 77);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (40, 'David', 'david@example.com', 2, 66);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (50, 'Eve', 'eve@example.com', 3, 55);
INSERT INTO follows (f1, f2) VALUES (10, 20);
INSERT INTO follows (f1, f2) VALUES (10, 30);
INSERT INTO follows (f1, f2) VALUES (10, 40);
INSERT INTO follows (f1, f2) VALUES (20, 10);
INSERT INTO follows (f1, f2) VALUES (20, 30);
INSERT INTO follows (f1, f2) VALUES (30, 10);
INSERT INTO follows (f1, f2) VALUES (40, 20);
INSERT INTO tweets (id, uid, text, createdate) VALUES (1, 50, 'Tweet 1', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (2, 50, 'Tweet 2', '2023-01-01 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (3, 50, 'Tweet 3', '2023-01-01 12:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (4, 50, 'Tweet 4', '2023-01-01 13:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT f1, COUNT(*) AS n FROM follows GROUP BY f1) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM follows GROUP BY f1;

/*
Prediction Result:
(3,)
(2,)
(1,)
(1,)
*/