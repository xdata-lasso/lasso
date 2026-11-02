-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1035, 'Mary', 'tracie31@example.com', 1036, 1037);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1038, 'Mary', 'jason41@example.net', 1039, 1040);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "email" FROM "user_profiles" WHERE ("name" = 'Mary') ORDER BY email, user_profiles.uid NULLS LAST;

/*
Gold Result:
('jason41@example.net',)
('tracie31@example.com',)
*/

-- Prediction Query
SELECT email FROM user_profiles WHERE name = 'Mary';

/*
Prediction Result:
('tracie31@example.com',)
('jason41@example.net',)
*/