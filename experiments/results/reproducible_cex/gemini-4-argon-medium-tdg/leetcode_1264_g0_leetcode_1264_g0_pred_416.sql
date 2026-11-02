-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
-- Tests boundary values (0, negative integers) and checks if a mutant hardcodes different user IDs (e.g., user 2 instead of user 1)
-- or confuses page_id with user_id (e.g., page_id = 1).
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, 0);
INSERT INTO Friendship (user1_id, user2_id) VALUES (-1, 1);
INSERT INTO Friendship (user1_id, user2_id) VALUES (2, 1);
INSERT INTO Likes (user_id, page_id) VALUES (1, 2);
INSERT INTO Likes (user_id, page_id) VALUES (0, 1);
INSERT INTO Likes (user_id, page_id) VALUES (-1, 1);
INSERT INTO Likes (user_id, page_id) VALUES (-1, 2);
INSERT INTO Likes (user_id, page_id) VALUES (2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT CASE WHEN USER1_ID = 1 THEN USER2_ID WHEN USER2_ID = 1 THEN USER1_ID ELSE NULL END AS USER_ID FROM FRIENDSHIP) AS TB1 JOIN LIKES AS TB2 ON TB1.USER_ID = TB2.USER_ID WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Gold Result:
(1,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT L.PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT DISTINCT MIN(USER1_ID, USER2_ID) AS U1, MAX(USER1_ID, USER2_ID) AS U2 FROM FRIENDSHIP) AS F CROSS JOIN LIKES AS L WHERE U1 = 1 AND F.U2 = L.USER_ID AND NOT L.PAGE_ID IN (SELECT DISTINCT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Prediction Result:
(0,)
*/