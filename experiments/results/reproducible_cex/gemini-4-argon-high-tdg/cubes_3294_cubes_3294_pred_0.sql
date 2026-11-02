-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Mary', 'z_mary@example.com', 20, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Mary', 'a_mary@example.com', 30, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Mary', 'm_mary@example.com', 10, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'Mary', 'a_mary@example.com', 40, 25);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'Alice', 'alice@example.com', 10, 20);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (6, 'Zoe', 'zoe@example.com', 20, 30);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (7, 'Bob', 'Mary', 10, 15);
INSERT INTO follows (f1, f2) VALUES (1, 2);
INSERT INTO follows (f1, f2) VALUES (1, 5);
INSERT INTO follows (f1, f2) VALUES (5, 1);
INSERT INTO follows (f1, f2) VALUES (6, 1);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 1, 'Hello world', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 1, 'Second tweet', '2023-01-02 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 5, 'Alice tweet', '2023-01-03 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "email" FROM "user_profiles" WHERE ("name" = 'Mary') ORDER BY email, user_profiles.uid NULLS LAST;

/*
Gold Result:
('a_mary@example.com',)
('a_mary@example.com',)
('m_mary@example.com',)
('z_mary@example.com',)
*/

-- Prediction Query
SELECT email FROM user_profiles WHERE name = 'Mary';

/*
Prediction Result:
('z_mary@example.com',)
('a_mary@example.com',)
('m_mary@example.com',)
('a_mary@example.com',)
*/