-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (101, 30, 30, '2020-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (205, 10, 10, '2020-05-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (205, 10, 10, '2020-05-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (206, 10, 10, '2020-05-03');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (20, 20, 40, '2020-02-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (60, 70, 60, '2020-03-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (205, 10, 99, '2020-05-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(10,)
(30,)
*/

-- Prediction Query
SELECT DISTINCT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY ARTICLE_ID;

/*
Prediction Result:
(30,)
(10,)
*/