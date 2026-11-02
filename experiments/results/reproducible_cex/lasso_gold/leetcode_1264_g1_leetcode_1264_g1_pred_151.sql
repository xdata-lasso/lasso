-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (1, 0);
INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (1031, 1032);
INSERT INTO "likes" ("user_id", "page_id") VALUES (0, 1030);
INSERT INTO "likes" ("user_id", "page_id") VALUES (1033, 1035);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(1030,)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT (CASE WHEN A.USER1_ID <= A.USER2_ID THEN A.USER1_ID ELSE A.USER2_ID END) AS USER1, (CASE WHEN A.USER1_ID > A.USER2_ID THEN A.USER1_ID ELSE A.USER2_ID END) AS USER2 FROM FRIENDSHIP AS A) SELECT DISTINCT L.PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT * FROM CTE WHERE USER1 = 1 AND USER1 <> USER2) AS C INNER JOIN LIKES AS L ON C.USER2 = L.USER_ID WHERE NOT L.PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Prediction Result:
*/