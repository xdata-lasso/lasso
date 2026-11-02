-- Schema DDL
CREATE TABLE "FLIGHTS" (
    "ID" INT,
    "FLIGHT_NO" TEXT,
    "ORIGIN_ID" INT,
    "DESTINATION_ID" INT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("DESTINATION_ID") REFERENCES "AIRPORTS"("ID"),
    FOREIGN KEY ("ORIGIN_ID") REFERENCES "AIRPORTS"("ID")
);
CREATE TABLE "AIRPORTS" (
    "ID" INT,
    "NAME" TEXT,
    "CITY" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO FLIGHTS VALUES (0, 10, 0, -1);
INSERT INTO FLIGHTS VALUES (-1, 11, 0, -1);
INSERT INTO AIRPORTS VALUES (-1, 6, 7);
INSERT INTO AIRPORTS VALUES (0, 8, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.origin_id = o.id JOIN airports AS d ON f.destination_id = d.id;

/*
Gold Result:
('10', '8', '6')
('11', '8', '6')
*/

-- Prediction Query
SELECT f.flight_no, o.name AS origin, d.name AS destination FROM flights AS f JOIN airports AS o ON f.destination_id = o.id JOIN airports AS d ON f.origin_id = d.id;

/*
Prediction Result:
('10', '6', '8')
('11', '6', '8')
*/