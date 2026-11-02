-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (10, 11, 15, '1000-01-13');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (13, 14, 15, '1000-01-13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(15,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT DISTINCT VIEWER_ID, ROW_NUMBER() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY ARTICLE_ID) AS RN FROM (SELECT DISTINCT * FROM VIEWS) AS A) AS B WHERE RN > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(15,)
*/