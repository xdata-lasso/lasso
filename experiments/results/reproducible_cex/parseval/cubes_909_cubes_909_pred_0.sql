-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: aircraft --
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1.0, 'rhs_2d71c8', 1.0);

INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (2.0, 'rhs_f814b4', 1.0);

-- Inserting into table: flight --
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1.0, 1.0, 'fli_f58188', 'fli_564835', 1.0, '2024-06-15', '2025-06-17', 0.01);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (2.0, 1.0, 'fli_f58188', 'fli_564835', 2.0, '2024-06-15', '2021-11-08', 0.02);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (3.0, 1.0, 'fli_f58188', 'fli_564835', 3.0, '2024-06-15', '2025-06-13', 0.03);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (4.0, 1.0, 'fli_f58188', 'fli_564835', 4.0, '2024-06-15', '2023-03-15', 0.04);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (5.0, 1.0, 'fli_f58188', 'fli_564835', 5.0, '2024-06-15', '2023-11-15', 0.05);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (6.0, 1.0, 'fli_f58188', 'fli_564835', 6.0, '2024-06-15', '2024-01-05', 0.06);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (7.0, 1.0, 'fli_f58188', 'fli_564835', 7.0, '2024-06-15', '2022-12-08', 0.07);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (8.0, 1.0, 'fli_f58188', 'fli_564835', 8.0, '2024-06-15', '2020-06-07', 0.08);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (9.0, 1.0, 'fli_f58188', 'fli_564835', 9.0, '2024-06-15', '2021-02-05', 0.09);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (10.0, 1.0, 'fli_f58188', 'fli_564835', 10.0, NULL, '2023-04-14', 0.1);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (11.0, 1.0, 'fli_f58188', 'fli_564835', 11.0, NULL, '2021-12-04', 0.11);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (12.0, 1.0, 'fli_f58188', 'fli_564835', 12.0, NULL, '2022-04-27', 0.12);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (13.0, 1.0, 'fli_f58188', 'fli_564835', 13.0, '2024-06-15', '2020-06-08', 0.13);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (14.0, 1.0, 'fli_f58188', 'fli_564835', 14.0, '2024-06-15', '2025-04-30', 0.14);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (15.0, 1.0, 'fli_f58188', 'fli_564835', 15.0, '2024-06-15', '2022-10-19', 0.15);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (16.0, 1.0, 'fli_f58188', 'fli_564835', 16.0, '2024-06-15', '2021-02-11', 0.16);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (17.0, 1.0, 'fli_f58188', 'fli_564835', 17.0, '2024-06-15', '2023-07-13', 0.17);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (18.0, 1.0, 'fli_f58188', 'fli_564835', 18.0, '2024-06-15', '2025-11-03', 0.18);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (19.0, 1.0, 'fli_f58188', 'fli_564835', 19.0, '2024-06-15', '2023-09-09', 0.19);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (20.0, 1.0, 'fli_f58188', 'fli_564835', 20.0, '2024-06-15', '2020-12-20', 0.2);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (21.0, 1.0, 'fli_f58188', 'fli_564835', 21.0, '2024-06-15', '2020-09-26', 0.21);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (22.0, 1.0, 'fli_f58188', 'fli_564835', 22.0, '2024-06-15', '2025-06-04', 0.22);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (23.0, 1.0, 'fli_f58188', 'fli_564835', 23.0, '2024-06-15', '2021-05-05', 0.23);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (24.0, 1.0, 'fli_f58188', 'fli_564835', 24.0, '2024-06-15', '2023-01-06', 0.24);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (25.0, 1.0, 'fli_f58188', 'fli_564835', 25.0, '2024-06-15', '2021-07-04', 0.25);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (26.0, 1.0, 'fli_f58188', 'fli_564835', 26.0, '2024-06-15', '2020-01-20', 0.26);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (27.0, 1.0, 'fli_f58188', 'fli_564835', 27.0, '2024-06-15', '2024-12-12', 0.27);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (28.0, 1.0, 'fli_f58188', 'fli_564835', 28.0, '2024-06-15', '2024-03-30', 0.28);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (29.0, 1.0, 'fli_f58188', 'fli_564835', 29.0, '2024-06-15', '2022-09-17', 0.29);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (30.0, 1.0, 'fli_f58188', 'fli_564835', 30.0, '2024-06-15', '2023-08-23', 0.3);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (31.0, 1.0, 'fli_f58188', 'fli_564835', 31.0, '2024-06-15', '2024-06-23', 0.31);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (32.0, 1.0, 'fli_f58188', 'fli_564835', 32.0, '2024-06-15', '2021-03-30', 0.32);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (33.0, 1.0, 'fli_f58188', 'fli_564835', 33.0, '2024-06-15', '2023-04-22', 0.33);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.aid AS aid, LHS.departure_date AS departure_date, LHS.n AS n, RHS.name AS name, RHS.distance AS distance FROM (SELECT aid, departure_date, COUNT(*) AS n FROM flight GROUP BY aid, departure_date) AS LHS INNER JOIN aircraft AS RHS ON (LHS.aid = RHS.aid)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('rhs_2d71c8', 3)
('rhs_2d71c8', 30)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid GROUP BY T1.aid;

/*
Prediction Result:
('rhs_2d71c8', 33)
*/