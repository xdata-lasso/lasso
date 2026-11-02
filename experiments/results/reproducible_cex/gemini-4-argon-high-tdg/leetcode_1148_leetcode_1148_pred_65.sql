-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (100, 8, 8, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (100, 2, 2, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (200, 5, 5, '2021-06-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (200, 5, 5, '2021-06-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(2,)
(5,)
(8,)
*/

-- Prediction Query
SELECT DISTINCT V1.AUTHOR_ID AS ID FROM VIEWS AS V1 INNER JOIN VIEWS AS V2 ON V1.AUTHOR_ID = V2.VIEWER_ID AND V1.VIEWER_ID = V2.VIEWER_ID GROUP BY V1.ARTICLE_ID HAVING COUNT(V1.ARTICLE_ID) >= 1 ORDER BY V1.AUTHOR_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(5,)
(8,)
*/