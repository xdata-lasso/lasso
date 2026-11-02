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
SELECT DISTINCT A.VIEWER_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.VIEW_DATE = B.VIEW_DATE AND A.VIEWER_ID = B.VIEWER_ID GROUP BY A.VIEWER_ID, A.VIEW_DATE HAVING COUNT(DISTINCT A.ARTICLE_ID) > 1 ORDER BY A.VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
*/