-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, NULL, 0, '2023-01-01'), (NULL, 2, 1, '2023-01-02'), (0, 0, 2, '2023-01-01'), (NULL, 0, 0, NULL), (NULL, NULL, 2, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY 1 HAVING COUNT(DISTINCT ARTICLE_ID) >= 1 ORDER BY AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
*/