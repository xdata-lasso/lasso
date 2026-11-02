-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1014, 'skin', 'Hurstfurt', '47948', 'Iowa', 'Burundi');
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1020, 'theory', 'Johnbury', '74865', 'Colorado', 'Belize');
INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (1015, 'Mr');
INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (1021, 'sign');
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1016, 1014, 'minute', '1982-02-13', '1983-03-14', 'Christopher', 'Williams', 1017.5, 'hernandezernest@example.net', '(791)366-9784x80184', '562-470-4828x1489');
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1022, 1020, 'mention', '1988-08-19', '1989-09-20', 'Lisa', 'Spence', 1023.5, 'davidalvarez@example.net', '(848)796-3834', '587.213.3150x983');
INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (1018, 1014, 'Christopher Ashley', 'Sandra', 'Linda Burns', 'Rodriguez', '1984-04-15', '1985-05-16', '1986-06-17');
INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (1024, 1020, 'Mark Perez', 'Rebecca', 'Andrea Young', 'Caldwell', '1990-10-21', '1991-11-22', '1992-01-23');
INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (1, 1016, 1018, 1015, 'him', '1987-07-18', 'unit', 1019.5);
INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (1026, 1022, 1024, 1021, 'difficult', '1993-02-01', 'notice', 1025.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT vehicle_id, vehicle_details FROM (SELECT LHS.lesson_id AS lesson_id, LHS.customer_id AS customer_id, LHS.lesson_status_code AS lesson_status_code, LHS.staff_id AS staff_id, LHS.vehicle_id AS vehicle_id, LHS.lesson_date AS lesson_date, LHS.lesson_time AS lesson_time, LHS.price AS price, RHS.vehicle_details AS vehicle_details FROM lessons AS LHS INNER JOIN (SELECT vehicle_id, vehicle_details, COUNT(*) OVER () AS n FROM vehicles) AS RHS ON (LHS.vehicle_id = RHS.vehicle_id AND LHS.lesson_id = RHS.n)) ORDER BY vehicle_id, vehicle_details NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.vehicle_id, T1.vehicle_details FROM Vehicles AS T1 JOIN Lessons AS T2 ON T1.vehicle_id = T2.vehicle_id GROUP BY T1.vehicle_id ORDER BY COUNT(*) DESC, T1.vehicle_id NULLS LAST, T1.vehicle_details NULLS LAST LIMIT 1;

/*
Prediction Result:
(1015, 'Mr')
*/