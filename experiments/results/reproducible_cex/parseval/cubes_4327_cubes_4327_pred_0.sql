-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: repair --
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1, 'rwbbp6luhvd', 'tti', 'bnp');

INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (0, '8pz0f8je', 'd2', 'vy9uxj4');

-- Inserting into table: machine --
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'e4', 779.409124, 1160656988);

INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (-2147483647, 2087640001, 'dposiie5unw', 'klfa9000t', 'c4ecigce', 467.07027, -1585009206);

INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (-1, 1898504886, 'o3o9hl72klex', '4ji7zwa', '2dwyrq', 433.533777, -1);

INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (3, -1372125820, '4', 'p5qi2rk', '9v', 263.638479, 556727997);

INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (0, -261132974, 'dqwn', 'cx5hn', 'p', 269.734861, -841004020);

-- Inserting into table: technician --
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1.0, 't3__f35dad', 'ia2yp', 718.397869, -1670923962);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (2.0, 't3__f35dad', '52zb', 676.357279, -1179823637);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (787.938887, 't3__f35dad', 'rqro', 680.514642, 373262291);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (3.0, 'p5s5bbp', '02eutliqa11r', 997.73177, -525979501);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (-1.0, 't3__f35dad', 'pyu78d99', 272.376524, 1661181156);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (0.0, 'wb', 'v', 185.427628, 1581736075);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (0.5, 'dz79fjg', '8n2f3', 687.701166, 513454646);

-- Inserting into table: repair_assignment --
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1, 1, 1);

INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (2, 1, 1);

INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (3, 1, 1);

INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (-1, 1, 3);

INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (0, 0, 3);

INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (0, 1, -1);

INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1, 1, 0);

INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (0, 1, 3);

INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (0, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.machine_id AS machine_id, LHS.making_year AS making_year, LHS.class AS CLASS, LHS.team AS team, LHS.machine_series AS machine_series, LHS.value_points AS value_points, LHS.quality_rank AS quality_rank, RHS.name AS name, RHS.team AS team_other, RHS.starting_year AS starting_year, RHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id_other FROM machine AS LHS INNER JOIN (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) AS RHS ON (LHS.machine_id = RHS.technician_id)) ORDER BY name;

/*
Gold Result:
('p5s5bbp',)
('t3__f35dad',)
('t3__f35dad',)
('t3__f35dad',)
('wb',)
('wb',)
('wb',)
('wb',)
*/

-- Prediction Query
SELECT T3.Name FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id = T2.machine_id JOIN technician AS T3 ON T1.technician_ID = T3.technician_ID ORDER BY T2.quality_rank, T1.technician_id NULLS LAST, T1.repair_id NULLS LAST, T1.machine_id NULLS LAST, T2.machine_id NULLS LAST, T3.technician_id NULLS LAST;

/*
Prediction Result:
('wb',)
('t3__f35dad',)
('wb',)
('t3__f35dad',)
('wb',)
('wb',)
('t3__f35dad',)
('t3__f35dad',)
('p5s5bbp',)
*/