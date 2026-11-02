-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Ocean View', 2, 'Queen', 4, 150, 'Modern');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (101, 'R1', '2023-01-01', '2023-01-05', 150.0, 'SMITH', 'ROY', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (102, 'R1', '2023-02-01', '2023-02-05', 150.0, 'SMITH', 'ROY', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (103, 'R1', '2023-03-01', '2023-03-05', 150.0, 'SMITH', 'ROY', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (104, 'R1', '2023-04-01', '2023-04-05', 150.0, 'JONES', 'ROY', 1, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (105, 'R1', '2023-05-01', '2023-05-05', 150.0, 'SWEAZY', 'ALICE', 2, 1);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (106, 'R1', '2023-06-01', '2023-06-05', 150.0, 'SWEAZY', 'ALICE', 2, 1);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (107, 'R1', '2023-07-01', '2023-07-05', 150.0, 'SWEAZY', 'ROY', 1, 1);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (108, 'R1', '2023-08-01', '2023-08-05', 150.0, 'DOE', 'JOHN', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "firstname", "lastname", COUNT(*) AS "n" FROM "reservations" GROUP BY "firstname", "lastname") WHERE ("firstname" = 'ROY' OR "lastname" = 'SWEAZY') ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Reservations WHERE FirstName = 'ROY' AND LastName = 'SWEAZY';

/*
Prediction Result:
(1,)
*/