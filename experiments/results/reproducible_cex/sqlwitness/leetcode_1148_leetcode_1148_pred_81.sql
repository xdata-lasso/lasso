-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 0, 1, '2023-01-02'), (1, NULL, 1, NULL), (0, 1, 0, NULL), (1, 1, 0, '2023-01-01'), (0, NULL, 0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON V1.VIEWER_ID = V2.AUTHOR_ID AND V1.ARTICLE_ID = V2.ARTICLE_ID ORDER BY ID;

/*
Prediction Result:
(0,)
(1,)
*/