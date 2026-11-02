-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 2, NULL, '2023-01-02'), (0, 1, NULL, '2023-01-01'), (NULL, 2, 0, NULL), (0, 1, 1, '2023-01-02'), (0, 0, 0, NULL), (1, 2, 1, '2023-01-02'), (0, NULL, NULL, '2023-01-01'), (NULL, NULL, 2, '2023-01-02'), (1, 1, 2, NULL), (NULL, 2, NULL, NULL), (2, 0, 1, '2023-01-02'), (NULL, 1, 2, '2023-01-01'), (0, 0, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT DISTINCT * FROM VIEWS) AS A GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(ARTICLE_ID) > 1 ORDER BY ID;

/*
Prediction Result:
(None,)
(1,)
*/