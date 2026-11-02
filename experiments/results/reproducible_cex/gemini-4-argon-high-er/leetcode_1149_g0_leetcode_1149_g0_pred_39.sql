-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT (VIEWER_ID) AS ID FROM VIEWS WHERE (VIEWER_ID, VIEW_DATE) IN (SELECT VIEWER_ID, VIEW_DATE FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(DISTINCT (ARTICLE_ID)) >= 2) ORDER BY ID;

/*
Prediction Result:
*/