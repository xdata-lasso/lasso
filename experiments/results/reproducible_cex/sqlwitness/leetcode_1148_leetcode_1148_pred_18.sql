-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 1, 0, NULL), (0, 0, 2, '2023-01-02'), (1, 0, NULL, '2023-01-01'), (1, 1, NULL, '2023-01-01'), (2, 1, 0, '2023-01-01'), (2, 1, 2, '2023-01-02'), (NULL, 1, 1, '2023-01-01'), (2, 1, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY AUTHOR_ID HAVING COUNT(ARTICLE_ID) >= 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
*/