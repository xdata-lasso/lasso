-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, 2);
INSERT INTO Friendship (user1_id, user2_id) VALUES (3, 4);
INSERT INTO Likes (user_id, page_id) VALUES (1, NULL);
INSERT INTO Likes (user_id, page_id) VALUES (2, 300);
INSERT INTO Likes (user_id, page_id) VALUES (2, NULL);
INSERT INTO Likes (user_id, page_id) VALUES (NULL, 301);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT CASE WHEN USER1_ID = 1 THEN USER2_ID WHEN USER2_ID = 1 THEN USER1_ID ELSE NULL END AS USER_ID FROM FRIENDSHIP) AS TB1 JOIN LIKES AS TB2 ON TB1.USER_ID = TB2.USER_ID WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT L.PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L LEFT JOIN FRIENDSHIP AS F1 ON L.USER_ID = F1.USER1_ID LEFT JOIN FRIENDSHIP AS F2 ON L.USER_ID = F2.USER2_ID WHERE (F1.USER1_ID = 1 OR F1.USER2_ID = 1) OR (F2.USER1_ID = 1 OR F2.USER2_ID = 1) GROUP BY L.PAGE_ID HAVING SUM(L.USER_ID = 1) = 0;

/*
Prediction Result:
(300,)
*/