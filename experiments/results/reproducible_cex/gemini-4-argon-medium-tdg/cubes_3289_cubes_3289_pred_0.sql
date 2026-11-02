-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Alice', 'alice2@example.com', 1, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Alice', 'alice1@example.com', 1, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Bob', 'bob@example.com', 2, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'Alice', 'alice4@example.com', 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, followers FROM user_profiles ORDER BY name, user_profiles.uid NULLS LAST;

/*
Gold Result:
('Alice', 100)
('Alice', 50)
('Alice', 100)
('Bob', 10)
*/

-- Prediction Query
SELECT name, followers FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST;

/*
Prediction Result:
('Alice', 100)
('Alice', 100)
('Alice', 50)
('Bob', 10)
*/