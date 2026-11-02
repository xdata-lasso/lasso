-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Friendship" ("user1_id", "user2_id") VALUES (37, 1);
INSERT INTO "Friendship" ("user1_id", "user2_id") VALUES (1, 35);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (35, 36);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (37, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(36,)
*/

-- Prediction Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L WHERE USER_ID IN (SELECT USER2_ID FROM FRIENDSHIP AS F WHERE USER1_ID = 1) AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES AS L WHERE USER_ID = 1) UNION ALL SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L WHERE USER_ID IN (SELECT USER1_ID FROM FRIENDSHIP AS F WHERE USER2_ID = 1) AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES AS L WHERE USER_ID = 1);

/*
Prediction Result:
(36,)
(36,)
*/