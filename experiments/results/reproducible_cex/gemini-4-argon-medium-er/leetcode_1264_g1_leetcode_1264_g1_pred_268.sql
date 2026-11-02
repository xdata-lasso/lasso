-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, 2);
INSERT INTO Likes (user_id, page_id) VALUES (1, NULL);
INSERT INTO Likes (user_id, page_id) VALUES (2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT USER1_ID AS U1, USER2_ID AS U2 FROM FRIENDSHIP WHERE USER1_ID = 1 OR USER2_ID = 1) SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM CTE AS C JOIN LIKES AS L ON U1 = USER_ID OR U2 = USER_ID WHERE NOT EXISTS(SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1 AND PAGE_ID = L.PAGE_ID);

/*
Prediction Result:
(None,)
(10,)
*/