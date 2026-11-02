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
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT CASE WHEN USER1_ID = 1 THEN USER2_ID WHEN USER2_ID = 1 THEN USER1_ID ELSE NULL END AS USER_ID FROM FRIENDSHIP) AS TB1 JOIN LIKES AS TB2 ON TB1.USER_ID = TB2.USER_ID WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Gold Result:
(1030,)
*/

-- Prediction Query
SELECT DISTINCT (PAGE_ID) AS RECOMMENDED_PAGE FROM LIKES AS L JOIN (SELECT MAX(USER1_ID, USER2_ID) AS USR FROM FRIENDSHIP WHERE MIN(USER1_ID, USER2_ID) = 1) AS B ON L.USER_ID = B.USR AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Prediction Result:
*/