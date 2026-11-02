-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting (0, 1, 2, 3 tweets), INNER JOIN vs OUTER JOIN (user with 0 tweets),
-- WHERE n <> 1 vs n > 1 / n >= 2 / n = 1, and ORDER BY name ASC vs DESC / insertion order.
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Charlie', 'c@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Alice', 'a@test.com', 1, 20);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Bob', 'b@test.com', 1, 30);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'David', 'd@test.com', 1, 40);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 1, 'C1', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 1, 'C2', '2023-01-01 10:01:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 1, 'C3', '2023-01-01 10:02:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (104, 2, 'A1', '2023-01-01 10:03:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (105, 2, 'A2', '2023-01-01 10:04:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (106, 3, 'B1', '2023-01-01 10:05:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT followers, name, COUNT(*) AS n FROM (SELECT LHS.id AS id, LHS.uid AS UID, LHS.text AS text, LHS.createdate AS createdate, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM tweets AS LHS INNER JOIN user_profiles AS RHS ON (LHS.uid = RHS.uid)) GROUP BY followers, name) WHERE (n <> 1) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.name FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid HAVING COUNT(*) > 1;

/*
Prediction Result:
('Charlie',)
('Alice',)
*/