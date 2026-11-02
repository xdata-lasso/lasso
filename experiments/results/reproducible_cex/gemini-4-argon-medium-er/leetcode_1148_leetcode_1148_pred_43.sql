-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 1, 1, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT (AUTHOR_ID) AS ID FROM VIEWS AS T1 WHERE EXISTS(SELECT * FROM VIEWS AS T2 WHERE T1.ARTICLE_ID = T2.ARTICLE_ID AND T1.AUTHOR_ID = T2.VIEWER_ID) ORDER BY ID;

/*
Prediction Result:
*/