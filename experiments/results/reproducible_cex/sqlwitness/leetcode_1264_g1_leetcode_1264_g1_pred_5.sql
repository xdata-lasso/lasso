-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO likes (user_id, page_id) VALUES (0, 1), (2, 2), (0, 0);
INSERT INTO friendship (user1_id, user2_id) VALUES (1, 0), (1, 2), (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(1,)
(2,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT L.PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT USER2_ID AS FRIEND FROM FRIENDSHIP WHERE USER1_ID = 1 UNION SELECT USER1_ID AS FRIEND FROM FRIENDSHIP WHERE USER2_ID = 1) AS F JOIN LIKES AS L ON F.FRIEND = L.USER_ID WHERE NOT L.PAGE_ID IN (SELECT DISTINCT PAGE_ID FROM LIKES WHERE USER_ID = 1) ORDER BY 1, RECOMMENDED_PAGE NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/