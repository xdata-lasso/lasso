-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2023-01-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, 1, 1, '2023-01-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 2, 2, '2023-01-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 3, 2, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT AUTHOR_ID, VIEWER_ID, VIEW_DATE, RANK() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY AUTHOR_ID, ARTICLE_ID) AS RNK FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM TEMP WHERE RNK >= 2;

/*
Prediction Result:
(1,)
(2,)
*/