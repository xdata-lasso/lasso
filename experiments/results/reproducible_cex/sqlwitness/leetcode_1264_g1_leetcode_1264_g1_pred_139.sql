-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO likes (user_id, page_id) VALUES (0, 0), (2, 2);
INSERT INTO friendship (user1_id, user2_id) VALUES (0, 2), (1, 0), (-1000, -998), (-1000, -992), (-1000, -995), (0, 1), (1, 2), (2, 1), (-1000, -999), (-1000, -996), (-1000, -993), (2, 0), (-1000, -994), (-1000, -997), (-1000, -991);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES WHERE NOT PAGE_ID IN (SELECT DISTINCT PAGE_ID FROM LIKES WHERE USER_ID = 1) AND USER_ID IN (SELECT IIF(USER1_ID > USER2_ID, USER1_ID, USER2_ID) AS USER2_ID FROM FRIENDSHIP WHERE USER1_ID = 1 OR USER2_ID = 1);

/*
Prediction Result:
(2,)
*/