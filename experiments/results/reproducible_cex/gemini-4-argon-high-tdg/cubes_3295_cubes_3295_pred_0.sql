-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (10, 'Bob', 'z_bob@example.com', 100, 5000);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (30, 'Alice_Long_Name_Here', 'm_alice@example.com', 50, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (20, 'Zoe', 'h_zoe@example.com', 20, 250);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'Charlie', 'a_charlie@example.com', 1, 100);
INSERT INTO follows (f1, f2) VALUES (10, 30);
INSERT INTO follows (f1, f2) VALUES (30, 5);
INSERT INTO follows (f1, f2) VALUES (5, 10);
INSERT INTO tweets (id, uid, text, createdate) VALUES (1, 10, 'Hello world', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (2, 30, 'Another tweet', '2023-01-02 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM user_profiles ORDER BY name DESC, user_profiles.uid NULLS LAST) LIMIT 1);

/*
Gold Result:
('Zoe',)
*/

-- Prediction Query
SELECT name FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bob',)
*/