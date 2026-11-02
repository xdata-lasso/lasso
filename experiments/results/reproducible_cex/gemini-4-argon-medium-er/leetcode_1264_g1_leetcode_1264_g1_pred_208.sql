-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, 0);
INSERT INTO Likes (user_id, page_id) VALUES (0, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(10,)
*/

-- Prediction Query
WITH NEW AS (SELECT CASE WHEN USER1_ID < USER2_ID THEN USER1_ID WHEN USER1_ID > USER2_ID THEN USER2_ID END AS USER1, CASE WHEN USER1_ID < USER2_ID THEN USER2_ID WHEN USER1_ID > USER2_ID THEN USER1_ID END AS USER2 FROM FRIENDSHIP) SELECT DISTINCT L.PAGE_ID AS RECOMMENDED_PAGE FROM NEW AS N JOIN LIKES AS L ON N.USER2 = L.USER_ID WHERE NOT L.PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1) AND N.USER1 = 1 ORDER BY L.PAGE_ID, RECOMMENDED_PAGE NULLS LAST;

/*
Prediction Result:
*/