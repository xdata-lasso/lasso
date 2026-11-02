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
WITH T AS (SELECT PAGE_ID FROM LIKES WHERE USER_ID IN (SELECT USER1_ID AS USER_ID FROM (SELECT USER1_ID, USER2_ID FROM FRIENDSHIP WHERE USER1_ID = 1 UNION SELECT USER2_ID AS USER1_ID, USER1_ID AS USER2_ID FROM FRIENDSHIP WHERE USER2_ID = 1) AS A) UNION SELECT PAGE_ID FROM LIKES WHERE USER_ID IN (SELECT USER2_ID AS USER_ID FROM (SELECT USER1_ID, USER2_ID FROM FRIENDSHIP WHERE USER1_ID = 1 UNION SELECT USER2_ID AS USER1_ID, USER1_ID AS USER2_ID FROM FRIENDSHIP WHERE USER2_ID = 1) AS A)) SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM T WHERE CASE WHEN PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1) THEN 0 ELSE 1 END;

/*
Prediction Result:
(None,)
*/