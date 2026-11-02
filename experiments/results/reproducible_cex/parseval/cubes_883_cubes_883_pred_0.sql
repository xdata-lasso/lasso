-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: aircraft --
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1.0, 'air_777cba', 1.0);

-- Inserting into table: flight --
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1.0, 1.0, 'fli_a9a7a3', 'fli_564835', 1.0, '2024-06-15', '2025-06-17', 0.01);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (2.0, 1.0, 'fli_a9a7a3', 'fli_564835', 2.0, '2024-06-15', '2025-06-13', 0.02);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (3.0, 1.0, 'fli_a9a7a3', 'fli_564835', 3.0, '2024-06-15', '2023-11-15', 0.03);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (4.0, 1.0, 'fli_a10d11', 'fli_564835', 4.0, '2024-06-15', '2022-12-08', 0.04);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (5.0, 1.0, 'fli_a10d11', 'fli_564835', 5.0, '2024-06-15', '2021-02-05', 0.05);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (6.0, 1.0, 'fli_a10d11', 'fli_564835', 6.0, '2024-06-15', '2021-12-04', 0.06);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (7.0, 1.0, 'fli_a9a7a3', 'fli_564835', 7.0, '2024-06-15', '2020-06-08', 0.07);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (8.0, 1.0, 'fli_a9a7a3', 'fli_564835', 8.0, '2024-06-15', '2022-10-19', 0.08);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (9.0, 1.0, 'fli_a9a7a3', 'fli_564835', 9.0, '2024-06-15', '2023-07-13', 0.09);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (10.0, 1.0, 'fli_a10d11', 'fli_564835', 10.0, '2024-06-15', '2020-12-20', 0.1);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (11.0, 1.0, 'fli_a10d11', 'fli_564835', 11.0, '2024-06-15', '2025-06-04', 0.11);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (12.0, 1.0, 'fli_a10d11', 'fli_564835', 12.0, '2024-06-15', '2023-01-06', 0.12);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (13.0, 1.0, 'fli_a9a7a3', 'fli_564835', 13.0, '2024-06-15', '2020-01-20', 0.13);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (14.0, 1.0, 'fli_a9a7a3', 'fli_564835', 14.0, '2024-06-15', '2024-03-30', 0.14);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (15.0, 1.0, 'fli_a9a7a3', 'fli_564835', 15.0, '2024-06-15', '2023-08-23', 0.15);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (16.0, 1.0, 'fli_a10d11', 'fli_564835', 16.0, '2024-06-15', '2021-03-30', 0.16);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (17.0, 1.0, 'fli_a10d11', 'fli_564835', 17.0, '2024-06-15', '2023-01-03', 0.17);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (18.0, 1.0, 'fli_a10d11', 'fli_564835', 18.0, '2024-06-15', '2020-05-06', 0.18);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (19.0, 1.0, 'fli_a9a7a3', 'fli_564835', 19.0, NULL, '2022-08-24', 0.19);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (20.0, 1.0, 'fli_a9a7a3', 'fli_564835', 20.0, NULL, '2023-08-07', 0.2);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (21.0, 1.0, 'fli_a9a7a3', 'fli_564835', 21.0, NULL, '2023-10-03', 0.21);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (22.0, 1.0, 'fli_a10d11', 'fli_564835', 22.0, NULL, '2022-01-04', 0.22);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (23.0, 1.0, 'fli_a10d11', 'fli_564835', 23.0, NULL, '2023-05-30', 0.23);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (24.0, 1.0, 'fli_a10d11', 'fli_564835', 24.0, NULL, '2022-01-16', 0.24);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (25.0, 1.0, NULL, 'fli_564835', 25.0, '2024-06-15', '2022-04-29', 0.25);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (26.0, 1.0, NULL, 'fli_564835', 26.0, '2024-06-15', '2023-01-01', 0.26);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (27.0, 1.0, NULL, 'fli_564835', 27.0, '2024-06-15', '2020-07-11', 0.27);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (28.0, 1.0, NULL, 'fli_564835', 28.0, '2024-06-15', '2022-07-21', 0.28);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (29.0, 1.0, NULL, 'fli_564835', 29.0, '2024-06-15', '2021-06-28', 0.29);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (30.0, 1.0, NULL, 'fli_564835', 30.0, '2024-06-15', '2020-11-04', 0.3);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (31.0, 1.0, 'fli_a9a7a3', 'fli_564835', 31.0, '2024-06-15', '2023-09-04', 0.31);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (32.0, 1.0, 'fli_a9a7a3', 'fli_564835', 32.0, '2024-06-15', '2023-11-17', 0.32);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (33.0, 1.0, 'fli_a9a7a3', 'fli_564835', 33.0, '2024-06-15', '2021-12-14', 0.33);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (34.0, 1.0, 'fli_a10d11', 'fli_564835', 34.0, '2024-06-15', '2020-01-23', 0.34);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (35.0, 1.0, 'fli_a10d11', 'fli_564835', 35.0, '2024-06-15', '2024-09-12', 0.35);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (36.0, 1.0, 'fli_a10d11', 'fli_564835', 36.0, '2024-06-15', '2023-05-08', 0.36);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (37.0, 1.0, 'fli_a9a7a3', 'fli_564835', 37.0, '2024-06-15', '2020-06-05', 0.37);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (38.0, 1.0, 'fli_a9a7a3', 'fli_564835', 38.0, '2024-06-15', '2020-11-01', 0.38);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (39.0, 1.0, 'fli_a9a7a3', 'fli_564835', 39.0, '2024-06-15', '2021-06-11', 0.39);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (40.0, 1.0, 'fli_a10d11', 'fli_564835', 40.0, '2024-06-15', '2020-07-02', 0.4);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (41.0, 1.0, 'fli_a10d11', 'fli_564835', 41.0, '2024-06-15', '2025-03-28', 0.41);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (42.0, 1.0, 'fli_a10d11', 'fli_564835', 42.0, '2024-06-15', '2021-06-20', 0.42);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (43.0, 1.0, 'fli_a9a7a3', 'fli_564835', 43.0, '2024-06-15', '2022-02-24', 0.43);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (44.0, 1.0, 'fli_a9a7a3', 'fli_564835', 44.0, '2024-06-15', '2025-01-28', 0.44);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (45.0, 1.0, 'fli_a9a7a3', 'fli_564835', 45.0, '2024-06-15', '2020-03-30', 0.45);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (46.0, 1.0, 'fli_a10d11', 'fli_564835', 46.0, '2024-06-15', '2022-07-11', 0.46);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (47.0, 1.0, 'fli_a10d11', 'fli_564835', 47.0, '2024-06-15', '2022-04-13', 0.47);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (48.0, 1.0, 'fli_a10d11', 'fli_564835', 48.0, '2024-06-15', '2022-10-25', 0.48);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (49.0, 1.0, 'fli_a9a7a3', 'fli_564835', 49.0, '2024-06-15', '2022-06-23', 0.49);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (50.0, 1.0, 'fli_a9a7a3', 'fli_564835', 50.0, '2024-06-15', '2022-11-29', 0.5);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (51.0, 1.0, 'fli_a9a7a3', 'fli_564835', 51.0, '2024-06-15', '2022-09-19', 0.51);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (52.0, 1.0, 'fli_a10d11', 'fli_564835', 52.0, '2024-06-15', '2023-03-15', 0.52);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (53.0, 1.0, 'fli_a10d11', 'fli_564835', 53.0, '2024-06-15', '2020-03-14', 0.53);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (54.0, 1.0, 'fli_a10d11', 'fli_564835', 54.0, '2024-06-15', '2022-08-27', 0.54);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (55.0, 1.0, 'fli_a9a7a3', 'fli_564835', 55.0, '2024-06-15', '2024-12-15', 0.55);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (56.0, 1.0, 'fli_a9a7a3', 'fli_564835', 56.0, '2024-06-15', '2023-08-24', 0.56);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (57.0, 1.0, 'fli_a9a7a3', 'fli_564835', 57.0, '2024-06-15', '2022-02-01', 0.57);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (58.0, 1.0, 'fli_a10d11', 'fli_564835', 58.0, '2024-06-15', '2022-10-26', 0.58);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (59.0, 1.0, 'fli_a10d11', 'fli_564835', 59.0, '2024-06-15', '2024-10-16', 0.59);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (60.0, 1.0, 'fli_a10d11', 'fli_564835', 60.0, '2024-06-15', '2023-01-29', 0.6);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (61.0, 1.0, 'fli_a9a7a3', 'fli_564835', 61.0, '2024-06-15', '2024-03-26', 0.61);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (62.0, 1.0, 'fli_a9a7a3', 'fli_564835', 62.0, '2024-06-15', '2022-07-04', 0.62);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (63.0, 1.0, 'fli_a9a7a3', 'fli_564835', 63.0, '2024-06-15', '2025-02-11', 0.63);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (64.0, 1.0, 'fli_a10d11', 'fli_564835', 64.0, '2024-06-15', '2021-04-03', 0.64);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (65.0, 1.0, 'fli_a10d11', 'fli_564835', 65.0, '2024-06-15', '2025-11-03', 0.65);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (66.0, 1.0, 'fli_a10d11', 'fli_564835', 66.0, '2024-06-15', '2021-11-06', 0.66);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (67.0, 1.0, 'fli_a9a7a3', 'fli_564835', 67.0, '2024-06-15', '2020-10-31', 0.67);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (68.0, 1.0, 'fli_a9a7a3', 'fli_564835', 68.0, '2024-06-15', '2024-10-22', 0.68);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (69.0, 1.0, 'fli_a9a7a3', 'fli_564835', 69.0, '2024-06-15', '2021-08-16', 0.69);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (70.0, 1.0, 'fli_a10d11', 'fli_564835', 70.0, '2024-06-15', '2025-11-18', 0.7);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (71.0, 1.0, 'fli_a10d11', 'fli_564835', 71.0, '2024-06-15', '2023-12-17', 0.71);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (72.0, 1.0, 'fli_a10d11', 'fli_564835', 72.0, '2024-06-15', '2023-07-07', 0.72);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (73.0, 1.0, 'fli_a9a7a3', 'fli_564835', 73.0, '2024-06-15', '2020-08-25', 0.73);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (74.0, 1.0, 'fli_a9a7a3', 'fli_564835', 74.0, '2024-06-15', '2024-04-09', 0.74);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (75.0, 1.0, 'fli_a9a7a3', 'fli_564835', 75.0, '2024-06-15', '2022-12-09', 0.75);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (76.0, 1.0, 'fli_a10d11', 'fli_564835', 76.0, '2024-06-15', '2025-02-23', 0.76);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (77.0, 1.0, 'fli_a10d11', 'fli_564835', 77.0, '2024-06-15', '2024-03-19', 0.77);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (78.0, 1.0, 'fli_a10d11', 'fli_564835', 78.0, '2024-06-15', '2025-11-02', 0.78);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (79.0, 1.0, 'fli_a9a7a3', 'fli_564835', 79.0, '2024-06-15', '2023-01-20', 0.79);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (80.0, 1.0, 'fli_a9a7a3', 'fli_564835', 80.0, '2024-06-15', '2021-08-18', 0.8);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (81.0, 1.0, 'fli_a9a7a3', 'fli_564835', 81.0, '2024-06-15', '2022-01-09', 0.81);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (82.0, 1.0, 'fli_a10d11', 'fli_564835', 82.0, '2024-06-15', '2020-04-20', 0.82);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (83.0, 1.0, 'fli_a10d11', 'fli_564835', 83.0, '2024-06-15', '2024-04-25', 0.83);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (84.0, 1.0, 'fli_a10d11', 'fli_564835', 84.0, '2024-06-15', '2025-07-21', 0.84);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (85.0, 1.0, 'fli_a9a7a3', 'fli_564835', 85.0, '2024-06-15', '2021-07-18', 0.85);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (86.0, 1.0, 'fli_a9a7a3', 'fli_564835', 86.0, '2024-06-15', '2023-01-22', 0.86);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (87.0, 1.0, 'fli_a9a7a3', 'fli_564835', 87.0, '2024-06-15', '2021-01-15', 0.87);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (88.0, 1.0, 'fli_a10d11', 'fli_564835', 88.0, '2024-06-15', '2022-12-15', 0.88);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (89.0, 1.0, 'fli_a10d11', 'fli_564835', 89.0, '2024-06-15', '2025-06-26', 0.89);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (90.0, 1.0, 'fli_a10d11', 'fli_564835', 90.0, '2024-06-15', '2024-05-26', 0.9);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (91.0, 1.0, 'fli_a9a7a3', 'fli_564835', 91.0, '2024-06-15', '2020-12-28', 0.91);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (92.0, 1.0, 'fli_a9a7a3', 'fli_564835', 92.0, '2024-06-15', '2020-11-04', 0.92);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (93.0, 1.0, 'fli_a9a7a3', 'fli_564835', 93.0, '2024-06-15', '2020-07-19', 0.93);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (94.0, 1.0, 'fli_a10d11', 'fli_564835', 94.0, '2024-06-15', '2024-11-12', 0.94);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (95.0, 1.0, 'fli_a10d11', 'fli_564835', 95.0, '2024-06-15', '2024-05-17', 0.95);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (96.0, 1.0, 'fli_a10d11', 'fli_564835', 96.0, '2024-06-15', '2024-02-13', 0.96);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin_other AS origin FROM (SELECT LHS.departure_date AS departure_date, LHS.origin AS origin, LHS.n AS n, RHS.departure_date AS departure_date_other, RHS.origin AS origin_other, RHS.n AS n_other FROM (SELECT departure_date, origin, COUNT(*) AS n FROM flight GROUP BY departure_date, origin) AS LHS CROSS JOIN (SELECT departure_date, origin, COUNT(*) AS n FROM flight GROUP BY departure_date, origin) AS RHS) WHERE (n < n_other) ORDER BY origin;

/*
Gold Result:
(None,)
(None,)
('fli_a10d11',)
('fli_a10d11',)
('fli_a10d11',)
('fli_a9a7a3',)
('fli_a9a7a3',)
('fli_a9a7a3',)
*/

-- Prediction Query
SELECT origin FROM Flight GROUP BY origin ORDER BY COUNT(*) DESC, origin NULLS LAST LIMIT 1;

/*
Prediction Result:
('fli_a10d11',)
*/