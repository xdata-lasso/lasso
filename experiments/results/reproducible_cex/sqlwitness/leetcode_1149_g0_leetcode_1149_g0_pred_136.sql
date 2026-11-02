-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 0, NULL, NULL), (1, 0, 1, '2023-01-02'), (2, 2, 2, '2023-01-02'), (2, NULL, 1, '2023-01-01'), (0, NULL, 1, NULL), (NULL, 1, 2, '2023-01-02'), (1, 2, NULL, '2023-01-01'), (0, 2, 1, '2023-01-01'), (1, 0, 2, NULL), (0, NULL, 2, NULL), (0, 1, NULL, '2023-01-02'), (1, 0, NULL, '2023-01-02'), (NULL, 0, 1, '2023-01-02'), (1, 1, NULL, NULL), (2, NULL, 1, '2023-01-01'), (2, 2, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
(1,)
(2,)
*/

-- Prediction Query
WITH B AS (WITH A AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(DISTINCT ARTICLE_ID) AS X FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE) SELECT A.VIEWER_ID AS ID, A.VIEW_DATE FROM A JOIN A AS B ON A.VIEW_DATE = B.VIEW_DATE WHERE A.X > 1) SELECT DISTINCT ID FROM B ORDER BY ID ASC;

/*
Prediction Result:
(None,)
(1,)
*/