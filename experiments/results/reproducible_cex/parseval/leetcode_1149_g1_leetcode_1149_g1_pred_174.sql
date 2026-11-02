-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1437333179, -921145356, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1258409369, -1981402255, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-890215420, 1610062532, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-734455130, 1744686505, 1, '2025-04-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1633151678, -252690330, 1, '2025-04-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1115440883, 1644814318, 1, '2025-04-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1349201381, 1019800248, 1, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1910425938, -845863578, 1, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1610064545, 429706943, 1, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1236688122, 2087640001, 1, '2022-09-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (907682809, 2026480202, 1, '2022-09-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1576219117, -1823627488, 1, '2022-09-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1861536320, 44952191, NULL, '2021-12-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1620389964, 546571701, NULL, '2024-09-18');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1990080517, 1408123494, NULL, '2023-09-04');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1964997180, 1149850321, NULL, '2023-09-04');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1833165707, 1155439218, NULL, '2023-09-04');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-761141909, 283598170, 1, '2021-06-20');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (742285925, -747753377, 1, '2021-06-20');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (902887186, -967741825, 1, '2021-06-20');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (373262291, -472966518, 1, '2020-12-02');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-921187550, -2070843029, 1, '2020-12-02');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (328305758, -751275471, 1, '2020-12-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT VIEWER_ID, COUNT(DISTINCT ARTICLE_ID) AS CNT FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID) SELECT VIEWER_ID AS ID FROM CTE WHERE CNT > 1 ORDER BY ID;

/*
Prediction Result:
(None,)
(1,)
*/