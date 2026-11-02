-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (10, 'Alice', 'alice@example.com', 1, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (20, 'Bob', 'bob@example.com', 1, 200);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (30, 'Charlie', 'charlie@example.com', 2, 300);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (40, 'Diana', 'diana@example.com', 2, 400);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (50, 'Eve', 'eve@example.com', 3, 500);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (60, 'Frank', 'frank@example.com', 3, 0);
INSERT INTO follows (f1, f2) VALUES (10, 20);
INSERT INTO follows (f1, f2) VALUES (10, 30);
INSERT INTO follows (f1, f2) VALUES (10, 50);
INSERT INTO follows (f1, f2) VALUES (20, 50);
INSERT INTO follows (f1, f2) VALUES (30, 40);
INSERT INTO follows (f1, f2) VALUES (30, 50);
INSERT INTO follows (f1, f2) VALUES (40, 50);
INSERT INTO follows (f1, f2) VALUES (40, 60);
INSERT INTO tweets (id, uid, text, createdate) VALUES (1, 10, 'Hello world', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (2, 10, 'Second tweet', '2023-01-02 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (3, 50, 'Eve tweet', '2023-01-03 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT f1, COUNT(*) AS n FROM follows GROUP BY f1) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM follows GROUP BY f1;

/*
Prediction Result:
(3,)
(1,)
(2,)
(2,)
*/