-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, NULL, NULL, '2023-05-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 10, NULL, '2023-05-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, NULL, 10, '2023-05-03');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (4, 10, 10, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 20, 20, '2023-05-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY 1 HAVING COUNT(DISTINCT ARTICLE_ID) >= 1 ORDER BY AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
(10,)
*/