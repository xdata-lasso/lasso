-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, 2);
INSERT INTO Friendship (user1_id, user2_id) VALUES (3, 1);
INSERT INTO Friendship (user1_id, user2_id) VALUES (2, 4);
INSERT INTO Likes (user_id, page_id) VALUES (1, 100);
INSERT INTO Likes (user_id, page_id) VALUES (2, 100);
INSERT INTO Likes (user_id, page_id) VALUES (2, 200);
INSERT INTO Likes (user_id, page_id) VALUES (3, 200);
INSERT INTO Likes (user_id, page_id) VALUES (3, 300);
INSERT INTO Likes (user_id, page_id) VALUES (4, 400);
INSERT INTO Likes (user_id, page_id) VALUES (5, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(200,)
(300,)
*/

-- Prediction Query
SELECT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT DISTINCT PAGE_ID FROM LIKES JOIN FRIENDSHIP ON LIKES.USER_ID = FRIENDSHIP.USER2_ID WHERE USER1_ID = 1 AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1) UNION ALL SELECT DISTINCT PAGE_ID FROM LIKES JOIN FRIENDSHIP ON LIKES.USER_ID = FRIENDSHIP.USER1_ID WHERE USER2_ID = 1 AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1)) AS T1 ORDER BY PAGE_ID, RECOMMENDED_PAGE NULLS LAST;

/*
Prediction Result:
(200,)
(200,)
(300,)
*/