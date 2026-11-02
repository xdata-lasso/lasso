-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: pets --
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483648, 'pet_5d02c7', -55602865, 486.033807);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483647, 'pet_5d02c7', -664303813, 833.684115);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483646, 'pet_5d02c7', -1022641847, 97.952323);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483645, 'pet_5d02c7', 247012447, 868.436572);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483644, 'pet_5d02c7', -1980249628, 249.706432);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483643, 'pet_5d02c7', -734455130, 906.21648);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483642, 'pet_5d02c7', -1633151678, 134.487977);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483641, 'pet_5d02c7', -252690330, 797.015047);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483640, 'pet_5d02c7', 1115440883, 882.963176);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483639, 'pet_5d02c7', 1465859724, 294.861575);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483638, 'pet_5d02c7', -1349201381, 737.440743);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483637, 'pet_5d02c7', -1910425938, 303.05704);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483636, NULL, -1610064545, 22.535764);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483635, NULL, NULL, 600.048938);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483634, NULL, NULL, 240.969194);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483633, NULL, NULL, 267.815776);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483632, NULL, NULL, 192.379301);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483631, NULL, NULL, 607.794538);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483630, NULL, NULL, 792.223623);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483629, 'pet_5d02c7', NULL, 938.037625);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483628, 'pet_5d02c7', NULL, 921.185044);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483627, 'pet_5d02c7', NULL, 235.059956);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483626, 'pet_5d02c7', NULL, 619.836822);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483625, 'pet_5d02c7', NULL, 286.037632);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483624, 'pet_5d02c7', NULL, 126.856521);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483623, 'pet_5d02c7', NULL, 489.397796);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483622, 'pet_5d02c7', NULL, 933.422701);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483621, 'pet_5d02c7', NULL, 345.718563);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483620, 'pet_5d02c7', NULL, 510.466242);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483619, 'pet_5d02c7', NULL, 768.216462);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483618, 'pet_5d02c7', NULL, 83.204633);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483617, 'pet_5d02c7', NULL, 5.585347);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483616, 'pet_5d02c7', NULL, 871.191565);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483615, 'pet_5d02c7', NULL, 877.276439);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483614, 'pet_5d02c7', NULL, 627.258639);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483613, 'pet_5d02c7', NULL, 801.414196);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483612, 'pet_5d02c7', NULL, 890.762259);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483611, 'pet_5d02c7', NULL, 720.527846);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483610, 'pet_5d02c7', NULL, 963.351729);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483609, 'pet_5d02c7', NULL, 827.854302);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483608, 'pet_5d02c7', NULL, 983.124993);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483607, 'pet_5d02c7', NULL, 828.555322);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483606, 'pet_5d02c7', NULL, 38.208914);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483605, 'pet_5d02c7', NULL, 470.720385);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483604, 'pet_5d02c7', NULL, 74.576035);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483603, 'pet_5d02c7', NULL, 725.945531);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483602, 'pet_5d02c7', NULL, 42.488442);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483601, 'pet_5d02c7', NULL, 734.586266);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483600, 'pet_5d02c7', NULL, 767.720387);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483599, 'pet_5d02c7', NULL, 44.682291);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483598, 'pet_5d02c7', NULL, 73.182847);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483597, 'pet_5d02c7', NULL, 517.275698);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483596, 'pet_5d02c7', NULL, 962.037451);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483595, 'pet_5d02c7', NULL, 977.216501);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483594, 'pet_5d02c7', NULL, 769.021654);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483593, 'pet_5d02c7', NULL, 805.746877);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483592, 'pet_5d02c7', NULL, 322.782838);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483591, 'pet_5d02c7', NULL, 779.28645);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483590, 'pet_5d02c7', NULL, 566.030342);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483589, 'pet_5d02c7', NULL, 452.706544);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483588, 'pet_5d02c7', NULL, 672.826911);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483587, 'pet_5d02c7', NULL, 21.917736);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483586, 'pet_5d02c7', NULL, 325.900094);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483585, 'pet_5d02c7', NULL, 478.908865);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483584, 'pet_5d02c7', NULL, 203.577612);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483583, 'pet_5d02c7', NULL, 710.219803);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483582, 'pet_5d02c7', NULL, 979.158161);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanpet_age AS avg_pet_age_, maxpet_age AS max_pet_age_, pettype FROM (SELECT LHS.pettype AS pettype, LHS.meanpet_age AS meanpet_age, RHS.maxpet_age AS maxpet_age FROM (SELECT pettype, AVG(pet_age) AS meanpet_age FROM pets GROUP BY pettype) AS LHS LEFT JOIN (SELECT pettype, MAX(pet_age) AS maxpet_age FROM pets GROUP BY pettype) AS RHS ON (LHS.pettype = RHS.pettype)) ORDER BY avg_pet_age_, max_pet_age_ NULLS LAST, pettype NULLS LAST;

/*
Gold Result:
(-1610064545.0, None, None)
(-564534129.6666666, 1465859724, 'pet_5d02c7')
*/

-- Prediction Query
SELECT AVG(pet_age), MAX(pet_age), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(-1610064545.0, -1610064545, None)
(-564534129.6666666, 1465859724, 'pet_5d02c7')
*/