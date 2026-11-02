-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1021.5, 'Jennifer Cole', 1025.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1022.5, 'Sean Blake', 1032.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1023.5, 'Jay Ramirez', 1039.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1024.5, 'Phillip Garcia', 1046.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1041.5, 'Renee Blair', 1045.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1042.5, 'Valerie Gray', 1052.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1043.5, 'Sandra Montgomery', 1059.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1044.5, 'Laura Bush', 1066.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1061.5, 'Dr. Sharon James', 1065.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1062.5, 'Roy Martin', 1072.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1063.5, 'Michael Miles', 1079.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1064.5, 'Andrea Reid', 1086.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1029.5, 1021.5, 'husband', 'Guatemala', 1033.5, '1978-09-09', '1982-02-13', 1037.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1030.5, 1021.5, 'bill', 'Guatemala', 1044.5, '1978-09-10', '1982-02-14', 1054.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1031.5, 1021.5, 'her', 'Guatemala', 1055.5, '1978-09-11', '1982-02-15', 1071.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1032.5, 1021.5, 'throw', 'Guatemala', 1066.5, '1978-09-12', '1982-02-16', 1088.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1049.5, NULL, 'answer', 'French Guiana', 1053.5, '1986-06-17', '1990-10-21', 1057.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1069.5, 1061.5, 'shoulder', 'French Guiana', 1083.5, '1994-03-03', '1998-07-07', 1093.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1070.5, 1061.5, 'election', 'French Guiana', 1094.5, '1994-03-04', '1998-07-08', 1110.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1071.5, 1061.5, 'common', 'French Guiana', 1105.5, '1994-03-05', '1998-07-09', 1127.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1080.5, NULL, 'husband', 'Guatemala', 1033.5, '1978-09-09', '1982-02-13', 1037.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT destination FROM (SELECT * FROM (SELECT * FROM (SELECT destination, flno, COUNT(*) AS n FROM flight GROUP BY destination, flno) ORDER BY flno DESC) LIMIT 1);

/*
Gold Result:
('Guatemala',)
*/

-- Prediction Query
SELECT destination FROM Flight GROUP BY destination ORDER BY COUNT(*), destination NULLS LAST LIMIT 1;

/*
Prediction Result:
('French Guiana',)
*/