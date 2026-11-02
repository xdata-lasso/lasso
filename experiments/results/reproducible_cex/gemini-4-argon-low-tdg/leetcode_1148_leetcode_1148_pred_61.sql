-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (10, 50, 50, '2023-03-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (20, 10, 10, '2023-03-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (30, 30, 30, '2023-03-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(10,)
(30,)
(50,)
*/

-- Prediction Query
SELECT DISTINCT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY ARTICLE_ID;

/*
Prediction Result:
(50,)
(10,)
(30,)
*/