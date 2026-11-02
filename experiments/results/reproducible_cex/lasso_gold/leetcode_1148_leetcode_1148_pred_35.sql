-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1011, 1012, 1012, '1975-06-06');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1011, 1013, 1013, '1976-07-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(1012,)
(1013,)
*/

-- Prediction Query
SELECT DISTINCT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY ARTICLE_ID ORDER BY ID ASC;

/*
Prediction Result:
(1012,)
*/