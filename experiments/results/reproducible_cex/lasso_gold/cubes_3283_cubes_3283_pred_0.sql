-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1013, 'Angie Henderson', 'davisjesse@example.net', 1016, 1019);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1014, 'Angie Henderson', 'davisjesse@example.net', 1025.0, 1030.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1015, 'Angie Henderson', 'davisjesse@example.net', 1034.0, 1041.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1025, 'Cristian Santos', 'lrobinson@example.com', 1028, 1031);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1026, 'Cristian Santos', 'lrobinson@example.com', 1037.0, 1042.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1027, 'Cristian Santos', 'lrobinson@example.com', 1046.0, 1053.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1037, 'Cristian Santos', 'lrobinson@example.com', 1040, 1043);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1038, 'Cristian Santos', 'lrobinson@example.com', 1049.0, 1054.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1039, 'Cristian Santos', 'lrobinson@example.com', 1058.0, 1065.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1022, NULL, NULL, NULL, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1023, NULL, NULL, NULL, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1024, NULL, NULL, NULL, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1046, NULL, NULL, NULL, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1047, NULL, NULL, NULL, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1048, NULL, NULL, NULL, NULL);
INSERT INTO "follows" ("f1", "f2") VALUES (1013, 1022);
INSERT INTO "follows" ("f1", "f2") VALUES (1013, 1023);
INSERT INTO "follows" ("f1", "f2") VALUES (1013, 1024);
INSERT INTO "follows" ("f1", "f2") VALUES (1025, NULL);
INSERT INTO "follows" ("f1", "f2") VALUES (1025, NULL);
INSERT INTO "follows" ("f1", "f2") VALUES (1025, NULL);
INSERT INTO "follows" ("f1", "f2") VALUES (1037, 1046);
INSERT INTO "follows" ("f1", "f2") VALUES (1037, 1047);
INSERT INTO "follows" ("f1", "f2") VALUES (1037, 1048);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT email, name, COUNT(*) AS n FROM (SELECT f1, f2, name, email, partitionid, followers, f1 AS UID FROM (SELECT LHS.f1 AS f1, LHS.f2 AS f2, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM follows AS LHS INNER JOIN user_profiles AS RHS ON (LHS.f1 = RHS.uid))) GROUP BY email, name) WHERE (n > 1) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('Angie Henderson', 'davisjesse@example.net')
('Cristian Santos', 'lrobinson@example.com')
*/

-- Prediction Query
SELECT T1.name, T1.email FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid = T2.f1 GROUP BY T2.f1 HAVING COUNT(*) > 1;

/*
Prediction Result:
('Angie Henderson', 'davisjesse@example.net')
('Cristian Santos', 'lrobinson@example.com')
('Cristian Santos', 'lrobinson@example.com')
*/