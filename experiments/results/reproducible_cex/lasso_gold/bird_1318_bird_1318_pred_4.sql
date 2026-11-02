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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('method', 'Douglas Carlson', 'up', 'nation', 'Result major serve real position.', '74989 Hooper Village
West Jeremy, HI 40119', 'when');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('difference', 'Douglas Carlson', 'fact', 'yourself', 'Large admit family identify during professional hard.', '0084 Dana Terrace
Garciatown, OK 37769', 'level');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('hear', 'Douglas Carlson', 'only', 'cut', 'Most international second former reflect even edge.', '2047 Lynn Locks Suite 190
East Lisa, ME 11665', 'finish');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('subject', 'Douglas Carlson', 'action', 'bed', 'Return firm sea week.', 'Unit 1869 Box 9938
DPO AA 59550', 'trade');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('say', 'Lisa Allen', 'cold', 'old', 'Left brother strategy marriage.', '78755 Gibson Islands Apt. 396
Port Kimberly, AZ 42205', 'lawyer');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('memory', 'Lisa Allen', 'foreign', 'involve', 'Meeting event strong woman during.', '2702 Kane Well Suite 187
Lake Douglasberg, CA 62038', 'child');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('campaign', 'Lisa Allen', 'ok', 'better', 'Certain course out second carry attorney significant.', '9615 Finley Road Suite 809
East Crystalport, IN 98381', 'election');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('air', 'Lisa Allen', 'address', 'down', 'Future skin environment able rise study.', '172 Berger Cape
Lauraport, MI 49632', 'nice');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('than', 'Lisa Allen', 'five', 'challenge', 'You break doctor Mr home.', '64317 Elizabeth Row Apt. 053
Port Anne, CA 73142', 'life');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('majority', 'Lisa Allen', 'range', 'answer', 'Provide sea watch industry score choice.', '52904 Vanessa Plains
Laurenville, TN 03880', 'back');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('where', 'Lisa Allen', 'issue', 'young', 'Pressure street past voice evidence real.', '95024 David Manor Apt. 177
Williamville, NV 66540', 'way');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('school', 'Lisa Allen', 'but', 'always', 'Kitchen wear talk between rate.', '847 Bruce Neck
Simmonsville, NM 93876', 'be');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('per', 'Elizabeth Oliver DDS', 'sister', 'bit');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('its', 'Rebecca Jackson', 'bar', 'poor');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('fund', 'Ana Hill', 'property', 'pay');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1013, 'source', 'Lake Jason', 'recent', 'Colorado', 'Hawaii');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1017, 'truth', 'Harveybury', 'modern', 'Pennsylvania', 'Georgia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1021, 'official', 'Oscarhaven', 'financial', 'New Jersey', 'North Carolina');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.jones.org/', 'Rebekah', 'Parker', 'harrisonkevin@example.com', 'against', 'exist', '(378)974-2967', 1013, 'per');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://hall.com/', 'Margaret', 'Curry', 'vincent77@example.org', 'southern', 'part', '(265)951-2567x468', 1013, 'per');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.hall.org/', 'Charles', 'Carroll', 'prestonjessica@example.net', 'remember', 'amount', '954-851-6808', 1013, 'per');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://stephens.com/', 'Gabriel', 'Roberts', 'anthony39@example.net', 'term', 'something', '6384597703', 1013, 'per');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://king.info/', 'Kenneth', 'Foster', 'lozanojulie@example.com', 'among', 'along', '(714)656-2328', 1017, 'its');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.alexander.org/', 'Holly', 'Smith', 'catherinegomez@example.net', 'for', 'particularly', '(547)845-1712', 1017, 'its');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://wright.biz/', 'Andrew', 'Grimes', 'christinebyrd@example.net', 'story', 'his', '+1-751-660-4817', 1017, 'its');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.james.org/', 'Maria', 'Osborne', 'courtneyberger@example.net', 'let', 'sign', '001-765-513-7098', 1017, 'its');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.wilson.net/', 'Ryan', 'Brown', 'qgomez@example.com', 'through', 'family', '(289)498-0940x24455', 1021, 'fund');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://beasley-gutierrez.info/', 'Julie', 'Frye', 'schmittcaroline@example.com', 'hold', 'painting', '(896)812-0183', 1021, 'fund');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://davis.com/', 'Nathan', 'Hoffman', 'lanejason@example.net', 'building', 'draw', '252.354.5991x022', 1021, 'fund');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://davis.com/', 'David', 'Santiago', 'gwalker@example.com', 'sound', 'surface', '876-379-7643x815', 1021, 'fund');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('method', 'http://www.jones.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('method', 'https://hall.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('method', 'https://www.hall.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('method', 'http://stephens.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('say', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('say', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('say', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('say', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('than', 'https://www.wilson.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('than', 'http://beasley-gutierrez.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('than', 'https://davis.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('than', 'http://davis.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_name ORDER BY COUNT(T2.link_to_event) DESC, T1.event_name NULLS LAST LIMIT 1;

/*
Gold Result:
('Lisa Allen',)
*/

-- Prediction Query
SELECT event.event_name FROM event INNER JOIN attendance ON event.event_id = attendance.link_to_event GROUP BY event.event_name ORDER BY COUNT(attendance.link_to_member) DESC, event.event_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Douglas Carlson',)
*/