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

INSERT INTO "likes" ("user_id", "page_id") VALUES (2, 2);

INSERT INTO "likes" ("user_id", "page_id") VALUES (-2147483646, 1);

INSERT INTO "likes" ("user_id", "page_id") VALUES (-2147483645, 1);

INSERT INTO "likes" ("user_id", "page_id") VALUES (-2147483644, 1);

INSERT INTO "likes" ("user_id", "page_id") VALUES (-2147483643, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT CASE WHEN USER1_ID = 1 THEN USER2_ID WHEN USER2_ID = 1 THEN USER1_ID ELSE NULL END AS USER_ID FROM FRIENDSHIP) AS TB1 JOIN LIKES AS TB2 ON TB1.USER_ID = TB2.USER_ID WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Gold Result:
(2,)
(1,)
*/

-- Prediction Query
WITH F AS (SELECT CASE WHEN USER1_ID < USER2_ID THEN USER1_ID ELSE USER2_ID END AS USER1_ID, CASE WHEN USER1_ID < USER2_ID THEN USER2_ID ELSE USER1_ID END AS USER2_ID FROM FRIENDSHIP) SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM F JOIN LIKES AS L ON F.USER2_ID = L.USER_ID WHERE USER1_ID = 1 AND NOT PAGE_ID IN (SELECT DISTINCT PAGE_ID FROM LIKES AS L WHERE USER_ID = 1);

/*
Prediction Result:
(2,)
*/