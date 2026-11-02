-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (13, 18, NULL, '1000-01-18');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (14, 18, NULL, '1000-01-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT V.VIEWER_ID, COUNT(DISTINCT V.ARTICLE_ID) AS ART_CNT, V.VIEW_DATE FROM VIEWS AS V GROUP BY VIEWER_ID, VIEW_DATE) SELECT DISTINCT T1.VIEWER_ID AS ID FROM T1 WHERE T1.ART_CNT > 1 ORDER BY ID;

/*
Prediction Result:
(None,)
*/