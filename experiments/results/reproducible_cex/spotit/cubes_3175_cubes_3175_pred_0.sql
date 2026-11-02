-- Schema DDL
CREATE TABLE "STUDENT" (
    "STUID" INT,
    "LNAME" TEXT,
    "FNAME" TEXT,
    "AGE" INT,
    "SEX" TEXT,
    "MAJOR" INT,
    "ADVISOR" INT,
    "CITY_CODE" TEXT,
    PRIMARY KEY ("STUID")
);
CREATE TABLE "RESTAURANT" (
    "RESID" INT,
    "RESNAME" TEXT,
    "ADDRESS" TEXT,
    "RATING" INT,
    PRIMARY KEY ("RESID")
);
CREATE TABLE "TYPE_OF_RESTAURANT" (
    "RESTYPEID" INT,
    "RESID" INT,
    FOREIGN KEY ("RESTYPEID") REFERENCES "RESTAURANT_TYPE"("RESTYPEID"),
    FOREIGN KEY ("RESID") REFERENCES "RESTAURANT"("RESID")
);
CREATE TABLE "RESTAURANT_TYPE" (
    "RESTYPEID" INT,
    "RESTYPENAME" TEXT,
    "RESTYPEDESCRIPTION" TEXT,
    PRIMARY KEY ("RESTYPEID")
);
CREATE TABLE "VISITS_RESTAURANT" (
    "RESID" INT,
    "STUID" INT,
    "TIME" TIMESTAMPTZ,
    "SPENT" FLOAT,
    FOREIGN KEY ("RESID") REFERENCES "RESTAURANT"("RESID"),
    FOREIGN KEY ("STUID") REFERENCES "STUDENT"("STUID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STUDENT VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO STUDENT VALUES (-1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO RESTAURANT VALUES (1, 26, 50, 0);
INSERT INTO RESTAURANT VALUES (0, 26, 51, 0);
INSERT INTO TYPE_OF_RESTAURANT VALUES (0, 1);
INSERT INTO TYPE_OF_RESTAURANT VALUES (-1, 0);
INSERT INTO RESTAURANT_TYPE VALUES (0, 8439070347719553201, 16);
INSERT INTO RESTAURANT_TYPE VALUES (-1, 8439070347719553201, 17);
INSERT INTO VISITS_RESTAURANT VALUES (1, -1, 0, 0);
INSERT INTO VISITS_RESTAURANT VALUES (0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___ FROM (SELECT LHS.resid AS resid, LHS.restypeid AS restypeid, LHS.restypename AS restypename, LHS.restypedescription AS restypedescription, RHS.resname AS resname, RHS.n AS n FROM (SELECT LHS.resid AS resid, LHS.restypeid AS restypeid, RHS.restypename AS restypename, RHS.restypedescription AS restypedescription FROM type_of_restaurant AS LHS INNER JOIN restaurant_type AS RHS ON (LHS.restypeid = RHS.restypeid)) AS LHS CROSS JOIN (SELECT resname, COUNT(*) AS n FROM restaurant GROUP BY resname) AS RHS) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Restaurant JOIN Type_Of_Restaurant ON Restaurant.ResID = Type_Of_Restaurant.ResID JOIN Restaurant_Type ON Type_Of_Restaurant.ResTypeID = Restaurant_Type.ResTypeID GROUP BY Type_Of_Restaurant.ResTypeID HAVING Restaurant_Type.ResTypeName = 'Sandwich';

/*
Prediction Result:
*/