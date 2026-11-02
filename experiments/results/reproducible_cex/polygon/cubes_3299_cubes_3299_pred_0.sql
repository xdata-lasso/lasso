-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(followers) OVER () AS max_followers_, sumfollowers AS sum_followers_ FROM (SELECT UID, name, email, partitionid, followers, SUM(followers) OVER () AS sumfollowers FROM user_profiles) ORDER BY max_followers_, sum_followers_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(followers), SUM(followers) FROM user_profiles;

/*
Prediction Result:
(None, None)
*/