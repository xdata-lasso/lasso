-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1001, 'Allison Hill', 'hoffmanjennifer@example.net', 1005, 1009);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1002, 'Noah Rhodes', 'lrobinson@example.com', 1014.0, 1020.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1003, 'Angie Henderson', 'blakeerik@example.com', 1023.0, 1031.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1004, 'Daniel Wagner', 'joshua35@example.org', 1032.0, 1042.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM user_profiles ORDER BY name DESC, user_profiles.uid NULLS LAST) LIMIT 1);

/*
Gold Result:
('Noah Rhodes',)
*/

-- Prediction Query
SELECT name FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner',)
*/