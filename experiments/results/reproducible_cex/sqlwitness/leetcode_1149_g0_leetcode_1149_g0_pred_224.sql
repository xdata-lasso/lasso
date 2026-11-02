-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 3, 2, '2023-01-02'), (1, 3, 2, NULL), (1, 3, NULL, '2023-01-02'), (1, 1, 1, '2023-01-01'), (0, 2, NULL, '2023-01-01'), (3, NULL, 2, '2023-01-02'), (1, 2, 3, NULL), (3, NULL, NULL, '2023-01-01'), (2, 3, 3, '2023-01-02'), (3, 0, 2, '2023-01-01'), (1, 0, 1, '2023-01-02'), (NULL, 0, NULL, NULL), (3, 2, 3, '2023-01-02'), (2, NULL, NULL, NULL), (NULL, 0, 0, '2023-01-02'), (0, 0, 0, '2023-01-01'), (0, 0, 1, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(VIEWER_ID) >= 2 AND COUNT(DISTINCT ARTICLE_ID) >= 2;

/*
Prediction Result:
(1,)
(2,)
(3,)
*/