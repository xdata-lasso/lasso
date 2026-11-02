-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Friendship" ("user1_id", "user2_id") VALUES (1, 30);
INSERT INTO "Friendship" ("user1_id", "user2_id") VALUES (31, 32);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (24, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT USER1_ID, USER2_ID, USER_ID AS MATCH_ID, PAGE_ID FROM (SELECT USER1_ID, USER2_ID FROM FRIENDSHIP UNION SELECT USER2_ID, USER1_ID FROM FRIENDSHIP) AS F CROSS JOIN LIKES AS L ON F.USER2_ID = L.USER_ID WHERE USER1_ID = 1) AS P WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Prediction Result:
*/