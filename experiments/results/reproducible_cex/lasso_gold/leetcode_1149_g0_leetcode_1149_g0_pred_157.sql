-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1082, 1084, 1086, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1083, 1089.0, 1086, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1087, 1089, 1091, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1088, 1094.0, 1091, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1086,)
(1091,)
*/

-- Prediction Query
WITH CTE AS (SELECT VIEW_DATE, VIEWER_ID FROM VIEWS GROUP BY 1, 2 HAVING (COUNT(1) > 1)), CTE1 AS (SELECT C1.VIEW_DATE, C2.VIEWER_ID, C1.ARTICLE_ID FROM VIEWS AS C1 CROSS JOIN CTE AS C2 WHERE C1.VIEW_DATE = C2.VIEW_DATE AND C1.VIEWER_ID = C2.VIEWER_ID) SELECT DISTINCT C1.VIEWER_ID AS ID FROM CTE1 AS C1 CROSS JOIN CTE1 AS C2 WHERE C1.VIEW_DATE = C2.VIEW_DATE AND C1.VIEWER_ID = C2.VIEWER_ID AND C1.ARTICLE_ID <> C2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
*/