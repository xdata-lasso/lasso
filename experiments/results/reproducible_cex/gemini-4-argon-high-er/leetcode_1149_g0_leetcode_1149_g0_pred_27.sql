-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, '2023-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 1, 1, '2023-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, '2023-01-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 1, 1, '2023-01-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 1, 1, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT SUB.ID FROM (SELECT DISTINCT VIEWER_ID AS ID, COUNT(DISTINCT ARTICLE_ID) AS NUM_ARTICLE FROM VIEWS GROUP BY ID, VIEW_DATE) AS SUB WHERE SUB.NUM_ARTICLE > 1 ORDER BY ID, SUB.ID NULLS LAST;

/*
Prediction Result:
(1,)
(1,)
*/