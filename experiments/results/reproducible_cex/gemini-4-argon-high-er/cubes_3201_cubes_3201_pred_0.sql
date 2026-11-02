-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', 'Room 1', 1, 'Queen', 2, 120, 'modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT decor, n AS count___ FROM (SELECT decor, COUNT(*) AS n FROM (SELECT * FROM rooms WHERE (baseprice >= 120)) GROUP BY decor) ORDER BY decor, count___ NULLS LAST;

/*
Gold Result:
('modern', 1)
*/

-- Prediction Query
SELECT decor, COUNT(*) FROM Rooms WHERE basePrice > 120 GROUP BY decor;

/*
Prediction Result:
*/