-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Zack', 'zack@example.com', 10, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Alice', 'alice@example.com', 20, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Bob', 'bob@example.com', 30, 50);
INSERT INTO follows (f1, f2) VALUES (2, 3);
INSERT INTO follows (f1, f2) VALUES (3, 2);
INSERT INTO follows (f1, f2) VALUES (3, 3);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 2, 'Hello world', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 2, 'Second tweet', '2023-01-02 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 3, 'Bob tweet 1', '2023-01-03 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (104, 3, 'Bob tweet 2', '2023-01-04 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (105, 3, 'Bob tweet 3', '2023-01-05 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.uid AS UID, LHS.name AS name, LHS.email AS email, LHS.partitionid AS partitionid, LHS.followers AS followers, RHS.followers AS followers_other FROM user_profiles AS LHS CROSS JOIN (SELECT MAX(followers) AS followers FROM user_profiles) AS RHS) WHERE (followers >= followers_other) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zack',)
*/