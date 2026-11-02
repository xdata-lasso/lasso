-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Alice', 'alice1@test.com', 10, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Alice', 'alice2@test.com', 20, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Charlie', 'charlie@test.com', 10, 0);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'Bob', 'bob@test.com', 30, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'David', 'david@test.com', 40, 2);
INSERT INTO tweets (id, uid, text, createdate) VALUES (5, 1, 'Alice1 tweet 1', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 1, 'Alice1 tweet 2', '2023-01-01 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 1, 'Alice1 tweet 3', '2023-01-01 12:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 2, 'Alice2 tweet 1', '2023-01-02 09:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (104, 3, 'Charlie tweet 1', '2023-01-03 08:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (105, 3, 'Charlie tweet 2', '2023-01-03 08:30:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (106, 4, 'Bob tweet 1', '2023-01-04 14:00:00');
INSERT INTO follows (f1, f2) VALUES (5, 1);
INSERT INTO follows (f1, f2) VALUES (5, 2);
INSERT INTO follows (f1, f2) VALUES (1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.uid AS UID, LHS.name AS name, LHS.email AS email, LHS.partitionid AS partitionid, LHS.followers AS followers, RHS.n AS n FROM user_profiles AS LHS INNER JOIN (SELECT UID, COUNT(*) AS n FROM tweets GROUP BY UID) AS RHS ON (LHS.uid = RHS.uid)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 3)
('Bob', 1)
('Charlie', 2)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid;

/*
Prediction Result:
('Alice', 3)
('Alice', 1)
('Charlie', 2)
('Bob', 1)
*/