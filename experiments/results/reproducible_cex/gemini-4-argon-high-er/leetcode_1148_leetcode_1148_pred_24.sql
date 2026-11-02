-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, '2023-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 2, 2, '2023-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 2, 2, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY AUTHOR_ID ORDER BY COUNT(DISTINCT ARTICLE_ID) DESC, ID NULLS LAST;

/*
Prediction Result:
(2,)
(1,)
*/