-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Zoe', 'zoe@example.com', 10, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Bob', 'bob@example.com', 30, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Alice', 'alice@example.com', 20, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'Charlie', 'charlie@example.com', 40, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'David', 'david@example.com', 50, 200);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 1, 'Zoe tweet 1', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 1, 'Zoe tweet 2', '2023-01-01 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 2, 'Bob tweet 1', '2023-01-02 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (104, 2, 'Bob tweet 2', '2023-01-02 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (105, 2, 'Bob tweet 3', '2023-01-02 12:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (106, 3, 'Alice tweet 1', '2023-01-03 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (107, 3, 'Alice tweet 2', '2023-01-03 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (108, 3, 'Alice tweet 3', '2023-01-03 12:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (109, 3, 'Alice tweet 4', '2023-01-03 13:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (110, 4, 'Charlie single tweet', '2023-01-04 10:00:00');
INSERT INTO follows (f1, f2) VALUES (4, 1);
INSERT INTO follows (f1, f2) VALUES (4, 2);
INSERT INTO follows (f1, f2) VALUES (5, 1);
INSERT INTO follows (f1, f2) VALUES (5, 2);
INSERT INTO follows (f1, f2) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT followers, name, COUNT(*) AS n FROM (SELECT LHS.id AS id, LHS.uid AS UID, LHS.text AS text, LHS.createdate AS createdate, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM tweets AS LHS INNER JOIN user_profiles AS RHS ON (LHS.uid = RHS.uid)) GROUP BY followers, name) WHERE (n <> 1) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Zoe',)
*/

-- Prediction Query
SELECT T1.name FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid HAVING COUNT(*) > 1;

/*
Prediction Result:
('Zoe',)
('Bob',)
('Alice',)
*/