-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (13, 17, NULL, NULL);
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (12, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT A.VIEWER_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.VIEWER_ID = B.VIEWER_ID AND A.ARTICLE_ID <> B.ARTICLE_ID AND A.VIEW_DATE = B.VIEW_DATE GROUP BY A.VIEWER_ID HAVING COUNT(A.VIEWER_ID) > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
*/