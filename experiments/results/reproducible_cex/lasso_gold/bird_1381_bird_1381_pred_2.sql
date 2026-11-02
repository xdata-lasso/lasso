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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://www.osborn.info/', 'Alyssa Cochran', 'sing', 'he', 'My compare also argue own after long.', '55215 Smith Fords
Lake Carlos, KS 14661', 'kid');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://www.martinez-dunlap.com/', 'Robert Ruiz', 'save', 'yourself', 'Truth cut candidate response try such.', '7626 Macias Keys
Garciafort, WY 76267', 'north');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://foster.com/', 'Kevin Hall', 'her', 'out', 'Arrive challenge relate center book money.', '71040 Green Cove
West Georgefurt, GA 96443', 'right');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://www.hill.com/', 'David Allen', 'white', 'organization', 'Whether health walk how big few.', '9970 Dunlap Expressway
Mooreville, MA 27442', 'trial');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://www.phillips.com/', 'Raven Mclaughlin', 'perhaps', 'change', 'Wish run join police.', 'Unit 6884 Box 4431
DPO AE 51999', 'would');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://taylor-gonzalez.net/', 'Theresa Johnston', 'ahead', 'order', 'Power company why really up skin development.', '05061 Colon Road Suite 310
East Danielle, CO 62572', 'may');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://www.casey-howard.net/', 'Mrs. Taylor Frey', 'score', 'cup', 'Sport her safe family concern ability reduce of.', '7741 Lopez Light Suite 270
Scottview, IN 35701', 'page');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://shaw.com/', 'David Stewart', 'school', 'think', 'Allow own TV whose determine not view.', '115 Arellano Radial
New Bruce, MS 68996', 'upon');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://www.cannon.org/', 'Sean Silva', 'above', 'south', 'Its investment investment local above move room wear.', '167 Martinez Glen
Milesborough, UT 90382', 'shake');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://taylor.com/', 'Andrea Preston', 'live', 'cold', 'Series most adult above safe difficult.', '1849 Robert Cove Apt. 411
Gonzalezborough, WI 34972', 'other');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://price-johnson.org/', 'Sharon James', 'eye', 'might', 'Fine bill me fill assume animal.', '6420 Lozano Spurs
Riveratown, AL 88533', 'door');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://reeves.info/', 'Anthony Dickerson', 'determine', 'stock', 'Lay minute model its rather.', '721 Jennifer Courts
Dawnmouth, LA 35120', 'relationship');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://pittman.com/', 'Curtis Ortiz', 'sort', 'source', 'Garden top grow could.', '04556 Cody Trace
North Melissaburgh, MA 47362', 'TV');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://www.anderson-green.net/', 'Susan Ellis', 'staff', 'state', 'Affect difference world deep against mean.', 'PSC 9415, Box 5216
APO AA 60340', 'ground');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://davis.com/', 'Mike Maxwell', 'concern', 'behavior', 'Hand practice also theory.', '762 David Stream Apt. 216
Phammouth, HI 80628', 'natural');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://green-carter.com/', 'Mr. Christopher Walters', 'part', 'carry', 'Side perhaps order answer blue.', '027 Rodriguez Loop Suite 014
Alexanderhaven, WI 97969', 'necessary');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('eat', 'Blake Orr', 'send', 'already');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('rise', 'Anna Stanley', 'energy', 'meet');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1057, 'morning', 'North Stacy', 'list', 'Idaho', 'Hawaii');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1065, 'half', 'Hernandezside', 'wait', 'South Carolina', 'Arkansas');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('development', 'Ryan', 'Hughes', 'jrodriguez@example.org', 'watch', 'fast', '524.975.4691', 1057, 'eat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('system', 'Wendy', 'Sanders', 'buckleyanna@example.org', 'hotel', 'threat', '667.885.0821', 1057, 'eat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('data', 'Courtney', 'Nguyen', 'mikayla56@example.com', 'again', 'million', '(289)902-3303', 1057, 'eat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('card', 'Mary', 'Hill', 'kpena@example.net', 'green', 'toward', '2535457861', 1057, 'eat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('and', 'Jonathan', 'Ellis', 'rjohnson@example.com', 'television', 'safe', '(379)672-7985x524', 1057, 'eat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('land', 'Renee', 'Marks', 'christinebecker@example.com', 'student', 'reveal', '6608293333', 1057, 'eat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('bar', 'Robin', 'Buchanan', 'fosternatasha@example.net', 'floor', 'billion', '800.772.2903x49446', 1057, 'eat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('result', 'Carl', 'Dean', 'brandonalvarez@example.com', 'foreign', 'trouble', '743.674.8969x108', 1057, 'eat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://douglas-farley.com/', 'Ryan', 'Hughes', 'ebooth@example.com', 'public', 'loss', '758.799.7571x130', 1065, 'rise');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://www.osborn.info/', 'development');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://www.martinez-dunlap.com/', 'development');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://foster.com/', 'development');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://www.hill.com/', 'development');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://www.phillips.com/', 'development');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://taylor-gonzalez.net/', 'development');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://www.casey-howard.net/', 'development');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://shaw.com/', 'development');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://www.cannon.org/', 'https://douglas-farley.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://taylor.com/', 'https://douglas-farley.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://price-johnson.org/', 'https://douglas-farley.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://reeves.info/', 'https://douglas-farley.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://pittman.com/', 'https://douglas-farley.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://www.anderson-green.net/', 'https://douglas-farley.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://davis.com/', 'https://douglas-farley.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://green-carter.com/', 'https://douglas-farley.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member GROUP BY T2.link_to_member HAVING COUNT(T2.link_to_event) > 7;

/*
Gold Result:
('Ryan', 'Hughes')
('Ryan', 'Hughes')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name HAVING COUNT(T2.link_to_event) > 7;

/*
Prediction Result:
('Ryan', 'Hughes')
*/