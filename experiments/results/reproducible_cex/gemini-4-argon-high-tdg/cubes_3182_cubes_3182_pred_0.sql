-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R0', 'Alpha', 2, 'Queen', 4, 150, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R3', 'Beta', 1, 'King', 2, 200, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R2', 'Beta', 2, 'Double', 4, 180, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', 'Beta', 3, 'Queen', 6, 250, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R4', 'Gamma', 1, 'King', 2, 120, 'rustic');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (101, 'R3', '2023-01-01', '2023-01-05', 200.0, 'Smith', 'John', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (102, 'R2', '2023-02-01', '2023-02-03', 180.0, 'Doe', 'Jane', 1, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (103, 'R1', '2023-03-01', '2023-03-04', 250.0, 'Brown', 'Charlie', 2, 2);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (104, 'R1', '2023-04-01', '2023-04-02', 260.0, 'Davis', 'Emily', 1, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (105, 'R1', '2023-05-01', '2023-05-06', 240.0, 'Wilson', 'Michael', 3, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (106, 'R4', '2023-06-01', '2023-06-03', 120.0, 'Taylor', 'Sarah', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (107, 'R4', '2023-07-01', '2023-07-04', 125.0, 'Anderson', 'David', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname, n AS count___, roomid AS room FROM (SELECT LHS.roomid AS roomid, LHS.roomname AS roomname, LHS.beds AS beds, LHS.bedtype AS bedtype, LHS.maxoccupancy AS maxoccupancy, LHS.baseprice AS baseprice, LHS.decor AS decor, RHS.n AS n FROM rooms AS LHS INNER JOIN (SELECT room, COUNT(*) AS n FROM reservations GROUP BY room) AS RHS ON (LHS.roomid = RHS.room)) ORDER BY roomname, count___ NULLS LAST, room NULLS LAST;

/*
Gold Result:
('Beta', 1, 'R2')
('Beta', 1, 'R3')
('Beta', 3, 'R1')
('Gamma', 2, 'R4')
*/

-- Prediction Query
SELECT T2.roomName, COUNT(*), T1.Room FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room = T2.RoomId GROUP BY T1.Room;

/*
Prediction Result:
('Beta', 3, 'R1')
('Beta', 1, 'R2')
('Beta', 1, 'R3')
('Gamma', 2, 'R4')
*/