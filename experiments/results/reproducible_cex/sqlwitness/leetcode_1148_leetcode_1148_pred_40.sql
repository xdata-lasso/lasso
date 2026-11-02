-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, NULL, '2023-01-02'), (0, 0, 1, '2023-01-02'), (NULL, 1, 1, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT Q.AUTHOR_ID AS ID FROM (SELECT V1.AUTHOR_ID AS AUTHOR_ID, V1.ARTICLE_ID FROM VIEWS AS V1 INNER JOIN (SELECT VIEWER_ID, ARTICLE_ID FROM VIEWS) AS V2 ON V1.ARTICLE_ID = V2.ARTICLE_ID AND V1.AUTHOR_ID = V2.VIEWER_ID) AS Q ORDER BY ID;

/*
Prediction Result:
*/