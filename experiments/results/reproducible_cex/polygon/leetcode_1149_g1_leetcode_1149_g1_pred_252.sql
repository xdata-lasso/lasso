-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (13, 22, 22, '1000-01-20');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 22, 22, '1000-01-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT VIEWER_ID, VIEW_DATE, ARTICLE_ID, COUNT(VIEWER_ID) AS AMT1 FROM VIEWS GROUP BY 1, 2, 3), T2 AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(VIEWER_ID) AS AMT2 FROM T1 GROUP BY 1, 2) SELECT DISTINCT (VIEWER_ID) AS ID FROM T2 WHERE AMT2 > 1 ORDER BY 1 ASC, ID NULLS LAST;

/*
Prediction Result:
(22,)
*/