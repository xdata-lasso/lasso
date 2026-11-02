-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (10, NULL, NULL, '2022-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (20, 5, NULL, '2022-08-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (30, NULL, 5, '2022-08-03');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 0, 0, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (40, -5, -5, '2022-08-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(-5,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT O.AUTHOR_ID AS ID FROM VIEWS AS O WHERE EXISTS(SELECT I.VIEWER_ID FROM VIEWS AS I WHERE (I.AUTHOR_ID = I.VIEWER_ID) AND (I.ARTICLE_ID = O.ARTICLE_ID)) ORDER BY O.AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
(-5,)
*/