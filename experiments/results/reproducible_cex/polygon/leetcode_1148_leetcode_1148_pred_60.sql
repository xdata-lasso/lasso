-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (12, 11, 11, '1000-01-14');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 16, 16, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(11,)
(16,)
*/

-- Prediction Query
SELECT DISTINCT V1.AUTHOR_ID AS ID FROM VIEWS AS V1 LEFT JOIN VIEWS AS V2 ON V1.AUTHOR_ID = V2.VIEWER_ID AND V2.ARTICLE_ID = V1.ARTICLE_ID WHERE NOT V2.VIEWER_ID IS NULL ORDER BY V1.AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
(11,)
*/