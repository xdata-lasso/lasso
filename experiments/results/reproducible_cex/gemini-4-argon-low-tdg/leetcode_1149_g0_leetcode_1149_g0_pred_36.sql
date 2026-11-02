-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 9
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 10, 100, '2023-01-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 10, 100, '2023-01-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, 20, 200, '2023-01-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, 20, 200, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(200,)
*/

-- Prediction Query
SELECT VIEWER_ID AS ID FROM (SELECT VIEWER_ID FROM (SELECT VIEWER_ID, VIEW_DATE, ARTICLE_ID FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE, ARTICLE_ID) AS NP GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(*) > 1) AS NP2 GROUP BY ID ORDER BY ID;

/*
Prediction Result:
(100,)
(200,)
*/