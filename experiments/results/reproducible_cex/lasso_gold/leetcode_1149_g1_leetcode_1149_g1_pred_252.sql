-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1245, 1247, 1249, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1248.0, 1252.0, 1256.0, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1251, 1253, 1249, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1254.0, 1258.0, 1256.0, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1245, 1247, 1255, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 1252.0, 1255, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1249,)
(1256,)
*/

-- Prediction Query
WITH T1 AS (SELECT VIEWER_ID, VIEW_DATE, ARTICLE_ID, COUNT(VIEWER_ID) AS AMT1 FROM VIEWS GROUP BY 1, 2, 3), T2 AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(VIEWER_ID) AS AMT2 FROM T1 GROUP BY 1, 2) SELECT DISTINCT (VIEWER_ID) AS ID FROM T2 WHERE AMT2 > 1 ORDER BY 1 ASC, ID NULLS LAST;

/*
Prediction Result:
(1249,)
(1255,)
(1256,)
*/