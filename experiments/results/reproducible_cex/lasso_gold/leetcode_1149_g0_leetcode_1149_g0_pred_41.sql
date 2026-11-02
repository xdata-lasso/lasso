-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1024, 1026, 1028, '1975-06-06');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1025, 1031.0, 1028, '1975-06-06');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 1031, 1033, '1976-07-07');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 1036.0, 1033, '1976-07-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1028,)
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT AUTHOR_ID, VIEWER_ID, VIEW_DATE, RANK() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY AUTHOR_ID, ARTICLE_ID) AS RNK FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM TEMP WHERE RNK >= 2;

/*
Prediction Result:
(1028,)
(1033,)
*/