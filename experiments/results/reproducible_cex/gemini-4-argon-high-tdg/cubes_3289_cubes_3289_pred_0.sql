-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'Charlie', 'charlie@example.com', 1, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (30, 'Alice', 'b_alice@example.com', 2, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Bob', 'bob@example.com', 3, 75);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (10, 'Alice', 'c_alice@example.com', 3, 200);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (20, 'Alice', 'a_alice@example.com', 1, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, followers FROM user_profiles ORDER BY name, user_profiles.uid NULLS LAST;

/*
Gold Result:
('Alice', 200)
('Alice', 300)
('Alice', 100)
('Bob', 75)
('Charlie', 50)
*/

-- Prediction Query
SELECT name, followers FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST;

/*
Prediction Result:
('Alice', 300)
('Alice', 200)
('Alice', 100)
('Bob', 75)
('Charlie', 50)
*/