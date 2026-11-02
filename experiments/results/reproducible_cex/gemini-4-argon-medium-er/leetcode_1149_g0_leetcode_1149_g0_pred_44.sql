-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 10, '2023-01-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 2, 10, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(ARTICLE_ID) OVER (PARTITION BY VIEWER_ID, VIEW_DATE) AS N_ART FROM (SELECT DISTINCT * FROM VIEWS) AS SUB) SELECT DISTINCT VIEWER_ID AS ID FROM T WHERE N_ART >= 2 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(10,)
*/