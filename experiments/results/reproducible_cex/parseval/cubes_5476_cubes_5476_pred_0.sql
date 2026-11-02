-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_5554fd', 'stu_ebb0d7', -1022641847, 'f', -1726781632, 247012447, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'stu_5554fd', 'stu_ebb0d7', -1980249628, 'f', -734455130, 1744686505, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'stu_5554fd', 'stu_ebb0d7', -1633151678, 'f', -252690330, 1115440883, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (4, 'stu_5554fd', 'stu_ebb0d7', 1644814318, 'f', 1465859724, -1349201381, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (5, 'stu_5554fd', 'stu_ebb0d7', 1019800248, 'f', -1910425938, -845863578, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (6, 'stu_5554fd', 'stu_ebb0d7', -1610064545, 'f', 429706943, 462974032, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (7, 'stu_5554fd', 'stu_ebb0d7', -1137908826, 'f', -918961358, -1602639011, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (8, 'stu_5554fd', 'stu_ebb0d7', -45536098, 'f', 1861536320, 44952191, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (9, 'stu_5554fd', 'stu_ebb0d7', 1151980946, 'f', 1620389964, 546571701, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (10, 'stu_5554fd', 'stu_ebb0d7', 947159877, 'f', 1990080517, 1408123494, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (11, 'stu_5554fd', 'stu_ebb0d7', -1964997180, 'f', 1149850321, -1833165707, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (12, 'stu_5554fd', 'stu_ebb0d7', 1155439218, 'f', 1313172851, -761141909, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (13, 'stu_5554fd', 'stu_ebb0d7', 283598170, 'f', 742285925, -747753377, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (14, 'stu_5554fd', 'stu_ebb0d7', 902887186, 'f', -967741825, 775304493, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (15, 'stu_5554fd', 'stu_ebb0d7', 373262291, 'f', -472966518, -921187550, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (16, 'stu_5554fd', 'stu_ebb0d7', -2070843029, 'f', 328305758, -751275471, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (17, 'stu_5554fd', 'stu_ebb0d7', -1347802441, 'f', 1673584235, -2118135981, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (18, 'stu_5554fd', 'stu_ebb0d7', 2074205376, 'f', 274769912, -188151580, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (19, 'stu_5554fd', 'stu_ebb0d7', 226938182, 'f', 90119032, -1438850342, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (20, 'stu_5554fd', 'stu_ebb0d7', -305670381, 'f', -1525670226, -453362185, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483627, 'q_2_1f6301', 'q_2_88d63e', 481163439, 'f', 2123196517, 364869063, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483626, 'q_2_1f6301', 'q_2_88d63e', -953437896, 'f', -1097120355, 244829661, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483625, 'q_2_1f6301', 'q_2_88d63e', -1362461264, 'f', -904834265, -346339240, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483624, 'q_2_1f6301', 'q_2_88d63e', 1692174491, 'f', -1025564911, -227162283, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483623, 'q_2_1f6301', 'q_2_88d63e', 2056419640, 'f', 222415430, 556727997, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483622, 'q_2_1f6301', 'q_2_88d63e', 1178000634, 'f', 1836127587, -1529584866, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483621, 'q_2_1f6301', 'q_2_88d63e', 1196308825, 'f', 910894705, -283454505, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483620, 'q_2_1f6301', 'q_2_88d63e', 233994589, 'f', 1442655647, -87647544, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483619, 'q_2_1f6301', 'q_2_88d63e', -629784617, 'f', -1929953647, 1581736075, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483618, 'q_2_1f6301', 'q_2_88d63e', -261132974, 'f', -1264842910, -1052964641, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483617, 'q_2_1f6301', 'q_2_88d63e', -1245682094, 'f', -1660358170, -1106350634, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483616, 'q_2_1f6301', 'q_2_88d63e', -1509264256, 'f', -792947627, -1898531797, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483615, 'q_2_1f6301', 'q_2_88d63e', -1748371085, 'f', -1742081330, 894242932, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483614, 'q_2_1f6301', 'q_2_88d63e', -211209314, 'f', -1056308489, -1454058168, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483613, 'q_2_1f6301', 'q_2_88d63e', -2078052421, 'f', -512640349, 1038566008, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483612, 'q_2_1f6301', 'q_2_88d63e', 32204797, 'f', -1672720816, -1520489792, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483611, 'q_2_1f6301', 'q_2_88d63e', -658391922, 'f', -1388029300, -566887085, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483610, 'q_2_1f6301', 'q_2_88d63e', 602161869, 'f', 1350414441, 2094425101, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483609, 'q_2_1f6301', 'q_2_88d63e', -961217731, 'f', -1888505890, 777149609, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (21, 'stu_5554fd', 'stu_ebb0d7', 61479715, 'f', -1496556994, -2115841792, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (22, 'stu_5554fd', 'stu_ebb0d7', 1746373317, 'f', 1360271423, 1583472758, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (23, 'stu_5554fd', 'stu_ebb0d7', 1449284300, 'f', -977470238, -1478247928, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (24, 'stu_5554fd', 'stu_ebb0d7', 1074760385, 'f', 1129658414, 1250290042, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (25, 'stu_5554fd', 'stu_ebb0d7', -1717646459, 'f', -1696173285, 710458518, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (26, 'stu_5554fd', 'stu_ebb0d7', 678047687, 'f', -1478134144, -491938169, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (27, 'stu_5554fd', 'stu_ebb0d7', -106471771, 'f', 1235416111, 1923912467, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (28, 'stu_5554fd', 'stu_ebb0d7', 518609210, 'f', 1948383687, 1476361420, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (29, 'stu_5554fd', 'stu_ebb0d7', 195720193, 'f', 1774087382, 1732258051, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (30, 'stu_5554fd', 'stu_ebb0d7', -1762140823, 'f', 1371234901, -290314193, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (31, 'stu_5554fd', 'stu_ebb0d7', 76996700, 'f', -435350511, 1992637800, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (32, 'stu_5554fd', 'stu_ebb0d7', -820614248, 'f', 481546706, -1784554553, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (33, 'stu_5554fd', 'stu_ebb0d7', -242584410, 'f', -698610044, -1021978385, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (34, 'stu_5554fd', 'stu_ebb0d7', 569007824, 'f', -1139855872, -288338724, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (35, 'stu_5554fd', 'stu_ebb0d7', 1897687032, 'f', -241848752, 2004147439, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (36, 'stu_5554fd', 'stu_ebb0d7', -691774480, 'f', -1523347137, 1582582341, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (37, 'stu_5554fd', 'stu_ebb0d7', 453836040, 'f', 1467355421, -1171104889, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (38, 'stu_5554fd', 'stu_ebb0d7', -29242208, 'f', 1691780814, 1944978593, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (39, 'stu_5554fd', 'stu_ebb0d7', 1722106924, 'f', -2072838897, -1173368267, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483589, 'q_2_1f6301', 'q_2_88d63e', 382831862, 'f', -406331049, -461418236, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483588, 'q_2_1f6301', 'q_2_88d63e', -468701684, 'f', 1448731351, -604098478, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483587, 'q_2_1f6301', 'q_2_88d63e', 1248858185, 'f', -57705450, -915385605, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483586, 'q_2_1f6301', 'q_2_88d63e', -2005628382, 'f', 1721638020, 983324983, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483585, 'q_2_1f6301', 'q_2_88d63e', 1269522000, 'f', 853709925, -870767087, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483584, 'q_2_1f6301', 'q_2_88d63e', -1699185893, 'f', 875300074, -1609653472, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483583, 'q_2_1f6301', 'q_2_88d63e', -1405314653, 'f', 1816660482, -1212676731, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483582, 'q_2_1f6301', 'q_2_88d63e', 1692046802, 'f', -1300180872, -1125548818, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483581, 'q_2_1f6301', 'q_2_88d63e', 1497321728, 'f', -95808609, -244633520, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483580, 'q_2_1f6301', 'q_2_88d63e', 418247369, 'f', -1524425594, -1351793914, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483579, 'q_2_1f6301', 'q_2_88d63e', 1919033056, 'f', -1428186898, -761353513, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483578, 'q_2_1f6301', 'q_2_88d63e', 362376128, 'f', -1311735207, -229022515, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483577, 'q_2_1f6301', 'q_2_88d63e', -1817527403, 'f', -1402164108, 2123471885, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483576, 'q_2_1f6301', 'q_2_88d63e', -526633767, 'f', 448935289, 458835042, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483575, 'q_2_1f6301', 'q_2_88d63e', 924693315, 'f', -705922211, 1043710187, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483574, 'q_2_1f6301', 'q_2_88d63e', 318331233, 'f', -233617564, 79330142, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483573, 'q_2_1f6301', 'q_2_88d63e', 1735561423, 'f', 756202403, 782684333, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483572, 'q_2_1f6301', 'q_2_88d63e', 681598285, 'f', 319284352, 1164790775, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483571, 'q_2_1f6301', 'q_2_88d63e', -200807520, 'f', -790819470, -1278087274, 'db6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, AVG(age) OVER () AS meanage FROM student) ORDER BY age) LIMIT 19);

/*
Gold Result:
('q_2_88d63e', 'q_2_1f6301')
('stu_ebb0d7', 'stu_5554fd')
('q_2_88d63e', 'q_2_1f6301')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('q_2_88d63e', 'q_2_1f6301')
('stu_ebb0d7', 'stu_5554fd')
('q_2_88d63e', 'q_2_1f6301')
('stu_ebb0d7', 'stu_5554fd')
('q_2_88d63e', 'q_2_1f6301')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('stu_ebb0d7', 'stu_5554fd')
('q_2_88d63e', 'q_2_1f6301')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
*/

-- Prediction Query
SELECT fname, lname FROM student WHERE age < (SELECT AVG(age) FROM student);

/*
Prediction Result:
('stu_ebb0d7', 'stu_5554fd')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('q_2_88d63e', 'q_2_1f6301')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
('stu_ebb0d7', 'stu_5554fd')
*/