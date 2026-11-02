-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1005, 'Angie Henderson', 'davisjesse@example.net', 1006, 1007);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1009, 'Cristian Santos', 'lrobinson@example.com', 1010, 1011);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1016, 'Abigail Shaffer', 'jpeterson@example.org', 1013, 1014);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1008, NULL, NULL, NULL, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1012, NULL, NULL, NULL, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1015, NULL, NULL, NULL, NULL);
INSERT INTO "follows" ("f1", "f2") VALUES (1005, 1008);
INSERT INTO "follows" ("f1", "f2") VALUES (NULL, 1012);
INSERT INTO "follows" ("f1", "f2") VALUES (NULL, 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT f1, COUNT(*) AS n FROM follows GROUP BY f1) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM follows GROUP BY f1;

/*
Prediction Result:
(2,)
(1,)
*/