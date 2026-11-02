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
SELECT DISTINCT A.VIEWER_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.VIEW_DATE = B.VIEW_DATE AND A.VIEWER_ID = B.VIEWER_ID GROUP BY A.VIEWER_ID, A.VIEW_DATE HAVING COUNT(DISTINCT A.ARTICLE_ID) > 1 ORDER BY A.VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
*/