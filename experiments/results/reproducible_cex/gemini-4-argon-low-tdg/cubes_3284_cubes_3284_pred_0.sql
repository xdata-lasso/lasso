-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (10, 'Alice', 'a@test.com', 1, 99);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (20, 'Bob', 'b@test.com', 1, 88);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (30, 'Charlie', 'c@test.com', 2, 77);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (40, 'David', 'd@test.com', 2, 66);
INSERT INTO follows (f1, f2) VALUES (30, 10);
INSERT INTO follows (f1, f2) VALUES (10, 20);
INSERT INTO follows (f1, f2) VALUES (10, 30);
INSERT INTO follows (f1, f2) VALUES (10, 40);
INSERT INTO follows (f1, f2) VALUES (20, 10);
INSERT INTO follows (f1, f2) VALUES (20, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT f1, COUNT(*) AS n FROM follows GROUP BY f1) ORDER BY count___;

/*
Gold Result:
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
*/