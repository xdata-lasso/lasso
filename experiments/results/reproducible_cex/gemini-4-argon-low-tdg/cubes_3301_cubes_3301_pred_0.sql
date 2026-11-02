-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE boundary conditions (999, 1000, 1001, 0, NULL) and primary ORDER BY (name)
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Charlie', 'charlie@example.com', 1, 1000);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Alice', 'alice@example.com', 1, 1001);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Bob', 'bob@example.com', 1, 999);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'David', 'david@example.com', 2, 0);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'Eve', 'eve@example.com', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM user_profiles WHERE (followers >= 1000) ORDER BY name, user_profiles.uid NULLS LAST;

/*
Gold Result:
('Alice', 'alice@example.com')
('Charlie', 'charlie@example.com')
*/

-- Prediction Query
SELECT name, email FROM user_profiles WHERE followers > 1000;

/*
Prediction Result:
('Alice', 'alice@example.com')
*/