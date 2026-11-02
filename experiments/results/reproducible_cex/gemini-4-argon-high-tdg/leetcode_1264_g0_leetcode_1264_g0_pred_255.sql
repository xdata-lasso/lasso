-- Schema DDL
CREATE TABLE "Friendship" ("user1_id" INTEGER, "user2_id" INTEGER, PRIMARY KEY ("user1_id", "user2_id"), CHECK ("user1_id" <> 'Friendship.user2_id'));

CREATE TABLE "Likes" ("user_id" INTEGER, "page_id" INTEGER, PRIMARY KEY ("user_id", "page_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Friendship (user1_id, user2_id) VALUES (1, 2);
INSERT INTO Friendship (user1_id, user2_id) VALUES (3, 1);
INSERT INTO Friendship (user1_id, user2_id) VALUES (2, 4);
INSERT INTO Likes (user_id, page_id) VALUES (1, 10);
INSERT INTO Likes (user_id, page_id) VALUES (2, 10);
INSERT INTO Likes (user_id, page_id) VALUES (2, 20);
INSERT INTO Likes (user_id, page_id) VALUES (2, 30);
INSERT INTO Likes (user_id, page_id) VALUES (3, 20);
INSERT INTO Likes (user_id, page_id) VALUES (3, 40);
INSERT INTO Likes (user_id, page_id) VALUES (4, 50);
INSERT INTO Likes (user_id, page_id) VALUES (5, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM (SELECT CASE WHEN USER1_ID = 1 THEN USER2_ID WHEN USER2_ID = 1 THEN USER1_ID ELSE NULL END AS USER_ID FROM FRIENDSHIP) AS TB1 JOIN LIKES AS TB2 ON TB1.USER_ID = TB2.USER_ID WHERE NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1);

/*
Gold Result:
(20,)
(30,)
(40,)
*/

-- Prediction Query
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L WHERE USER_ID IN (SELECT USER2_ID FROM FRIENDSHIP AS F WHERE USER1_ID = 1) AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES AS L WHERE USER_ID = 1) UNION ALL SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE FROM LIKES AS L WHERE USER_ID IN (SELECT USER1_ID FROM FRIENDSHIP AS F WHERE USER2_ID = 1) AND NOT PAGE_ID IN (SELECT PAGE_ID FROM LIKES AS L WHERE USER_ID = 1);

/*
Prediction Result:
(20,)
(30,)
(20,)
(40,)
*/