-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Friendship" ("user1_id", "user2_id") VALUES (21, 22);
INSERT INTO "Friendship" ("user1_id", "user2_id") VALUES (1, 28);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (1, 23);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (28, 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE_FRIENDS AS (SELECT CASE WHEN USER1_ID = 1 THEN USER2_ID WHEN USER2_ID = 1 THEN USER1_ID END AS USER_ID FROM FRIENDSHIP WHERE USER1_ID = 1 OR USER2_ID = 1), ALREADY_LIKED AS (SELECT DISTINCT PAGE_ID FROM LIKES WHERE USER_ID = 1), PAGES_REC AS (SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES INNER JOIN CTE_FRIENDS AS CF ON LIKES.USER_ID = CF.USER_ID WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM ALREADY_LIKED)) SELECT * FROM PAGES_REC;

/*
Prediction Result:
*/