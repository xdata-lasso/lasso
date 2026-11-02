-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: department --
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483648, '4', 'gu7v', -1865039888, 779.409124, 640.719621);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483647, 'mdpos', 'ie5', -1209887326, 992.733505, 162.04354);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483646, 'a9', '00t5c4e', 1274489983, 128.76421, 610.208018);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483645, 'e', '76nium52', -443340271, 676.357279, 225.300904);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483644, 'rqrofqyp5s', 'bbp02eut', -1347802441, 889.661694, 6.833035);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483643, 'yytoo', 'o9hl72kl', -305670381, 144.777217, 598.409165);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483642, 'au2dwy', 'q13py', 244829661, 182.777264, 943.791649);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483641, 'b4yp5qi', 'rkf9vqx5', 1836127587, 410.133844, 88.474525);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483640, 'gd', '1vy9uxj4', -1612443122, 22.63964, 328.40866);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483639, 'h2gndqwnqcx5', 'hncprjtu0dz', -1748371085, 94.390081, 541.805676);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483638, '3d', 'qv0gcb98ozk', -155284187, 892.659478, 138.057338);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483637, 'kn6vck6ah0f8', 'sww', -1388029300, 842.831917, 521.426676);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483636, '7', '2fxa7ryfdrz', 61479715, 130.468488, 151.555666);

-- Inserting into table: head --
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1, '5k5swwqcgs', '9n8', 1.0);

INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (3, 'ri', 'a2ypuzhsrwbb', 749.826493);

INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (2, 'hvdltt', 'lbn', 1.0);

-- Inserting into table: management --
INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483648, 1, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483648, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483647, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483646, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483645, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483644, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483643, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483642, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483646, 2, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483641, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483640, 2, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483639, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483645, 2, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483638, 3, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483642, 1, 't2__c2d1d7');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483637, 3, 't2__86f12f');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483637, 1, 'Yes');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (-2147483636, 3, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "age" FROM (SELECT "LHS"."head_id" AS "head_id", "LHS"."name" AS "name", "LHS"."born_state" AS "born_state", "LHS"."age" AS "age", "RHS"."department_id" AS "department_id", "RHS"."temporary_acting" AS "temporary_acting" FROM "head" AS "LHS" INNER JOIN "management" AS "RHS" ON ("LHS"."head_id" = "RHS"."head_id")) WHERE ("temporary_acting" = 'Yes') ORDER BY age, "age" NULLS LAST;

/*
Gold Result:
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(749.826493,)
(749.826493,)
(749.826493,)
(749.826493,)
(749.826493,)
(749.826493,)
(749.826493,)
(749.826493,)
(749.826493,)
(749.826493,)
(749.826493,)
*/

-- Prediction Query
SELECT DISTINCT T1.age FROM management AS T2 JOIN head AS T1 ON T1.head_id = T2.head_id WHERE T2.temporary_acting = 'Yes';

/*
Prediction Result:
(1.0,)
(749.826493,)
*/