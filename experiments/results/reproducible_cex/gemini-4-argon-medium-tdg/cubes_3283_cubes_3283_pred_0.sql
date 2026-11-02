-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests GROUP BY (email, name) vs GROUP BY (uid).
-- Two distinct users share the exact same name and email, each following only 1 person.
-- Combined under GROUP BY (email, name), their count n = 2. Under GROUP BY uid, each has n = 1.
-- Also tests two users with same name but different emails, and same email but different names.
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (1, 'SameName', 'same@test.com', 1, 10);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (2, 'SameName', 'same@test.com', 2, 20);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (3, 'SameName', 'diff@test.com', 1, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (4, 'DiffName', 'same@test.com', 1, 5);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (5, 'Target1', 't1@test.com', 1, 0);
INSERT INTO user_profiles (uid, name, email, partitionid, followers) VALUES (6, 'Target2', 't2@test.com', 1, 0);
-- uid 1 follows 1 person, uid 2 follows 1 person. Together ('SameName', 'same@test.com') has n = 2.
INSERT INTO follows (f1, f2) VALUES (1, 5);
INSERT INTO follows (f1, f2) VALUES (2, 6);
-- uid 3 has SameName but different email (follows 1 person -> n=1 if grouped by both, n=3 if grouped only by name)
INSERT INTO follows (f1, f2) VALUES (3, 5);
-- uid 4 has different name but same@test.com (follows 1 person -> n=1 if grouped by both, n=3 if grouped only by email)
INSERT INTO follows (f1, f2) VALUES (4, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT email, name, COUNT(*) AS n FROM (SELECT f1, f2, name, email, partitionid, followers, f1 AS UID FROM (SELECT LHS.f1 AS f1, LHS.f2 AS f2, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM follows AS LHS INNER JOIN user_profiles AS RHS ON (LHS.f1 = RHS.uid))) GROUP BY email, name) WHERE (n > 1) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('SameName', 'same@test.com')
*/

-- Prediction Query
SELECT T1.name, T1.email FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid = T2.f1 GROUP BY T2.f1 HAVING COUNT(*) > 1;

/*
Prediction Result:
*/