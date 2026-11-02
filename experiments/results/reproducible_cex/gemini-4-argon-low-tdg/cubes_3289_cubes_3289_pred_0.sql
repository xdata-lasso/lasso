-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Charlie', 'c@example.com', 10, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Alice', 'a1@example.com', 20, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Alice', 'a2@example.com', 5, 200);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'Bob', 'b@example.com', 15, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, followers FROM user_profiles ORDER BY name, user_profiles.uid NULLS LAST;

/*
Gold Result:
('Alice', 200)
('Alice', 50)
('Bob', 75)
('Charlie', 100)
*/

-- Prediction Query
SELECT name, followers FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST;

/*
Prediction Result:
('Alice', 200)
('Charlie', 100)
('Bob', 75)
('Alice', 50)
*/