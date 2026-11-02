-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 15, 16, NULL);
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 11, 11, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT T1.AUTHOR_ID AS ID FROM VIEWS AS T1 LEFT JOIN VIEWS AS T2 ON T1.AUTHOR_ID = T2.VIEWER_ID AND T1.ARTICLE_ID = T2.ARTICLE_ID GROUP BY 1 HAVING COUNT(T2.VIEWER_ID) >= 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
*/