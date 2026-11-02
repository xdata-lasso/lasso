-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO likes (user_id, page_id) VALUES (0, 1), (1, 1), (2, 2);
INSERT INTO friendship (user1_id, user2_id) VALUES (1, 2), (2, 1), (0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH FRIENDS_OF AS (SELECT CASE WHEN USER1_ID = '1' THEN USER2_ID WHEN USER2_ID = '1' THEN USER1_ID END AS FRIENDS_OF FROM FRIENDSHIP WHERE '1' IN (USER1_ID, USER2_ID)) SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L JOIN FRIENDS_OF AS F ON L.USER_ID = F.FRIENDS_OF WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = '1');

/*
Prediction Result:
*/