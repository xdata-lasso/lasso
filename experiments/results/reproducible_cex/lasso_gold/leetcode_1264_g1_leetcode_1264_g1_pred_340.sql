-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (1, 1);
INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (1001, 1002);
INSERT INTO "likes" ("user_id", "page_id") VALUES (1, NULL);
INSERT INTO "likes" ("user_id", "page_id") VALUES (1003, 1005);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT USER2_ID AS FRIEND_ID FROM FRIENDSHIP WHERE USER1_ID = 1 UNION SELECT USER1_ID AS FRIEND_ID FROM FRIENDSHIP WHERE USER2_ID = 1) SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L WHERE USER_ID IN (SELECT FRIEND_ID FROM CTE1) AND NOT EXISTS(SELECT 1 FROM LIKES WHERE USER_ID = 1 AND PAGE_ID = L.PAGE_ID);

/*
Prediction Result:
(None,)
*/