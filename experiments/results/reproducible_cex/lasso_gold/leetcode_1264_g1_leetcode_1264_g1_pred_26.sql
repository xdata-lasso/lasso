-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (2, 2);
INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (1002, 1003);
INSERT INTO "likes" ("user_id", "page_id") VALUES (2, 1001);
INSERT INTO "likes" ("user_id", "page_id") VALUES (1004, 1006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT B.USER_ID, B.PAGE_ID FROM FRIENDSHIP AS A LEFT OUTER JOIN LIKES AS B ON (A.USER2_ID = B.USER_ID OR A.USER1_ID = B.USER_ID) AND (A.USER1_ID = 1 OR A.USER2_ID = 1) WHERE NOT B.PAGE_ID IN (SELECT DISTINCT PAGE_ID FROM LIKES WHERE USER_ID = 1)) AS T;

/*
Prediction Result:
(None,)
*/