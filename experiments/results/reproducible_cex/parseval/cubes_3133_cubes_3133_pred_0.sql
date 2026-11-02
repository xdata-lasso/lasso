-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1, 'lhs_57281e', 'lhs_91319f', 1, 1);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (2, 'lhs_57281e', 'lhs_91319f', 1, 1);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (3, 'swwqcgsk', '9n8c4pgu7v', -1865039888, 1160656988);

-- Inserting into table: exhibition --
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (1, 1, 1, 'rhs_d943b9', 1.0);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (2, 1, 1, 'rhs_d943b9', 1.0);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (3, 1, 1, 'rhs_c7b2f2', 1.0);

-- Inserting into table: exhibition_record --
INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (1, 'exh_4628a9', -55602865);

INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (1, 'exh_0730ce', 2);

INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (3, 'exh_0730ce', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, LHS.exhibition_id AS exhibition_id, LHS.year AS YEAR, LHS.theme AS theme, LHS.ticket_price AS ticket_price, RHS.date AS date, RHS.attendance AS attendance, RHS.meanattendance AS meanattendance FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.exhibition_id AS exhibition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.ticket_price AS ticket_price FROM artist AS LHS INNER JOIN exhibition AS RHS ON (LHS.artist_id = RHS.artist_id)) AS LHS INNER JOIN (SELECT exhibition_id, date, attendance, AVG(attendance) OVER () AS meanattendance FROM exhibition_record) AS RHS ON (LHS.exhibition_id = RHS.exhibition_id)) WHERE (meanattendance <= 200.0 OR meanattendance <> attendance) ORDER BY name;

/*
Gold Result:
('lhs_57281e',)
*/

-- Prediction Query
SELECT T3.name FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id = T2.exhibition_id JOIN artist AS T3 ON T3.artist_id = T2.artist_id GROUP BY T3.artist_id HAVING AVG(T1.attendance) > 200;

/*
Prediction Result:
*/