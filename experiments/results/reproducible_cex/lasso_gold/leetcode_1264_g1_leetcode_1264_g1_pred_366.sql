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
WITH FRIENDSHIP_TABLE AS (SELECT CASE WHEN USER1_ID < USER2_ID THEN USER1_ID ELSE USER2_ID END AS USER1_ID, CASE WHEN USER1_ID > USER2_ID THEN USER1_ID ELSE USER2_ID END AS USER2_ID FROM FRIENDSHIP) SELECT DISTINCT T2.PAGE_ID AS RECOMMENDED_PAGE FROM FRIENDSHIP_TABLE AS T1 JOIN LIKES AS T2 ON T1.USER2_ID = T2.USER_ID WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1) AND T1.USER1_ID = 1;

/*
Prediction Result:
*/