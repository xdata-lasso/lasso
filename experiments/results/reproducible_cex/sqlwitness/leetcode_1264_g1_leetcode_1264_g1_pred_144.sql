-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO likes (user_id, page_id) VALUES (1, 1), (0, 2), (2, 1), (2, 2);
INSERT INTO friendship (user1_id, user2_id) VALUES (0, 1), (-1000, -998), (1, 2), (-1000, -995), (2, 1), (-1000, -999), (-1000, -996), (2, 0), (-1000, -993), (0, 2), (-1000, -994), (1, 0), (-1000, -997);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT l.page_id AS recommended_page FROM Likes AS l JOIN Friendship AS f ON (l.user_id = f.user2_id AND f.user1_id = 1) OR (l.user_id = f.user1_id AND f.user2_id = 1) WHERE NOT l.page_id IN (SELECT page_id FROM likes WHERE user_id = 1);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT DISTINCT PAGE_ID FROM LIKES JOIN FRIENDSHIP ON LIKES.USER_ID = FRIENDSHIP.USER2_ID WHERE USER1_ID = 1 AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1) UNION ALL SELECT DISTINCT PAGE_ID FROM LIKES JOIN FRIENDSHIP ON LIKES.USER_ID = FRIENDSHIP.USER1_ID WHERE USER2_ID = 1 AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1)) AS T1 ORDER BY PAGE_ID, RECOMMENDED_PAGE NULLS LAST;

/*
Prediction Result:
(2,)
(2,)
*/