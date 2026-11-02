-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_1', -55602865, 'swwqcgsk', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_2', 1610062532, 'pgu7vfe4', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_3', 1160656988, 'ia2yp', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_4', -1670923962, 'rwbbp6luhvd', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_5', -1377057208, 'ilbnp', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_6', 1236688122, 'dpos', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_7', -1576219117, '5u', NULL, 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_8', 1861536320, '6klfa9', NULL, 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_9', 1620389964, '00t5c4ecigc', NULL, 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_10', 528680845, '76nium52', 'per_fdac09', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_11', -443340271, 'uo4nrqrofqy', 'per_fdac09', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_12', -1106983592, '5bbp0', 'per_fdac09', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_13', 743312762, 'eutliqa11r', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_14', 2137741668, 'ytoo3o9hl7', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_15', 1178636309, 'ex1', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_16', -74849714, '7zw', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_17', 481163439, '2dwyrq', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_18', -1097120355, '78d99r', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_19', -1362461264, 'l0b4y', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_20', -1116181514, 'i2rkf', 'per_fdac09', 'per_6472e0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_21', 222415430, 'x58pz', 'per_fdac09', 'per_6472e0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, gender FROM (SELECT gender, job, COUNT(*) AS n FROM person GROUP BY gender, job) WHERE (n < 40) ORDER BY count___, gender NULLS LAST;

/*
Gold Result:
(3, 'per_fdac09')
(3, None)
(15, 'per_fdac09')
*/

-- Prediction Query
SELECT COUNT(*), gender FROM Person WHERE age < 40 GROUP BY gender;

/*
Prediction Result:
(1, None)
(9, 'per_fdac09')
*/