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
SELECT DISTINCT (AUTHOR_ID) AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY ARTICLE_ID, VIEW_DATE ORDER BY ID;

/*
Prediction Result:
(5,)
(8,)
*/