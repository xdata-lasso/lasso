-- Schema DDL
CREATE TABLE "regions" ("REGION_ID" REAL(5, 0) PRIMARY KEY, "REGION_NAME" TEXT(25));

CREATE TABLE "countries" ("COUNTRY_ID" TEXT(2) PRIMARY KEY, "REGION_ID" REAL(10, 0), "COUNTRY_NAME" TEXT(40), FOREIGN KEY ("REGION_ID") REFERENCES "regions" ("REGION_ID"));

CREATE TABLE "departments" ("DEPARTMENT_ID" REAL(4, 0) PRIMARY KEY, "DEPARTMENT_NAME" TEXT(30), "MANAGER_ID" REAL(6, 0), "LOCATION_ID" REAL(4, 0));

CREATE TABLE "jobs" ("JOB_ID" TEXT(10) PRIMARY KEY, "JOB_TITLE" TEXT(35), "MIN_SALARY" REAL(6, 0), "MAX_SALARY" REAL(6, 0));

CREATE TABLE "employees" ("EMPLOYEE_ID" REAL(6, 0) PRIMARY KEY, "JOB_ID" TEXT(10), "DEPARTMENT_ID" REAL(4, 0), "FIRST_NAME" TEXT(20), "LAST_NAME" TEXT(25), "EMAIL" TEXT(25), "PHONE_NUMBER" TEXT(20), "HIRE_DATE" DATE, "SALARY" REAL(8, 2), "COMMISSION_PCT" REAL(2, 2), "MANAGER_ID" REAL(6, 0), FOREIGN KEY ("JOB_ID") REFERENCES "jobs" ("JOB_ID"), FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "departments" ("DEPARTMENT_ID"));

CREATE TABLE "job_history" ("EMPLOYEE_ID" REAL(6, 0), "START_DATE" DATE, "JOB_ID" TEXT(10), "DEPARTMENT_ID" REAL(4, 0), "END_DATE" DATE, PRIMARY KEY ("EMPLOYEE_ID", "START_DATE"), FOREIGN KEY ("JOB_ID") REFERENCES "jobs" ("JOB_ID"), FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "departments" ("DEPARTMENT_ID"), FOREIGN KEY ("EMPLOYEE_ID") REFERENCES "employees" ("EMPLOYEE_ID"));

