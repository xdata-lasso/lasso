-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, NULL, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 2, NULL, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 1, 11, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 2, 11, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 11, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 1, 12, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 12, '2021-06-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 2, 12, '2021-06-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, VIEW_DATE, COALESCE(COUNT(DISTINCT ARTICLE_ID), 0) AS CNT FROM VIEWS GROUP BY 1, 2) AS A WHERE CNT > 1;

/*
Prediction Result:
(None,)
(12,)
*/