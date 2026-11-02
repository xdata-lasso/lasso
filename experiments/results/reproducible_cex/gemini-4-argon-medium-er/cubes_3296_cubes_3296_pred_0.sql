-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'Alice', 'alice@example.com', 1, 10);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1, 1, 'B', '2020-01-01 00:00:00');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (2, 1, 'A', '2020-01-02 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT text FROM tweets ORDER BY text, tweets.id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT text FROM tweets ORDER BY createdate, tweets.id NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/