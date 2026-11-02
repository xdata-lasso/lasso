-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'SilentOne', 'silent1@example.com', 1, 50);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'SilentTwo', 'silent2@example.com', 2, 80);
INSERT INTO follows (f1, f2) VALUES (1, 2);
INSERT INTO tweets (id, uid, text, createdate) VALUES (1, NULL, 'Unassigned tweet', '2023-05-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(followers) OVER () AS avg_followers_ FROM (SELECT * FROM user_profiles AS LHS WHERE EXISTS(SELECT 1 FROM tweets AS RHS WHERE (LHS.uid = RHS.uid))) ORDER BY avg_followers_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(followers) FROM user_profiles WHERE UID IN (SELECT UID FROM tweets);

/*
Prediction Result:
(None,)
*/