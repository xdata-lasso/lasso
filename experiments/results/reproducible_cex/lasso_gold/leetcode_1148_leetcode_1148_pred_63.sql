-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1012, 1013, 1013, '1975-06-06');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1012, 1023, 1013, '1975-06-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(1013,)
*/

-- Prediction Query
SELECT DISTINCT O.AUTHOR_ID AS ID FROM VIEWS AS O WHERE EXISTS(SELECT I.VIEWER_ID FROM VIEWS AS I WHERE (I.AUTHOR_ID = I.VIEWER_ID) AND (I.ARTICLE_ID = O.ARTICLE_ID)) ORDER BY O.AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
(1013,)
(1023,)
*/