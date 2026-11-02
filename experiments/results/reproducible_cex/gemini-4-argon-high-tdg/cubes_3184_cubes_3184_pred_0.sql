-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', 'Ocean View', 2, 'Queen', 4, 150, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R2', 'Mountain View', 1, 'King', 2, 120, 'Rustic');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (1, 'R1', '2023-01-01', '2023-01-05', 150.0, 'SWEAZY', 'ALICE', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (2, 'R1', '2023-02-01', '2023-02-05', 150.0, 'SWEAZY', 'ALICE', 2, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (3, 'R2', '2023-03-01', '2023-03-05', 120.0, 'SWEAZY', 'ALICE', 1, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (4, 'R1', '2023-04-01', '2023-04-05', 150.0, 'SWEAZY', 'ROY', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (5, 'R2', '2023-05-01', '2023-05-05', 120.0, 'SWEAZY', 'ROY', 1, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (6, 'R1', '2023-06-01', '2023-06-05', 150.0, 'ZANE', 'ROY', 2, 2);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (7, 'R2', '2023-07-01', '2023-07-03', 120.0, 'SMITH', 'BOB', 1, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (8, 'R2', '2023-07-10', '2023-07-12', 120.0, 'SMITH', 'BOB', 1, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (9, 'R2', '2023-07-20', '2023-07-22', 120.0, 'SMITH', 'BOB', 1, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (10, 'R2', '2023-07-25', '2023-07-28', 120.0, 'SMITH', 'BOB', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "firstname", "lastname", COUNT(*) AS "n" FROM "reservations" GROUP BY "firstname", "lastname") WHERE ("firstname" = 'ROY' OR "lastname" = 'SWEAZY') ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Reservations WHERE FirstName = 'ROY' AND LastName = 'SWEAZY';

/*
Prediction Result:
(2,)
*/