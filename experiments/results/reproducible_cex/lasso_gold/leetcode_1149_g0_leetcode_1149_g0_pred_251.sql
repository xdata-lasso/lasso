-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1092, 1094, NULL, '1985-05-16');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1093, 1099.0, NULL, '1985-05-16');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1097, 1099, NULL, '1986-06-17');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1098, 1104.0, NULL, '1986-06-17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH T1 AS (SELECT VIEWER_ID, VIEW_DATE, ARTICLE_ID, COUNT(VIEWER_ID) AS AMT1 FROM VIEWS GROUP BY 1, 2, 3), T2 AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(VIEWER_ID) AS AMT2 FROM T1 GROUP BY 1, 2) SELECT DISTINCT (VIEWER_ID) AS ID FROM T2 WHERE AMT2 > 1 ORDER BY 1 ASC, ID NULLS LAST;

/*
Prediction Result:
*/