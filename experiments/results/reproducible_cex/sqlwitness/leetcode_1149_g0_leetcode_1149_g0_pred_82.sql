-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, NULL, 0, NULL), (0, 0, NULL, '2023-01-02'), (NULL, 1, 1, '2023-01-01'), (0, 2, 1, '2023-01-01'), (NULL, 1, 1, '2023-01-02'), (0, 0, 2, NULL), (2, NULL, 1, NULL), (2, 0, 0, '2023-01-02'), (1, 0, 0, '2023-01-01'), (1, NULL, 1, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, COUNT(VIEWER_ID) AS VIEWS FROM (SELECT DISTINCT * FROM VIEWS) AS T GROUP BY VIEWER_ID, VIEW_DATE HAVING VIEWS > 1) AS T WHERE VIEWS > 1 ORDER BY ID;

/*
Prediction Result:
(1,)
*/