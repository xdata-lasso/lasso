-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 3, 0, '2023-01-02'), (0, 0, 0, '2023-01-01'), (0, 3, NULL, '2023-01-02'), (3, 3, NULL, NULL), (NULL, 3, 2, '2023-01-02'), (3, 4, 4, NULL), (NULL, 3, 4, '2023-01-02'), (NULL, 4, 3, NULL), (2, 4, 4, '2023-01-02'), (3, 2, 0, NULL), (NULL, 4, 0, NULL), (4, 4, 3, '2023-01-01'), (1, 3, 2, NULL), (1, NULL, NULL, '2023-01-01'), (NULL, 3, NULL, NULL), (2, 3, 2, '2023-01-02'), (2, 4, 3, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT DISTINCT A.VIEWER_ID AS ID FROM (SELECT VIEWER_ID, VIEW_DATE, ARTICLE_ID, COUNT(*) AS CT FROM VIEWS GROUP BY 1, 2, 3) AS A GROUP BY A.VIEWER_ID, A.VIEW_DATE HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
(0,)
(2,)
(3,)
(4,)
*/