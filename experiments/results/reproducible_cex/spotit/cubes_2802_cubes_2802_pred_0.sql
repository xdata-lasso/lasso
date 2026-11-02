-- Schema DDL
CREATE TABLE "APARTMENT_BUILDINGS" (
    "BUILDING_ID" INT,
    "BUILDING_SHORT_NAME" TEXT,
    "BUILDING_FULL_NAME" TEXT,
    "BUILDING_DESCRIPTION" TEXT,
    "BUILDING_ADDRESS" TEXT,
    "BUILDING_MANAGER" TEXT,
    "BUILDING_PHONE" TEXT,
    PRIMARY KEY ("BUILDING_ID")
);
CREATE TABLE "APARTMENTS" (
    "APT_ID" INT,
    "BUILDING_ID" INT,
    "APT_TYPE_CODE" TEXT,
    "APT_NUMBER" TEXT,
    "BATHROOM_COUNT" INT,
    "BEDROOM_COUNT" INT,
    "ROOM_COUNT" TEXT,
    PRIMARY KEY ("APT_ID"),
    FOREIGN KEY ("BUILDING_ID") REFERENCES "APARTMENT_BUILDINGS"("BUILDING_ID")
);
CREATE TABLE "APARTMENT_FACILITIES" (
    "APT_ID" INT,
    "FACILITY_CODE" TEXT,
    PRIMARY KEY ("APT_ID", "FACILITY_CODE"),
    FOREIGN KEY ("APT_ID") REFERENCES "APARTMENTS"("APT_ID")
);
CREATE TABLE "GUESTS" (
    "GUEST_ID" INT,
    "GENDER_CODE" TEXT,
    "GUEST_FIRST_NAME" TEXT,
    "GUEST_LAST_NAME" TEXT,
    "DATE_OF_BIRTH" DATETIME,
    PRIMARY KEY ("GUEST_ID")
);
CREATE TABLE "APARTMENT_BOOKINGS" (
    "APT_BOOKING_ID" INT,
    "GUEST_ID" INT,
    "APT_ID" INT,
    "BOOKING_STATUS_CODE" TEXT,
    "BOOKING_START_DATE" DATETIME,
    "BOOKING_END_DATE" DATETIME,
    PRIMARY KEY ("APT_BOOKING_ID"),
    FOREIGN KEY ("GUEST_ID") REFERENCES "GUESTS"("GUEST_ID"),
    FOREIGN KEY ("APT_ID") REFERENCES "APARTMENTS"("APT_ID")
);
CREATE TABLE "VIEW_UNIT_STATUS" (
    "STATUS_DATE" DATETIME,
    "APT_BOOKING_ID" INT,
    "APT_ID" INT,
    "AVAILABLE_YN" BIT,
    PRIMARY KEY ("STATUS_DATE"),
    FOREIGN KEY ("APT_BOOKING_ID") REFERENCES "APARTMENT_BOOKINGS"("APT_BOOKING_ID"),
    FOREIGN KEY ("APT_ID") REFERENCES "APARTMENTS"("APT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO APARTMENT_BUILDINGS VALUES (1, 0, 0, 0, 0, 0, 0);
INSERT INTO APARTMENT_BUILDINGS VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO APARTMENTS VALUES (1, 0, -1, 35, 2, 2, 27);
INSERT INTO APARTMENTS VALUES (0, 1, 0, 36, 2, 2, 27);
INSERT INTO APARTMENT_FACILITIES VALUES (1, 7);
INSERT INTO APARTMENT_FACILITIES VALUES (1, 8);
INSERT INTO GUESTS VALUES (0, 0, 0, 0, 0);
INSERT INTO GUESTS VALUES (-1, 0, 0, 0, 0);
INSERT INTO APARTMENT_BOOKINGS VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO APARTMENT_BOOKINGS VALUES (0, 0, 1, 0, 0, 0);
INSERT INTO VIEW_UNIT_STATUS VALUES (11, 1, 0, 0);
INSERT INTO VIEW_UNIT_STATUS VALUES (12, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_type_code FROM (SELECT apt_id, building_id, apt_type_code, apt_number, bedroom_count AS bathroom_count, bedroom_count, room_count, apt_id_other, building_id_other, apt_type_code_other, apt_number_other, bedroom_count_other FROM (SELECT LHS.apt_id AS apt_id, LHS.building_id AS building_id, LHS.apt_type_code AS apt_type_code, LHS.apt_number AS apt_number, LHS.bathroom_count AS bathroom_count, LHS.bedroom_count AS bedroom_count, LHS.room_count AS room_count, RHS.apt_id AS apt_id_other, RHS.building_id AS building_id_other, RHS.apt_type_code AS apt_type_code_other, RHS.apt_number AS apt_number_other, RHS.bedroom_count AS bedroom_count_other FROM apartments AS LHS INNER JOIN apartments AS RHS ON (LHS.bedroom_count = RHS.bathroom_count AND LHS.room_count = RHS.room_count))) ORDER BY apt_type_code;

/*
Gold Result:
('-1',)
('-1',)
('0',)
('0',)
*/

-- Prediction Query
SELECT apt_type_code FROM Apartments WHERE bathroom_count > 1 GROUP BY apt_type_code ORDER BY COUNT(*) DESC, apt_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/