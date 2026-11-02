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
WITH X AS (SELECT DISTINCT * FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM X GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(VIEWER_ID) > 1 ORDER BY ID ASC;

/*
Prediction Result:
(1028,)
(1033,)
*/