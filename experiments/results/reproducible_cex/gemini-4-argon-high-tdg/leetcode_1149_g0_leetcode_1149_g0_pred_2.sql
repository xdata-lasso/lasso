-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 9
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 1, 1, '2020-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (10, 1, 1, '2020-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (20, 2, 2, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (21, 2, 2, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (30, NULL, 3, '2020-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (31, NULL, 3, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 INNER JOIN VIEWS AS V2 ON V1.VIEWER_ID = V2.VIEWER_ID AND V1.VIEW_DATE = V2.VIEW_DATE AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(3,)
*/