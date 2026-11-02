-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (9, 9, NULL, '1000-01-07');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (9, 9, NULL, '1000-01-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT VIEWER_ID, ARTICLE_ID, VIEW_DATE, DENSE_RANK() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY ARTICLE_ID) AS NUM FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM TEMP GROUP BY VIEWER_ID HAVING MAX(NUM) > 1 ORDER BY VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
*/