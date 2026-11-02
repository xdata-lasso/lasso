-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 100, 10, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 101, 10, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 100, 20, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 101, 20, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 100, NULL, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 101, NULL, '2019-08-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE FROM VIEWS), T2 AS (SELECT T1.VIEW_DATE, T1.VIEWER_ID AS VD, COUNT(T1.VIEWER_ID) AS CVID FROM T1 GROUP BY 1, 2) SELECT DISTINCT T2.VD AS ID FROM T2 WHERE CVID > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(10,)
(20,)
*/