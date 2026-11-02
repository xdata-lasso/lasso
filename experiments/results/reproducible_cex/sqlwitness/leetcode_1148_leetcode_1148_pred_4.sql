-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (NULL, NULL, 0, NULL), (0, 0, NULL, '2023-01-02'), (0, 0, 0, '2023-01-01'), (NULL, 0, 0, NULL), (1, 0, 1, '2023-01-01'), (NULL, NULL, 0, '2023-01-02'), (1, 1, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT V1.AUTHOR_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON V1.ARTICLE_ID = V2.ARTICLE_ID AND V1.AUTHOR_ID = V2.VIEWER_ID ORDER BY V1.AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
*/