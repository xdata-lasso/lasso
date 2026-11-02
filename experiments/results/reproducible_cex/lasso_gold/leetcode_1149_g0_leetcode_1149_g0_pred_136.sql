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
WITH B AS (WITH A AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(DISTINCT ARTICLE_ID) AS X FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE) SELECT A.VIEWER_ID AS ID, A.VIEW_DATE FROM A JOIN A AS B ON A.VIEW_DATE = B.VIEW_DATE WHERE A.X > 1) SELECT DISTINCT ID FROM B ORDER BY ID ASC;

/*
Prediction Result:
*/