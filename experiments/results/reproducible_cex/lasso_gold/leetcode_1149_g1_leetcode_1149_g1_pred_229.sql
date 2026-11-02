-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1001, 1003, 1005, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1004.0, 1008.0, 1012.0, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1007, 1009, 1005, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1010.0, 1014.0, 1012.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1005,)
(1012,)
*/

-- Prediction Query
WITH TT AS (SELECT *, LEAD(VIEW_DATE) OVER (PARTITION BY VIEWER_ID ORDER BY VIEW_DATE, ARTICLE_ID) AS NEXTREAD_DATE, LEAD(ARTICLE_ID) OVER (PARTITION BY VIEWER_ID ORDER BY VIEW_DATE, ARTICLE_ID) AS NEXTREAD_ARTICLE FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM TT WHERE NEXTREAD_DATE = VIEW_DATE AND NEXTREAD_ARTICLE <> ARTICLE_ID;

/*
Prediction Result:
*/