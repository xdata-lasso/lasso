-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1011, 'Jennifer Cole', 'lisa02@example.net', 1014, 1017);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1012, 'Jennifer Cole', 'jpeterson@example.org', 1023.0, 1017);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1013, 'Jennifer Cole', 'curtis61@example.com', 1032.0, 1017);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1021, 'Andrew Stevens', 'dudleynicholas@example.net', 1024, 1027);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1022, 'Andrew Stevens', 'maria95@example.net', 1033.0, 1027);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1023, 'Andrew Stevens', 'janetwilliams@example.org', 1042.0, 1027);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1018, 1011, 'throw', '1973-04-04');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1019, 1011, 'guy', '1973-04-05');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1020, 1011, 'PM', '1973-04-06');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1028, 1021, NULL, '1976-07-07');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1029, 1021, NULL, '1976-07-08');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1030, 1021, NULL, '1976-07-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT followers, name, COUNT(*) AS n FROM (SELECT LHS.id AS id, LHS.uid AS UID, LHS.text AS text, LHS.createdate AS createdate, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM tweets AS LHS INNER JOIN user_profiles AS RHS ON (LHS.uid = RHS.uid)) GROUP BY followers, name) WHERE (n <> 1) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Andrew Stevens', 3)
('Jennifer Cole', 3)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid HAVING COUNT(*) > 1;

/*
Prediction Result:
('Jennifer Cole', 3)
('Andrew Stevens', 3)
*/