CREATE TABLE "locations" ("LOCATION_ID" REAL(4, 0) PRIMARY KEY, "COUNTRY_ID" TEXT(2), "STREET_ADDRESS" TEXT(40), "POSTAL_CODE" TEXT(12), "CITY" TEXT(30), "STATE_PROVINCE" TEXT(25), FOREIGN KEY ("COUNTRY_ID") REFERENCES "countries" ("COUNTRY_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1362.5, 'Robert Carter', 1375.5, 1388.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1363.5, 'Charles Schmidt', 1382.5, 1397.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1364.5, 'Rebecca Jackson', 1389.5, 1406.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1365.5, 'Seth Harvey', 1396.5, 1415.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1366.5, 'Thomas Thomas', 1403.5, 1424.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1367.5, 'David Scott', 1410.5, 1433.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1368.5, 'Robert Santana', 1417.5, 1442.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1369.5, 'Brooke Alexander', 1424.5, 1451.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1370.5, 'Kevin Fowler', 1431.5, 1460.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1371.5, 'David Bruce', 1438.5, 1469.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1372.5, 'James Webb', 1445.5, 1478.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1373.5, 'Kenneth Andrews', 1452.5, 1487.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1374.5, 'Elizabeth Spence DDS', 1459.5, 1496.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1479.5, 'Mark Johnson', 1492.5, 1505.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1480.5, 'Cindy Barnes', 1499.5, 1514.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1481.5, 'Jacob Griffith', 1506.5, 1523.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1482.5, 'Latoya Miller', 1513.5, 1532.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1483.5, 'Christopher Williamson', 1520.5, 1541.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1484.5, 'Denise Stanley', 1527.5, 1550.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1485.5, 'Mr. Donald Fischer', 1534.5, 1559.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1486.5, 'Jeffrey Campbell', 1541.5, 1568.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1487.5, 'Katelyn Estrada', 1548.5, 1577.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1488.5, 'James Greene', 1555.5, 1586.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1489.5, 'Eric Clark', 1562.5, 1595.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1490.5, 'David Murphy', 1569.5, 1604.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1491.5, 'Paul Thompson', 1576.5, 1613.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Haematologist', 'Fitness centre manager', 1401.5, 1414.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Actuary', 'Copywriter, advertising', 1408.5, 1423.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Systems developer', 'Chief Strategy Officer', 1415.5, 1432.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Artist', 'Archaeologist', 1422.5, 1441.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Trading standards officer', 'Insurance broker', 1429.5, 1450.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Research scientist (maths)', 'Prison officer', 1436.5, 1459.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Historic buildings inspector/conservation officer', 'Analytical chemist', 1443.5, 1468.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Event organiser', 'TEFL teacher', 1450.5, 1477.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Training and development officer', 'Medical sales representative', 1457.5, 1486.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Management consultant', 'Conservator, museum/gallery', 1464.5, 1495.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('English as a foreign language teacher', 'Chemical engineer', 1471.5, 1504.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Energy manager', 'Hotel manager', 1478.5, 1513.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Web designer', 'Journalist, newspaper', 1485.5, 1522.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Museum/gallery conservator', 'Teaching laboratory technician', 1518.5, 1531.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Site engineer', 'Pilot, airline', 1525.5, 1540.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Restaurant manager, fast food', 'Teacher, secondary school', 1532.5, 1549.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Surveyor, land/geomatics', 'Ophthalmologist', 1539.5, 1558.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Manufacturing systems engineer', 'Pensions consultant', 1546.5, 1567.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Building surveyor', 'Horticultural consultant', 1553.5, 1576.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Occupational psychologist', 'Colour technologist', 1560.5, 1585.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Archivist', 'Advertising art director', 1567.5, 1594.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Press photographer', 'Journalist, broadcasting', 1574.5, 1603.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Advertising account executive', 'Dramatherapist', 1581.5, 1612.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Psychiatric nurse', 'Waste management officer', 1588.5, 1621.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Careers adviser', 'Psychiatrist', 1595.5, 1630.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Intelligence analyst', 'Medical illustrator', 1602.5, 1639.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1427.5, 'Haematologist', 1362.5, 'Christopher', 'Luna', 'kmaldonado@example.net', '(706)543-1713x900', '1981-08-18', 1440.5, 1454.5, 1466.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1429.5, 'Haematologist', 1362.5, 'Gregory', 'Mccarty', 'brenda51@example.net', '(793)418-3933', '1981-08-19', 1459.5, 1474.5, 1489.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1430.5, 'Haematologist', 1362.5, 'David', 'Taylor', 'thomasharvey@example.net', '+1-704-522-8421x020', '1981-08-20', 1478.5, 1495.5, 1512.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1431.5, 'Haematologist', 1362.5, 'Amber', 'Levy', 'rose31@example.net', '001-350-324-0268', '1981-08-21', 1497.5, 1516.5, 1535.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1432.5, 'Haematologist', 1362.5, 'Teresa', 'Dalton', 'tblankenship@example.net', '975.289.1783x9084', '1981-08-22', 1516.5, 1537.5, 1558.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1433.5, 'Haematologist', 1362.5, 'Alyssa', 'Ramsey', 'cwilson@example.org', '7764617711', '1981-08-23', 1535.5, 1558.5, 1581.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1434.5, 'Haematologist', 1362.5, 'Robin', 'Whitney', 'wendy11@example.org', '624-999-8569', '1981-08-24', 1554.5, 1579.5, 1604.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1435.5, 'Haematologist', 1362.5, 'Maria', 'Coffey', 'paulwatson@example.net', '896.311.8367x36576', '1981-08-25', 1573.5, 1600.5, 1627.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1436.5, 'Haematologist', 1362.5, 'Jonathan', 'Ballard', 'umatthews@example.org', '465-245-2711x11615', '1981-08-26', 1592.5, 1621.5, 1650.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1437.5, 'Haematologist', 1362.5, 'Makayla', 'Diaz', 'fpena@example.net', '001-688-651-6560', '1981-08-27', 1611.5, 1642.5, 1673.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1438.5, 'Haematologist', 1362.5, 'Timothy', 'Gibbs', 'rcrosby@example.org', '(319)683-2731x585', '1981-08-28', 1630.5, 1663.5, 1696.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1439.5, 'Haematologist', 1362.5, 'Lindsay', 'Smith', 'jeff73@example.com', '001-636-289-9809', '1981-08-29', 1649.5, 1684.5, 1719.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1544.5, 'Haematologist', 1362.5, 'Matthew', 'Herrera', 'pollardmichael@example.net', '(844)355-0229', '1981-08-30', 1668.5, 1705.5, 1742.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1428.5, 'Museum/gallery conservator', 1479.5, 'Julie', 'Wilson', 'vrichardson@example.net', '(759)305-1518x64492', '1994-10-08', 1557.5, 1453.5, 1583.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1545.5, 'Museum/gallery conservator', 1479.5, 'Megan', 'Fuentes', 'michelle52@example.com', '001-825-746-2914', '1994-10-09', 1576.5, 1591.5, 1606.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1546.5, 'Museum/gallery conservator', 1479.5, 'John', 'Briggs', 'harrisoncrystal@example.com', '(481)568-5054', '1994-10-10', 1595.5, 1612.5, 1629.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1547.5, 'Museum/gallery conservator', 1479.5, 'Brianna', 'Young', 'bellcharles@example.com', '473-832-2141x88805', '1994-10-11', 1614.5, 1633.5, 1652.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1548.5, 'Museum/gallery conservator', 1479.5, 'Alexandria', 'Thomas', 'xjohnson@example.com', '(522)992-7065', '1994-10-12', 1633.5, 1654.5, 1675.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1549.5, 'Museum/gallery conservator', 1479.5, 'Randy', 'Gonzalez', 'newmantiffany@example.org', '+1-947-638-3473x597', '1994-10-13', 1652.5, 1675.5, 1698.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1550.5, 'Museum/gallery conservator', 1479.5, 'Kyle', 'Morrison', 'jford@example.net', '001-368-386-2392x40758', '1994-10-14', 1671.5, 1696.5, 1721.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1551.5, 'Museum/gallery conservator', 1479.5, 'Mason', 'Wolf', 'colelisa@example.net', '812-247-8261x3750', '1994-10-15', 1690.5, 1717.5, 1744.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1552.5, 'Museum/gallery conservator', 1479.5, 'Gary', 'Rios', 'marcalvarez@example.org', '(485)236-1530x5152', '1994-10-16', 1709.5, 1738.5, 1767.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1553.5, 'Museum/gallery conservator', 1479.5, 'William', 'Thompson', 'hayeslisa@example.com', '872-377-9010x4328', '1994-10-17', 1728.5, 1759.5, 1790.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1554.5, 'Museum/gallery conservator', 1479.5, 'Daniel', 'Mejia', 'wagnergerald@example.org', '001-243-541-0369x71179', '1994-10-18', 1747.5, 1780.5, 1813.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1555.5, 'Museum/gallery conservator', 1479.5, 'Rebecca', 'Snyder', 'hritter@example.net', '001-724-360-9539x621', '1994-10-19', 1766.5, 1801.5, 1836.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1556.5, 'Museum/gallery conservator', 1479.5, 'Michael', 'Webster', 'michaelhardin@example.com', '388.788.0670x65405', '1994-10-20', 1785.5, 1822.5, 1859.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT salary, manager_id FROM (SELECT * FROM (SELECT * FROM employees ORDER BY commission_pct, employees.employee_id NULLS LAST) LIMIT 107);

/*
Gold Result:
(1557.5, 1583.5)
(1440.5, 1466.5)
(1459.5, 1489.5)
(1478.5, 1512.5)
(1497.5, 1535.5)
(1516.5, 1558.5)
(1535.5, 1581.5)
(1554.5, 1604.5)
(1576.5, 1606.5)
(1573.5, 1627.5)
(1595.5, 1629.5)
(1592.5, 1650.5)
(1614.5, 1652.5)
(1611.5, 1673.5)
(1633.5, 1675.5)
(1630.5, 1696.5)
(1652.5, 1698.5)
(1649.5, 1719.5)
(1671.5, 1721.5)
(1668.5, 1742.5)
(1690.5, 1744.5)
(1709.5, 1767.5)
(1728.5, 1790.5)
(1747.5, 1813.5)
(1766.5, 1836.5)
(1785.5, 1859.5)
*/

-- Prediction Query
SELECT salary, manager_id FROM employees WHERE manager_id <> 'null';

/*
Prediction Result:
(1440.5, 1466.5)
(1459.5, 1489.5)
(1478.5, 1512.5)
(1497.5, 1535.5)
(1516.5, 1558.5)
(1535.5, 1581.5)
(1554.5, 1604.5)
(1573.5, 1627.5)
(1592.5, 1650.5)
(1611.5, 1673.5)
(1630.5, 1696.5)
(1649.5, 1719.5)
(1668.5, 1742.5)
(1557.5, 1583.5)
(1576.5, 1606.5)
(1595.5, 1629.5)
(1614.5, 1652.5)
(1633.5, 1675.5)
(1652.5, 1698.5)
(1671.5, 1721.5)
(1690.5, 1744.5)
(1709.5, 1767.5)
(1728.5, 1790.5)
(1747.5, 1813.5)
(1766.5, 1836.5)
(1785.5, 1859.5)
*/