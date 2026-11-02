-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1005, 'Leslie Johnson', 'robinsonwilliam@example.org', 1006, 1007);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1009, NULL, 'shaneramirez@example.org', 1010, 1011);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1008, 1005, 'option', '1971-02-02');
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (1012, 1009, 'song', '1972-03-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.uid AS UID, LHS.name AS name, LHS.email AS email, LHS.partitionid AS partitionid, LHS.followers AS followers, RHS.n AS n FROM user_profiles AS LHS INNER JOIN (SELECT UID, COUNT(*) AS n FROM tweets GROUP BY UID) AS RHS ON (LHS.uid = RHS.uid)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Leslie Johnson', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid = T2.uid GROUP BY T2.uid;

/*
Prediction Result:
('Leslie Johnson', 1)
(None, 1)
*/