-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 1, 1, '2023-01-02'), (0, 1, 1, NULL), (NULL, 1, NULL, '2023-01-02'), (0, 1, NULL, '2023-01-02'), (1, NULL, 1, NULL), (0, 0, 0, NULL), (0, NULL, NULL, '2023-01-01'), (1, NULL, 0, '2023-01-01'), (NULL, NULL, NULL, '2023-01-01'), (NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY ARTICLE_ID;

/*
Prediction Result:
(1,)
*/