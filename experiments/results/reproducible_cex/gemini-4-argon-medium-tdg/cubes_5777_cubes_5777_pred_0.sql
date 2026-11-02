-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests multiple minimum ties, NULL followers, NULL emails (for NULLS LAST), and ordering by name then email.
-- Also tests join traps with follows and tweets where actual follower counts differ from the 'followers' column.
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'Bob', 'bob2@test.com', 10, 5);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (2, 'Alice', 'alice@test.com', 10, 5);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (3, 'Bob', NULL, 20, 5);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (4, 'Bob', 'bob1@test.com', 20, 5);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (5, 'Charlie', 'charlie@test.com', 10, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (6, 'David', 'david@test.com', 30, NULL);
INSERT INTO "follows" ("f1", "f2") VALUES (1, 5);
INSERT INTO "follows" ("f1", "f2") VALUES (2, 5);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (101, 1, 'Hello world', '2023-01-01 10:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (102, 5, 'Another tweet', '2023-01-02 11:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT LHS.followers AS followers, RHS.uid AS UID, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers_other FROM (SELECT MIN(followers) AS followers FROM user_profiles) AS LHS CROSS JOIN user_profiles AS RHS) WHERE (followers >= followers_other) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('Alice', 'alice@test.com')
('Bob', 'bob1@test.com')
('Bob', 'bob2@test.com')
('Bob', None)
*/

-- Prediction Query
SELECT name, email FROM user_profiles ORDER BY followers, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('David', 'david@test.com')
*/