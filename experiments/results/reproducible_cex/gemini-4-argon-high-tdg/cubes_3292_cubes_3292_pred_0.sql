-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (25, 'Iron Man', 'tony1@stark.com', 10, 500);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (50, 'Iron Man', 'tony2@stark.com', 5, 100);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (15, 'Iron Man', 'tony3@stark.com', 10, 300);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (40, 'Iron Man', 'tony4@stark.com', NULL, 200);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (10, 'iron man', 'lower@stark.com', 1, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (20, 'Iron Man 2', 'sequel@stark.com', 2, 60);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (30, NULL, 'nullname@stark.com', 3, 70);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (35, 'Captain America', 'Iron Man', 4, 80);
INSERT INTO follows (f1, f2) VALUES (25, 50);
INSERT INTO follows (f1, f2) VALUES (25, 10);
INSERT INTO follows (f1, f2) VALUES (10, 25);
INSERT INTO tweets (id, uid, text, createdate) VALUES (101, 25, 'I am Iron Man', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (102, 25, 'Suit up', '2023-01-02 11:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (103, 10, 'Iron Man', '2023-01-03 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "uid" AS "partitionid" FROM "user_profiles" WHERE ("name" = 'Iron Man') ORDER BY partitionid, user_profiles.uid NULLS LAST;

/*
Gold Result:
(15,)
(25,)
(40,)
(50,)
*/

-- Prediction Query
SELECT partitionid FROM user_profiles WHERE name = 'Iron Man';

/*
Prediction Result:
(10,)
(5,)
(10,)
(None,)
*/