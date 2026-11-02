-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('boy', 'Susan Baldwin', 'red', 'scene');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('now', 'Benjamin Duncan', 'in', 'girl');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('lawyer', 'Jeremy Mosley', 'exactly', 'west');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('positive', 'Martin Fitzpatrick', 'civil', 'include');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('couple', 'Rachel Bailey', 'factor', 'style');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('series', 'David Wilson', 'argue', 'church');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('population', 'Anna Cox', 'daughter', 'reveal');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('behavior', 'Kimberly Robinson', 'budget', 'three');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1267, 'about', 'Powellland', 'institution', 'val_1271', 'val_1275');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1268, 'myself', 'North Patrick', 'around', 'val_1272', 'val_1276');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1269, 'yard', 'Martinezside', 'project', 'val_1273', 'val_1277');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1270, 'mean', 'Mathewport', 'radio', 'val_1274', 'val_1278');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1283, 'which', 'Lake Sandra', 'stock', 'val_1287', 'val_1291');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1284, 'matter', 'Lake Michaelborough', 'air', 'val_1288', 'val_1292');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1285, 'modern', 'Kingmouth', 'business', 'val_1289', 'val_1293');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1286, 'control', 'North Joyside', 'avoid', 'val_1290', 'val_1294');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('easy', 'Brittany', 'Nguyen', 'evance@example.com', 'degree', 'listen', '576.325.3492x929', 1267, 'boy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('grow', 'Katie', 'Cruz', 'imoss@example.org', 'money', 'admit', '390.332.0204x1792', 1267, 'boy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('history', 'Deborah', 'Lee', 'anthonydavies@example.org', 'they', 'although', '879-793-1365', 1267, 'boy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('light', 'Gregory', 'Dominguez', 'yprice@example.net', 'task', 'arrive', '798-325-3092', 1267, 'boy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('believe', 'Steve', 'Williams', 'mccoymichael@example.org', 'foot', 'role', '906-213-8782x93102', 1283, 'couple');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('nor', 'Mark', 'Maxwell', 'bbrown@example.org', 'government', 'outside', '(587)439-7740x63356', 1283, 'couple');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('set', 'James', 'Garcia', 'sarahgibson@example.com', 'care', 'as', '001-806-900-7806', 1283, 'couple');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('want', 'Erica', 'Kane', 'derek35@example.com', 'almost', 'together', '001-617-573-1806x325', 1283, 'couple');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('camera', 'concern', 1279, 'Dues', 'Just understand American beyond.', 'easy');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('color', 'same', 1286.0, 'Dues', 'Partner sing administration main according conference become prepare.', 'easy');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('eye', 'hope', 1293.0, 'Dues', 'Indicate southern significant realize deal.', 'easy');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('focus', 'on', 1300.0, 'Dues', 'Mission include visit particular also.', 'easy');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('chance', 'concern', 1295, 'Dues', 'With less catch.', 'believe');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('just', 'toward', 1302.0, 'Dues', 'Continue the phone region ability physical.', 'believe');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('relationship', 'small', 1309.0, 'Dues', 'Throw four allow international especially watch.', 'believe');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('score', 'past', 1316.0, 'Dues', 'Offer debate range per friend usually method.', 'believe');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.source = 'Dues' ORDER BY T2.date_received, T1.member_id NULLS LAST, T2.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Steve', 'Williams')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM income AS i JOIN member AS m ON i.link_to_member = m.member_id WHERE i.source = 'Dues' ORDER BY i.date_received, i.income_id NULLS LAST, m.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Brittany', 'Nguyen')
*/