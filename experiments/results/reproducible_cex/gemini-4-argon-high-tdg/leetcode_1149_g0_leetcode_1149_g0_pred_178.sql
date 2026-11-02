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
SELECT DISTINCT (T1.VIEWER_ID) AS ID FROM VIEWS AS T1 JOIN VIEWS AS T2 ON T1.VIEWER_ID = T2.VIEWER_ID WHERE T1.ARTICLE_ID <> T2.ARTICLE_ID AND T1.VIEW_DATE = T2.VIEW_DATE ORDER BY ID;

/*
Prediction Result:
(3,)
*/