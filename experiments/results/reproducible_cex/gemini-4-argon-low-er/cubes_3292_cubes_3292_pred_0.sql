-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'Iron Man', 'tony@stark.com', 2, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "uid" AS "partitionid" FROM "user_profiles" WHERE ("name" = 'Iron Man') ORDER BY partitionid, user_profiles.uid NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT partitionid FROM user_profiles WHERE name = 'Iron Man';

/*
Prediction Result:
(2,)
*/