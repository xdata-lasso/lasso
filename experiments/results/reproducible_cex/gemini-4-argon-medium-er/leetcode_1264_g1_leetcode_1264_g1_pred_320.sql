-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, 2);
INSERT INTO Likes (user_id, page_id) VALUES (2, 10);
INSERT INTO Likes (user_id, page_id) VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES JOIN (SELECT USER2_ID AS USER_ID FROM FRIENDSHIP WHERE USER1_ID = 1 UNION SELECT USER1_ID AS USER_ID FROM FRIENDSHIP WHERE USER2_ID = 1) AS SPECIFICUSER USING (USER_ID) JOIN LIKES AS SUBLIKES USING (PAGE_ID) GROUP BY PAGE_ID HAVING SUM(IIF(SUBLIKES.USER_ID = 1, TRUE, FALSE)) = FALSE;

/*
Prediction Result:
(10,)
*/