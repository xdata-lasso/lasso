-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by first_name, distinct projections, and ensures first_name sort does not accidentally match staff_id, middle_name, or last_name sorts.
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '101 Main St', 'Metropolis', '10001', 'NY', 'USA');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (10, 1, 'Zack', 'Zoe', 'Alice', 'Anderson', '1980-01-01', '2010-01-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (20, 1, 'Alex', 'Aaron', 'Zachary', 'Zimmerman', '1985-05-05', '2015-05-05', '2020-01-01');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (5, 1, 'Mike', 'Michael', 'John', 'Miller', '1990-10-10', '2018-10-10', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, middle_name, last_name FROM staff ORDER BY first_name, staff.staff_id NULLS LAST;

/*
Gold Result:
('Aaron', 'Zachary', 'Zimmerman')
('Michael', 'John', 'Miller')
('Zoe', 'Alice', 'Anderson')
*/

-- Prediction Query
SELECT first_name, middle_name, last_name FROM Staff;

/*
Prediction Result:
('Michael', 'John', 'Miller')
('Zoe', 'Alice', 'Anderson')
('Aaron', 'Zachary', 'Zimmerman')
*/