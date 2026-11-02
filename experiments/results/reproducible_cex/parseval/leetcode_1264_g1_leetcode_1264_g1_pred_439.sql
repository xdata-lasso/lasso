-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: friendship --
INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (1, 2);

INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (-2147483647, 1);

INSERT INTO "friendship" ("user1_id", "user2_id") VALUES (1, -2147483646);

-- Inserting into table: likes --
INSERT INTO "likes" ("user_id", "page_id") VALUES (1, -2147483648);

INSERT INTO "likes" ("user_id", "page_id") VALUES (1, -2147483647);

INSERT INTO "likes" ("user_id", "page_id") VALUES (1, -2147483646);

INSERT INTO "likes" ("user_id", "page_id") VALUES (2, 2);

INSERT INTO "likes" ("user_id", "page_id") VALUES (-2147483646, 1);

INSERT INTO "likes" ("user_id", "page_id") VALUES (-2147483645, 1);

INSERT INTO "likes" ("user_id", "page_id") VALUES (-2147483644, 1);

INSERT INTO "likes" ("user_id", "page_id") VALUES (-2147483643, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(2,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT IIF(USER1_ID < USER2_ID, USER1_ID, USER2_ID) AS USER1_ID, IIF(USER1_ID > USER2_ID, USER1_ID, USER2_ID) AS USER2_ID FROM FRIENDSHIP) AS A JOIN LIKES AS B ON A.USER2_ID = B.USER_ID WHERE A.USER1_ID = 1 AND NOT B.PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Prediction Result:
(2,)
*/