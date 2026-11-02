-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by text (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT),
-- and inner join mutations (orphaned tweets with NULL uid and users with multiple tweets).
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Alice', 'alice@example.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'Bob', 'bob@example.com', 1, 20);
INSERT INTO follows (f1, f2) VALUES (1, 2);
INSERT INTO tweets (id, uid, text, createdate) VALUES (10, 1, 'zebra', '2023-01-01 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (20, 1, 'apple', '2023-01-02 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (5, 2, 'apple', '2023-01-03 10:00:00');
INSERT INTO tweets (id, uid, text, createdate) VALUES (15, NULL, 'banana', '2023-01-04 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT text FROM tweets ORDER BY text, tweets.id NULLS LAST;

/*
Gold Result:
('apple',)
('apple',)
('banana',)
('zebra',)
*/

-- Prediction Query
SELECT text FROM tweets ORDER BY createdate, tweets.id NULLS LAST;

/*
Prediction Result:
('zebra',)
('apple',)
('apple',)
('banana',)
*/