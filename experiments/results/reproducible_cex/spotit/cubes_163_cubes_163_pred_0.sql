-- Schema DDL
CREATE TABLE "BREEDS" (
    "BREED_CODE" TEXT,
    "BREED_NAME" TEXT,
    PRIMARY KEY ("BREED_CODE")
);
CREATE TABLE "CHARGES" (
    "CHARGE_ID" INT,
    "CHARGE_TYPE" TEXT,
    "CHARGE_AMOUNT" FLOAT,
    PRIMARY KEY ("CHARGE_ID")
);
CREATE TABLE "SIZES" (
    "SIZE_CODE" TEXT,
    "SIZE_DESCRIPTION" TEXT,
    PRIMARY KEY ("SIZE_CODE")
);
CREATE TABLE "TREATMENT_TYPES" (
    "TREATMENT_TYPE_CODE" TEXT,
    "TREATMENT_TYPE_DESCRIPTION" TEXT,
    PRIMARY KEY ("TREATMENT_TYPE_CODE")
);
CREATE TABLE "OWNERS" (
    "OWNER_ID" INT,
    "FIRST_NAME" TEXT,
    "LAST_NAME" TEXT,
    "STREET" TEXT,
    "CITY" TEXT,
    "STATE" TEXT,
    "ZIP_CODE" TEXT,
    "EMAIL_ADDRESS" TEXT,
    "HOME_PHONE" TEXT,
    "CELL_NUMBER" TEXT,
    PRIMARY KEY ("OWNER_ID")
);
CREATE TABLE "DOGS" (
    "DOG_ID" INT,
    "OWNER_ID" INT,
    "SIZE_CODE" TEXT,
    "BREED_CODE" TEXT,
    "ABANDONED_YN" TEXT,
    "NAME" TEXT,
    "AGE" TEXT,
    "DATE_OF_BIRTH" DATETIME,
    "GENDER" TEXT,
    "WEIGHT" TEXT,
    "DATE_ARRIVED" DATETIME,
    "DATE_ADOPTED" DATETIME,
    "DATE_DEPARTED" DATETIME,
    PRIMARY KEY ("DOG_ID"),
    FOREIGN KEY ("OWNER_ID") REFERENCES "OWNERS"("OWNER_ID"),
    FOREIGN KEY ("SIZE_CODE") REFERENCES "SIZES"("SIZE_CODE"),
    FOREIGN KEY ("BREED_CODE") REFERENCES "BREEDS"("BREED_CODE")
);
CREATE TABLE "PROFESSIONALS" (
    "PROFESSIONAL_ID" INT,
    "ROLE_CODE" TEXT,
    "FIRST_NAME" TEXT,
    "STREET" TEXT,
    "CITY" TEXT,
    "STATE" TEXT,
    "ZIP_CODE" TEXT,
    "LAST_NAME" TEXT,
    "EMAIL_ADDRESS" TEXT,
    "HOME_PHONE" TEXT,
    "CELL_NUMBER" TEXT,
    PRIMARY KEY ("PROFESSIONAL_ID")
);
CREATE TABLE "TREATMENTS" (
    "TREATMENT_ID" INT,
    "DOG_ID" INT,
    "PROFESSIONAL_ID" INT,
    "TREATMENT_TYPE_CODE" TEXT,
    "DATE_OF_TREATMENT" DATETIME,
    "COST_OF_TREATMENT" FLOAT,
    PRIMARY KEY ("TREATMENT_ID"),
    FOREIGN KEY ("DOG_ID") REFERENCES "DOGS"("DOG_ID"),
    FOREIGN KEY ("PROFESSIONAL_ID") REFERENCES "PROFESSIONALS"("PROFESSIONAL_ID"),
    FOREIGN KEY ("TREATMENT_TYPE_CODE") REFERENCES "TREATMENT_TYPES"("TREATMENT_TYPE_CODE")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO BREEDS VALUES (13, 0);
INSERT INTO BREEDS VALUES (66, 0);
INSERT INTO CHARGES VALUES (0, 0, 0);
INSERT INTO CHARGES VALUES (1, 0, 0);
INSERT INTO SIZES VALUES (65, 0);
INSERT INTO SIZES VALUES (5, 0);
INSERT INTO TREATMENT_TYPES VALUES (6, 0);
INSERT INTO TREATMENT_TYPES VALUES (7, 0);
INSERT INTO OWNERS VALUES (0, 41, 0, 42, NULL, NULL, 45, NULL, NULL, 48);
INSERT INTO OWNERS VALUES (-1, 56, 57, 58, 59, 60, 61, 62, 63, 64);
INSERT INTO DOGS VALUES (0, 0, 65, 13, 49, NULL, 0, 51, 17, 52, 53, 54, 55);
INSERT INTO DOGS VALUES (1, -1, 65, 66, 67, 68, 1, 69, 17, 70, 71, NULL, 73);
INSERT INTO PROFESSIONALS VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PROFESSIONALS VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO TREATMENTS VALUES (-1, 0, 1, 6, 0, 0);
INSERT INTO TREATMENTS VALUES (0, 1, 1, 6, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM dogs AS LHS INNER JOIN owners AS RHS ON (LHS.owner_id = RHS.owner_id)) AS LHS INNER JOIN (SELECT gender, MAX(age) AS age FROM dogs GROUP BY gender) AS RHS ON (LHS.age = RHS.age AND LHS.gender = RHS.gender)) ORDER BY last_name;

/*
Gold Result:
('57',)
*/

-- Prediction Query
SELECT T1.last_name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id WHERE T2.age = (SELECT MAX(age) FROM Dogs);

/*
Prediction Result:
('57',)
*/