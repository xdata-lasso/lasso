-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Friendship (user1_id, user2_id) VALUES (0, 1);
INSERT INTO Friendship (user1_id, user2_id) VALUES (2, 1);
INSERT INTO Likes (user_id, page_id) VALUES (1, 50);
INSERT INTO Likes (user_id, page_id) VALUES (0, 50);
INSERT INTO Likes (user_id, page_id) VALUES (0, 60);
INSERT INTO Likes (user_id, page_id) VALUES (2, 70);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(60,)
(70,)
*/

-- Prediction Query
WITH FRIENDS1 AS (SELECT USER1_ID AS USER1, USER2_ID AS USER2 FROM FRIENDSHIP UNION SELECT USER2_ID AS USER1, USER1_ID AS USER2 FROM FRIENDSHIP), FRIENDS2 AS (SELECT DISTINCT USER1, USER2 FROM FRIENDS1 WHERE USER2 > USER1 ORDER BY USER1, USER2) SELECT DISTINCT L.PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L JOIN FRIENDS2 AS F ON L.USER_ID = F.USER2 WHERE F.USER1 = 1 AND NOT L.PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Prediction Result:
(70,)
*/