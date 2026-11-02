-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Alice', 'alice@example.com', 10, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Bob', 'bob@example.com', 20, 0);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'Charlie', 'charlie@example.com', 10, 12);
INSERT INTO follows (f1, f2) VALUES (1, 2);
INSERT INTO follows (f1, f2) VALUES (1, 3);
INSERT INTO tweets (id, uid, text, createdate) VALUES (10, 3, 'zebra', '2023-01-01 08:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (20, 1, 'apple', '2023-01-04 08:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (30, 2, 'mango', '2023-01-02 08:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (5, 1, 'apple', '2023-01-03 08:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT text FROM tweets ORDER BY text, tweets.id NULLS LAST;

/*
Gold Result:
('apple',)
('apple',)
('mango',)
('zebra',)
*/

-- Prediction Query
SELECT text FROM tweets ORDER BY createdate, tweets.id NULLS LAST;

/*
Prediction Result:
('zebra',)
('mango',)
('apple',)
('apple',)
*/