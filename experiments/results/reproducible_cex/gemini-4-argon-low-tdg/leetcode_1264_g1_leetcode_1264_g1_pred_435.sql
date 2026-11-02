-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 10
INSERT INTO Friendship (user1_id, user2_id) VALUES (0, 1);
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, -1);
INSERT INTO Likes (user_id, page_id) VALUES (0, 0);
INSERT INTO Likes (user_id, page_id) VALUES (-1, -10);
INSERT INTO Likes (user_id, page_id) VALUES (1, -10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT IIF(USER1_ID < USER2_ID, USER1_ID, USER2_ID) AS USER1_ID, IIF(USER1_ID > USER2_ID, USER1_ID, USER2_ID) AS USER2_ID FROM FRIENDSHIP) AS A JOIN LIKES AS B ON A.USER2_ID = B.USER_ID WHERE A.USER1_ID = 1 AND NOT B.PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Prediction Result:
*/