-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1091.5, 'Christy Porter', 1097.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1092.5, 'Maria Thomas', 1104.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1093.5, 'Patrick Ryan', 1111.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1094.5, 'Jessica Silva', 1118.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1095.5, 'Zachary Taylor', 1125.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1096.5, 'Peter Callahan Jr.', 1132.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1121.5, 'Shannon Smith', 1127.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1122.5, 'Melanie Herrera', 1134.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1123.5, 'Martin Rodriguez', 1141.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1124.5, 'Jesse Mckay', 1148.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1125.5, 'Deborah Mason', 1155.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1126.5, 'Thomas Harrell', 1162.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1103.5, 1091.5, 'collection', 'Cape Verde', 1109.5, '1977-04-14', '1983-10-20', 1116.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1105.5, 1091.5, 'structure', 'Hong Kong', 1120.5, '1977-04-15', '1983-10-21', 1132.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1106.5, 1091.5, 'response', 'Nepal', 1131.5, '1977-04-16', '1983-10-22', 1149.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1107.5, 1091.5, 'knowledge', 'Lao People''s Democratic Republic', 1142.5, '1977-04-17', '1983-10-23', 1166.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1108.5, 1091.5, 'pick', 'Marshall Islands', 1153.5, '1977-04-18', '1983-10-24', 1183.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1133.5, 1091.5, 'attack', 'El Salvador', 1164.5, '1977-04-19', '1983-10-25', 1200.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1104.5, 1121.5, 'fire', 'Hungary', 1139.5, '1989-05-03', '1995-11-09', 1115.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1134.5, 1121.5, 'thought', 'Holy See (Vatican City State)', 1150.5, '1989-05-04', '1995-11-10', 1162.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1135.5, 1121.5, 'purpose', 'Serbia', 1161.5, '1989-05-05', '1995-11-11', 1179.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1136.5, 1121.5, 'movement', 'Central African Republic', 1172.5, '1989-05-06', '1995-11-12', 1196.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1137.5, 1121.5, 'politics', 'Mauritius', 1183.5, '1989-05-07', '1995-11-13', 1213.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1138.5, 1121.5, 'decide', 'Zimbabwe', 1194.5, '1989-05-08', '1995-11-14', 1230.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno FROM (SELECT * FROM (SELECT * FROM flight ORDER BY price, flight.flno NULLS LAST) LIMIT 3);

/*
Gold Result:
(1104.5,)
(1103.5,)
(1105.5,)
*/

-- Prediction Query
SELECT flno FROM Flight ORDER BY distance ASC, Flight.flno NULLS LAST LIMIT 3;

/*
Prediction Result:
(1103.5,)
(1105.5,)
(1106.5,)
*/