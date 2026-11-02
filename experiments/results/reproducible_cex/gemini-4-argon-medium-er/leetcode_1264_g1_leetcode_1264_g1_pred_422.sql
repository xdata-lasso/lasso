-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Friendship" ("user1_id", "user2_id") VALUES (1, 2);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (1, NULL);
INSERT INTO "Likes" ("user_id", "page_id") VALUES (2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT L.PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L LEFT JOIN FRIENDSHIP AS F1 ON L.USER_ID = F1.USER1_ID LEFT JOIN FRIENDSHIP AS F2 ON L.USER_ID = F2.USER2_ID WHERE (F1.USER1_ID = 1 OR F1.USER2_ID = 1) OR (F2.USER1_ID = 1 OR F2.USER2_ID = 1) GROUP BY L.PAGE_ID HAVING SUM(CASE WHEN L.USER_ID = 1 THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(10,)
*/