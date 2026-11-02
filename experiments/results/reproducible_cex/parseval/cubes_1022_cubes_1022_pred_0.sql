-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_1', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_2', 'e4', 2.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_3', 'e4', 3.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_4', 'e4', 4.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_5', 'e4', 5.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_6', 'e4', 6.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_7', 'e4', 7.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_8', 'e4', 8.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_9', 'e4', 9.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_10', 'e4', 10.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_11', 'e4', 11.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_12', 'e4', 12.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_13', 'e4', 13.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_14', 'e4', 14.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_15', 'e4', 15.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_16', 'e4', 16.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_17', 'e4', 17.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_18', 'e4', 18.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_19', 'e4', 19.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_20', 'e4', 20.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_21', 'e4', 21.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_22', 'e4', 22.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_23', 'e4', 23.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_24', 'e4', 24.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_25', 'e4', 25.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_26', 'e4', 26.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_27', 'e4', 27.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_28', 'e4', 28.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_29', 'e4', 29.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_30', 'e4', 30.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_31', 'e4', 31.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_32', 'e4', 32.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_33', 'e4', 33.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_34', 'e4', 34.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_35', 'e4', 35.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_36', 'e4', 36.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_37', 'e4', 37.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_38', 'e4', 38.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_39', 'e4', 39.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_40', 'e4', 40.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_41', 'e4', 41.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_42', 'e4', 42.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_43', 'e4', 43.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_44', 'e4', 44.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_45', 'e4', 45.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_46', 'e4', 46.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_47', 'e4', 47.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_48', 'e4', 48.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_49', 'e4', 49.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_50', 'e4', 50.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_51', 'e4', 51.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_52', 'e4', 52.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_53', 'e4', 53.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_54', 'e4', 54.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_55', 'e4', 55.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_56', 'e4', 56.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_57', 'e4', 57.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_58', 'e4', 58.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_59', 'e4', 59.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_60', 'e4', 60.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_61', 'e4', 61.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_62', 'e4', 62.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_63', 'e4', 63.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_64', 'e4', 64.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_65', 'e4', 65.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_66', 'e4', 66.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_67', 'e4', 67.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_68', 'e4', 68.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_69', 'e4', 69.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_70', 'e4', 70.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_71', 'e4', 71.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_72', 'e4', 72.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_73', 'e4', 73.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_74', 'e4', 74.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_75', 'e4', 75.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_76', 'e4', 76.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_77', 'e4', 77.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_78', 'e4', 78.0);

-- Inserting into table: player --
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1.0, 'pla_73808a', 'f5d', 1.0);

-- Inserting into table: tryout --
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_1', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_2', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_3', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_4', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_5', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_6', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_7', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_8', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_9', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_10', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_11', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_12', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_13', NULL, 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_14', NULL, 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_15', NULL, 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_16', NULL, 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_17', NULL, 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_18', NULL, 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_19', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_20', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_21', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_22', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_23', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_24', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_25', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_26', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_27', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_28', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_29', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_30', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_31', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_32', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_33', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_34', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_35', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_36', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_37', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_38', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_39', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_40', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_41', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_42', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_43', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_44', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_45', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_46', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_47', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_48', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_49', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_50', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_51', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_52', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_53', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_54', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_55', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_56', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_57', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_58', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_59', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_60', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_61', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_62', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_63', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_64', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_65', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_66', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_67', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_68', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_69', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_70', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_71', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_72', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_73', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_74', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_75', 'try_794ac7', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_76', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_77', 'try_986ac5', 'value');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_78', 'try_986ac5', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.ppos AS ppos, LHS.n AS n, RHS.pid AS pid_other, RHS.ppos AS ppos_other, RHS.n AS n_other FROM (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS LHS CROSS JOIN (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS RHS) WHERE (n > n_other) ORDER BY ppos;

/*
Gold Result:
('try_794ac7',)
('try_986ac5',)
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('try_794ac7',)
*/