-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Friendship" ("user1_id", "user2_id") VALUES (1, 2);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (2, 10);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH FRIEND AS (SELECT USER1_ID AS ID, USER2_ID AS FRIEND FROM FRIENDSHIP UNION SELECT USER2_ID AS ID, USER1_ID AS FRIEND FROM FRIENDSHIP) SELECT * FROM (SELECT DISTINCT L.PAGE_ID AS RECOMMENDED_PAGE FROM FRIEND AS F LEFT JOIN LIKES AS L ON F.FRIEND = L.USER_ID LEFT JOIN LIKES AS L2 ON F.ID = L2.USER_ID AND L.PAGE_ID = L2.PAGE_ID WHERE L2.USER_ID IS NULL AND F.ID = 1) AS A WHERE NOT RECOMMENDED_PAGE IS NULL;

/*
Prediction Result:
(10,)
*/