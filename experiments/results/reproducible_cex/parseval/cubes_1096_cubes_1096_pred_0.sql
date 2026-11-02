-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: department --
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483648, '5k5swwqcgs', 'dep_04eeb3', 247012447, 868.436572, 537.136345);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483647, '4', 'dep_04eeb3', -734455130, 906.21648, 483.665643);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483646, 'hria2ypuzhs', 'dep_04eeb3', 700293388, 711.020062, 944.247544);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483645, 'p', 'dep_04eeb3', 13244799, 320.851235, 113.643485);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483644, 'l', 'dep_04eeb3', -845863578, 125.12763, 22.535764);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483643, 'nprmdposii', 'dep_04eeb3', -1823627488, 327.753528, 218.301157);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483642, 'klfa9000t', 'dep_04eeb3', 1408123494, 983.124993, 828.555322);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483641, '4', 'dep_04eeb3', 374105386, 950.466571, 796.740316);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483640, 'gce', 'dep_04eeb3', -1585009206, 191.847248, 807.142508);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483639, '2zbuo4nr', NULL, -967741825, 680.514642, 586.906897);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483638, 'p5s5bbp', NULL, 882961052, 673.065986, 825.231787);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483637, 'ut', NULL, -1347802441, 889.661694, 6.833035);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483636, 'ryytoo3', 'dep_04eeb3', -1666765085, 731.301441, 691.846832);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483635, '2klex14ji', 'dep_04eeb3', -453362185, 612.02959, 313.384575);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483634, 'dwyrq13p', 'dep_04eeb3', -533293970, 520.715697, 541.066766);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation FROM (SELECT creation, COUNT(*) AS n FROM department GROUP BY creation) WHERE (n <> 1) ORDER BY creation;

/*
Gold Result:
(None,)
('dep_04eeb3',)
*/

-- Prediction Query
SELECT creation FROM department GROUP BY creation ORDER BY COUNT(*) DESC, creation NULLS LAST LIMIT 1;

/*
Prediction Result:
('dep_04eeb3',)
*/