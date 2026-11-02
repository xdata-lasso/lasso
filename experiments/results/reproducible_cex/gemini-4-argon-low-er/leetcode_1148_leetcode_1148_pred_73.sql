-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 10, 20, '2023-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 30, 10, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT V.AUTHOR_ID AS ID FROM VIEWS AS V INNER JOIN VIEWS AS U ON V.AUTHOR_ID = U.VIEWER_ID AND V.ARTICLE_ID = U.ARTICLE_ID ORDER BY V.AUTHOR_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(10,)
*/