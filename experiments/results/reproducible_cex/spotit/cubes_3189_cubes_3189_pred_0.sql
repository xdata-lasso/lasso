-- Schema DDL
CREATE TABLE "ROOMS" (
    "ROOMID" TEXT,
    "ROOMNAME" TEXT,
    "BEDS" INT,
    "BEDTYPE" TEXT,
    "MAXOCCUPANCY" INT,
    "BASEPRICE" INT,
    "DECOR" TEXT,
    PRIMARY KEY ("ROOMID")
);
CREATE TABLE "RESERVATIONS" (
    "CODE" INT,
    "ROOM" TEXT,
    "CHECKIN" TEXT,
    "CHECKOUT" TEXT,
    "RATE" FLOAT,
    "LASTNAME" TEXT,
    "FIRSTNAME" TEXT,
    "ADULTS" INT,
    "KIDS" INT,
    PRIMARY KEY ("CODE"),
    FOREIGN KEY ("ROOM") REFERENCES "ROOMS"("ROOMID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ROOMS VALUES (2, 22, 0, 23, 0, 0, 10);
INSERT INTO ROOMS VALUES (5, 27, 0, 28, 0, 0, 13);
INSERT INTO RESERVATIONS VALUES (-1, 5, 8, 19, 20, 21, 9, 0, 0);
INSERT INTO RESERVATIONS VALUES (0, 5, 11, 24, 25, 26, 12, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT code, room, checkin, checkout, rate, lastname, firstname, adults, kids, roomname, beds, bedtype, maxoccupancy, baseprice, roomid, firstname AS decor FROM (SELECT code, room, checkin, checkout, rate, lastname, firstname, adults, kids, roomname, beds, bedtype, maxoccupancy, baseprice, checkin AS roomid FROM (SELECT LHS.code AS code, LHS.room AS room, LHS.checkin AS checkin, LHS.checkout AS checkout, LHS.rate AS rate, LHS.lastname AS lastname, LHS.firstname AS firstname, LHS.adults AS adults, LHS.kids AS kids, RHS.roomname AS roomname, RHS.beds AS beds, RHS.bedtype AS bedtype, RHS.maxoccupancy AS maxoccupancy, RHS.baseprice AS baseprice FROM reservations AS LHS INNER JOIN rooms AS RHS ON (LHS.checkin = RHS.roomid AND LHS.firstname = RHS.decor))))) ORDER BY count___;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM rooms WHERE NOT roomid IN (SELECT DISTINCT room FROM reservations);

/*
Prediction Result:
(1,)
*/