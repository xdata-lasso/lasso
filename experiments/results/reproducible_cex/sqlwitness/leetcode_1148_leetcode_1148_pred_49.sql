-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 2, 0, '2023-01-02'), (NULL, 0, NULL, '2023-01-02'), (1, 1, 0, '2023-01-02'), (NULL, NULL, 2, '2023-01-02'), (NULL, 2, 2, '2023-01-01'), (1, 0, 0, NULL), (0, 1, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
SELECT V1.AUTHOR_ID AS ID FROM VIEWS AS V1 INNER JOIN VIEWS AS V2 ON V1.AUTHOR_ID = V2.VIEWER_ID AND V1.VIEW_DATE = V2.VIEW_DATE AND V1.ARTICLE_ID = V2.ARTICLE_ID GROUP BY V1.AUTHOR_ID HAVING COUNT(*) >= 1 ORDER BY ID ASC;

/*
Prediction Result:
*/