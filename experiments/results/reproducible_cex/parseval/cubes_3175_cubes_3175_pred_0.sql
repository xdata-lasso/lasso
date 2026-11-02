-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: restaurant --
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483648, 'res_996123', 'res_91a090', -55602865);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483647, 'res_996123', 'res_91a090', -59984348);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483646, 'res_996123', 'res_91a090', -664303813);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1, 'res_994110', 'res_91a090', -1022641847);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483644, 'res_996123', 'res_91a090', -1726781632);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483643, 'res_996123', 'res_91a090', 247012447);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483642, 'res_996123', 'res_91a090', -1980249628);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483641, 'res_996123', 'res_91a090', -734455130);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483640, 'res_996123', 'res_91a090', 1744686505);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483639, 'res_996123', 'res_91a090', -1633151678);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483638, 'res_996123', 'res_91a090', -252690330);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483637, 'res_996123', 'res_91a090', 1115440883);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483636, 'res_996123', 'res_91a090', 1644814318);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483635, 'res_996123', 'res_91a090', 1465859724);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483634, 'res_996123', 'res_91a090', -1349201381);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483633, 'res_996123', 'res_91a090', 1019800248);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483632, 'res_996123', 'res_91a090', -1910425938);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483631, 'res_996123', 'res_91a090', -845863578);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483630, 'res_996123', 'res_91a090', -1610064545);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483629, 'res_996123', 'res_91a090', 429706943);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483628, 'res_996123', 'res_91a090', 462974032);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483627, 'res_996123', 'res_91a090', -1137908826);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483626, 'res_996123', 'res_91a090', -918961358);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483625, 'res_996123', 'res_91a090', -1602639011);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483624, 'res_996123', 'res_91a090', -45536098);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483623, 'res_996123', 'res_91a090', 1861536320);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483622, 'res_996123', 'res_91a090', 44952191);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483621, 'res_996123', 'res_91a090', 1151980946);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483620, NULL, 'res_91a090', 1620389964);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483619, NULL, 'res_91a090', 546571701);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483618, NULL, 'res_91a090', 947159877);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483617, 'res_996123', 'res_91a090', 1990080517);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483616, 'res_996123', 'res_91a090', 1408123494);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483615, 'res_996123', 'res_91a090', -1964997180);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483614, 'res_996123', 'res_91a090', 1149850321);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483613, 'res_996123', 'res_91a090', -1833165707);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483612, 'res_996123', 'res_91a090', 1155439218);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483611, 'res_996123', 'res_91a090', 1313172851);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483610, 'res_996123', 'res_91a090', -761141909);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483609, 'res_996123', 'res_91a090', 283598170);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483608, 'res_996123', 'res_91a090', 742285925);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483607, 'res_996123', 'res_91a090', -747753377);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483606, 'res_996123', 'res_91a090', 902887186);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483605, 'res_996123', 'res_91a090', -967741825);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483604, 'res_996123', 'res_91a090', 775304493);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483603, 'res_996123', 'res_91a090', 373262291);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483602, 'res_996123', 'res_91a090', -472966518);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483601, 'res_996123', 'res_91a090', -921187550);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483600, 'res_996123', 'res_91a090', -2070843029);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483599, 'res_996123', 'res_91a090', 328305758);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483598, 'res_996123', 'res_91a090', -751275471);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483597, 'res_996123', 'res_91a090', -1347802441);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483596, 'res_996123', 'res_91a090', 1673584235);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483595, 'res_996123', 'res_91a090', -2118135981);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483594, 'res_996123', 'res_91a090', 2074205376);

-- Inserting into table: restaurant_type --
INSERT INTO "restaurant_type" ("restypeid", "restypename", "restypedescription") VALUES (1, 'rhs_19c981', 'rhs_befece');

INSERT INTO "restaurant_type" ("restypeid", "restypename", "restypedescription") VALUES (2, 'rhs_19c981', 'rhs_befece');

INSERT INTO "restaurant_type" ("restypeid", "restypename", "restypedescription") VALUES (3, 'res_2223df', 'res_5fe45c');

-- Inserting into table: type_of_restaurant --
INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (3, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (3, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (3, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (3, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);

INSERT INTO "type_of_restaurant" ("restypeid", "resid") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___ FROM (SELECT LHS.resid AS resid, LHS.restypeid AS restypeid, LHS.restypename AS restypename, LHS.restypedescription AS restypedescription, RHS.resname AS resname, RHS.n AS n FROM (SELECT LHS.resid AS resid, LHS.restypeid AS restypeid, RHS.restypename AS restypename, RHS.restypedescription AS restypedescription FROM type_of_restaurant AS LHS INNER JOIN restaurant_type AS RHS ON (LHS.restypeid = RHS.restypeid)) AS LHS CROSS JOIN (SELECT resname, COUNT(*) AS n FROM restaurant GROUP BY resname) AS RHS) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
(51,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Restaurant JOIN Type_Of_Restaurant ON Restaurant.ResID = Type_Of_Restaurant.ResID JOIN Restaurant_Type ON Type_Of_Restaurant.ResTypeID = Restaurant_Type.ResTypeID GROUP BY Type_Of_Restaurant.ResTypeID HAVING Restaurant_Type.ResTypeName = 'Sandwich';

/*
Prediction Result:
*/