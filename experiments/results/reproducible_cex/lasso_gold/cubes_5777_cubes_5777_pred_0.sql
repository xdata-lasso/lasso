-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1038, 'Kimberly Burgess', 'hernandezernest@example.net', 1041, 1044);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1039, 'Kevin Cox', 'ycarlson@example.com', 1050.0, 1055.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1040, 'Brenda Snyder PhD', 'jrice@example.org', 1059.0, 1066.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1047, 'Ashley Dyer', 'teresa28@example.org', 1050, 1053);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1048, 'Patricia Peterson', 'meagan89@example.org', 1059.0, 1064.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1049, 'Christopher Smith', 'nathanielmartin@example.net', 1068.0, 1075.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1056, 'Linda Burns', 'millertodd@example.org', 1059, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1057, 'Jack Galloway', 'davidalvarez@example.net', 1068.0, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1058, 'Cynthia Allen', 'josephbrennan@example.com', 1077.0, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1065, 'Tanya Campos', 'omartinez@example.org', 1068, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1066, 'Michelle Ross', 'andrew83@example.net', 1077.0, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1067, 'Jacqueline Lam', 'adrianzimmerman@example.org', 1086.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT LHS.followers AS followers, RHS.uid AS UID, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers_other FROM (SELECT MIN(followers) AS followers FROM user_profiles) AS LHS CROSS JOIN user_profiles AS RHS) WHERE (followers >= followers_other) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('Kimberly Burgess', 'hernandezernest@example.net')
*/

-- Prediction Query
SELECT name, email FROM user_profiles ORDER BY followers, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Linda Burns', 'millertodd@example.org')
*/