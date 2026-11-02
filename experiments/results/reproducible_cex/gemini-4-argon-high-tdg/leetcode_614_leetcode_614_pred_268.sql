-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO follow (followee, follower) VALUES ('2', '10');
INSERT INTO follow (followee, follower) VALUES ('2', '1');
INSERT INTO follow (followee, follower) VALUES ('2', 'alice');
INSERT INTO follow (followee, follower) VALUES ('2', 'Alice');
INSERT INTO follow (followee, follower) VALUES ('10', 'u1');
INSERT INTO follow (followee, follower) VALUES ('10', 'u2');
INSERT INTO follow (followee, follower) VALUES ('1', 'u1');
INSERT INTO follow (followee, follower) VALUES ('alice', 'u1');
INSERT INTO follow (followee, follower) VALUES ('alice', 'u2');
INSERT INTO follow (followee, follower) VALUES ('alice', 'u3');
INSERT INTO follow (followee, follower) VALUES ('Alice', 'u1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('1', 1)
('10', 2)
('Alice', 1)
('alice', 3)
*/

-- Prediction Query
SELECT A.FOLLOWER, COUNT(DISTINCT B.FOLLOWER) AS NUM FROM FOLLOW AS A JOIN FOLLOW AS B ON A.FOLLOWER LIKE B.FOLLOWEE GROUP BY A.FOLLOWER;

/*
Prediction Result:
('1', 1)
('10', 2)
('Alice', 3)
('alice', 3)
*/