-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('14', '15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
WITH SECOND_DEGREE AS (SELECT DISTINCT A.FOLLOWEE AS SECOND_DEGREE FROM FOLLOW AS A INNER JOIN FOLLOW AS B ON A.FOLLOWEE = B.FOLLOWER), GROUP_COUNT AS (SELECT C.SECOND_DEGREE AS FOLLOWER, COUNT(*) AS NUM FROM SECOND_DEGREE AS C INNER JOIN FOLLOW AS D ON C.SECOND_DEGREE = D.FOLLOWEE GROUP BY C.SECOND_DEGREE ORDER BY C.SECOND_DEGREE, FOLLOWER NULLS LAST, NUM NULLS LAST) SELECT * FROM GROUP_COUNT;

/*
Prediction Result:
*/