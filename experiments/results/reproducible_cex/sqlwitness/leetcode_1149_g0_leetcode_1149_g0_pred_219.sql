-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (3, NULL, 2, NULL), (2, 3, NULL, '2023-01-01'), (2, 1, 0, NULL), (0, NULL, 1, '2023-01-02'), (0, NULL, 1, '2023-01-01'), (3, 0, 3, '2023-01-02'), (2, NULL, 1, NULL), (3, 2, 2, '2023-01-02'), (3, 1, 2, '2023-01-02'), (0, 2, 2, '2023-01-02'), (2, 0, NULL, '2023-01-01'), (3, NULL, 1, '2023-01-02'), (3, 3, 0, NULL), (NULL, 0, 2, '2023-01-02'), (2, 2, 2, '2023-01-02'), (NULL, 2, 0, NULL), (0, 1, 2, NULL), (0, NULL, 2, '2023-01-02'), (2, 1, NULL, '2023-01-01'), (3, 1, 2, '2023-01-01'), (2, 3, 1, NULL), (0, NULL, NULL, '2023-01-01'), (3, 0, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
(0,)
(1,)
(2,)
*/

-- Prediction Query
SELECT VIEWER_ID AS ID FROM (SELECT DISTINCT VIEWER_ID, COUNT(DISTINCT ARTICLE_ID) AS CNT FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE) AS A WHERE CNT >= 2;

/*
Prediction Result:
(None,)
(0,)
(1,)
(2,)
(2,)
*/