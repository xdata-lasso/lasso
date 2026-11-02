-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 0, 0, NULL), (0, 0, 1, '2023-01-01'), (NULL, 0, 0, NULL), (NULL, 0, NULL, '2023-01-02'), (0, 0, NULL, NULL), (NULL, 1, 1, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT ID FROM (SELECT A.AUTHOR_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.AUTHOR_ID = B.VIEWER_ID AND A.ARTICLE_ID = B.ARTICLE_ID) AS ID GROUP BY ID ORDER BY ID ASC;

/*
Prediction Result:
(0,)
*/