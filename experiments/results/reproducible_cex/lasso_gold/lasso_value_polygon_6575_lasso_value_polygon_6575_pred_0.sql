-- Schema DDL
CREATE TABLE QUERIES (QUERY_NAME TEXT(255), RESULT TEXT(255), POSITION INTEGER, RATING INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Brian Yang', 'offer', 1002, 0);
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Brian Yang', 'offer', 1002, 2);
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Brian Yang', 'offer', 1002, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT QUERY_NAME, ROUND(AVG(RATING / POSITION), 2) AS QUALITY, ROUND(100 * SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) / COUNT(1), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Gold Result:
('Brian Yang', 0.0, 66.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(SUM(RATING / POSITION) / COUNT(*), 2) AS QUALITY, ROUND(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
('Brian Yang', 0.0, 0.0)
*/