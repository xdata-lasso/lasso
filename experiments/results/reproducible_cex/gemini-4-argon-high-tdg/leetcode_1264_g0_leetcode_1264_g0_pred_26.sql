-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 8
INSERT INTO Friendship (user1_id, user2_id) VALUES (0, 5);
INSERT INTO Friendship (user1_id, user2_id) VALUES (-1, 6);
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, 2);
INSERT INTO Friendship (user1_id, user2_id) VALUES (2, 3);
INSERT INTO Likes (user_id, page_id) VALUES (5, 50);
INSERT INTO Likes (user_id, page_id) VALUES (6, 60);
INSERT INTO Likes (user_id, page_id) VALUES (2, 20);
INSERT INTO Likes (user_id, page_id) VALUES (3, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT CASE WHEN USER1_ID = 1 THEN USER2_ID WHEN USER2_ID = 1 THEN USER1_ID ELSE NULL END AS USER_ID FROM FRIENDSHIP) AS TB1 JOIN LIKES AS TB2 ON TB1.USER_ID = TB2.USER_ID WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT B.USER_ID, B.PAGE_ID FROM FRIENDSHIP AS A LEFT OUTER JOIN LIKES AS B ON (A.USER2_ID = B.USER_ID OR A.USER1_ID = B.USER_ID) AND (A.USER1_ID = 1 OR A.USER2_ID = 1) WHERE NOT B.PAGE_ID IN (SELECT DISTINCT PAGE_ID FROM LIKES WHERE USER_ID = 1)) AS T;

/*
Prediction Result:
(None,)
(20,)
*/