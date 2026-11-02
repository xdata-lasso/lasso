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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('room', 'Alvin Wilson', 'quite', 'will', 'Effort be seem far million discover.', '6212 Mendoza Cliff Suite 323
Ryanfort, GA 79630', 'middle');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('drug', 'Cory Willis', 'society', 'street', 'Let perform international.', '387 Harris Divide Suite 169
New Mark, OK 64851', 'prove');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('man', 'Amanda Johnson', 'Mr', 'past', 'It happen marriage event agent kid enter.', '147 Graves Station
Peterburgh, MT 33155', 'risk');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('price', 'Christopher Mcclure', 'house', 'rate', 'Grow bar successful mention.', '6291 Hale Cape Apt. 248
Elizabethland, UT 95729', 'home');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('different', 'Gina Spencer', 'moment', 'although', 'Skill unit better author.', '6815 Karina Parkways
Robertburgh, KS 27681', 'same');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('edge', 'Alex Cameron', 'natural', 'despite', 'National free push.', '17656 Randy Branch Suite 125
Washingtonland, CO 72384', 'article');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('medical', 'Alisha Byrd', 'majority', 'discuss', 'Few spring raise ever relationship.', '74220 Gregory Crossing Suite 210
Ericstad, HI 28900', 'rather');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('simple', 'Richard Rodriguez', 'country', 'want', 'Your sell science treatment.', '0816 Wallace Rapid
North Kelseyborough, IA 49606', 'image');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('special', 'Elizabeth Allen', 'fund', 'degree', 'Show example get.', 'PSC 3106, Box 0053
APO AP 88181', 'with');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('teacher', 'Mary Pugh', 'seem', 'live', 'Watch state serious activity pressure writer.', '220 Hunt Via
Marcusborough, RI 27648', 'language');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('glass', 'Yolanda Keith', 'hour', 'travel', 'Tend dinner rich decide.', 'USCGC Mcmillan
FPO AE 30963', 'simply');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('surface', 'Ana Thomas', 'never', 'easy', 'Middle skill serious reveal left.', '2065 Paul Mount Apt. 149
Bradleyborough, MT 40023', 'employee');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('sister', 'Rebecca Lee', 'run', 'individual', 'Fine could show recently.', '89241 Jarvis Square Suite 252
Tiffanyfort, CA 44423', 'eight');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('how', 'James Greene', 'meeting', 'discover', 'Just table air catch them.', '8389 Jesse Ridges Apt. 436
New Christopher, DC 49590', 'mean');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('describe', 'Dana Williams', 'senior', 'follow', 'Wall act special strong fund.', '63039 Stevenson Isle
West Lonnie, WY 05692', 'already');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('instead', 'Chelsea Nichols', 'miss', 'large', 'International sell several real federal only.', '403 Cooper Ford Apt. 339
Boydburgh, NV 83047', 'tax');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('create', 'Erin Brown', 'matter', 'visit', 'Size two child well form picture owner.', '30232 Glenn Plaza Apt. 381
Hardyport, GA 95092', 'high');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('that', 'Shelley York', 'executive', 'huge', 'Off hospital high we as hit little forget.', '93449 Faulkner Flats Suite 715
Grayfort, NV 55904', 'program');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('according', 'Stacey Clark', 'party', 'owner', 'Police fight commercial push concern step owner.', '70661 Larson Drives Apt. 467
Shawnfurt, OH 79933', 'seat');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('him', 'John Alvarado', 'institution', 'close', 'Cost attorney white.', '73230 Michelle Stream Suite 766
Wallerstad, MS 64667', 'require');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('action', 'Jordan Potter', 'pull', 'worry', 'Day fact modern lawyer happy.', '0169 James Mews
Kelseystad, NY 93447', 'ahead');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('outside', 'Alvin Wilson', 'power', 'way', 'Writer prevent keep cause.', '18954 Mayo Flats Apt. 023
Pierceview, MH 73946', 'hot');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('save', 'Brittany Jacobs', 'yet', 'responsibility');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('theory', 'Brittany White', 'six', 'challenge');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1148, 'choice', 'Johnshire', 'recognize', 'Hawaii', 'Alabama');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1169, 'smile', 'Theodoremouth', 'life', 'Tennessee', 'Vermont');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.dawson.com/', 'Catherine', 'Holder', 'yvaldez@example.net', 'fear', 'common', '(820)515-7201x85962', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://gallegos.com/', 'Jennifer', 'Johnson', 'ostokes@example.com', 'wind', 'participant', '3139674926', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://jenkins.com/', 'Molly', 'Hickman', 'carterdaniel@example.com', 'day', 'certain', '+1-264-975-0111x1783', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://adams.biz/', 'Nancy', 'Nguyen', 'juliewilson@example.com', 'school', 'letter', '319-426-7649x215', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.velasquez.com/', 'Kristen', 'Reyes', 'melissafinley@example.net', 'total', 'safe', '(306)488-8718x9813', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://butler.com/', 'Anthony', 'Ramirez', 'collinsbrittany@example.org', 'official', 'film', '+1-320-687-5102x932', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.taylor.com/', 'Tyler', 'Ball', 'uwhitney@example.com', 'indeed', 'watch', '001-601-918-4582x60340', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.harris.com/', 'Christopher', 'Wade', 'aprilguzman@example.org', 'bill', 'check', '(597)358-5988', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://alexander-durham.com/', 'Marisa', 'Lynn', 'fosteramanda@example.com', 'catch', 'determine', '+1-603-403-2432x98395', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.miller-martinez.com/', 'Wendy', 'Lambert', 'duane43@example.com', 'game', 'summer', '001-896-418-4462x6714', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.young.com/', 'Vanessa', 'Livingston', 'shernandez@example.org', 'soldier', 'smile', '+1-431-843-5989', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://ortega.com/', 'Steven', 'Schultz', 'georgekyle@example.net', 'strong', 'deal', '(356)360-9314', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.morrison-hatfield.com/', 'Peggy', 'Vasquez', 'hillmelanie@example.net', 'partner', 'act', '+1-886-515-1554x23401', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://munoz-rogers.com/', 'Stephanie', 'Pope', 'nwelch@example.com', 'tree', 'she', '(611)328-4971x8594', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.ortega-gray.com/', 'Timothy', 'Cook', 'janet60@example.com', 'support', 'parent', '8259625889', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://smith.biz/', 'Amber', 'Walker', 'mariaclark@example.net', 'arm', 'blue', '001-624-208-2226', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.martinez.com/', 'John', 'Johnston', 'isabellawilliams@example.org', 'to', 'resource', '001-853-596-7275x7844', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://parks.com/', 'George', 'Bradshaw', 'tluna@example.net', 'security', 'stock', '314-665-1113x1290', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://schultz.com/', 'Sheryl', 'Brown', 'vickiekelley@example.com', 'fly', 'town', '+1-370-868-2778', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.washington.com/', 'Holly', 'Cooper', 'wgregory@example.com', 'lot', 'choose', '2939068538', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://vincent.com/', 'Daniel', 'Kent', 'ujones@example.com', 'real', 'however', '(283)821-5285', 1148, 'save');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://moore.com/', 'Harold', 'Hutchinson', 'lowerysandra@example.com', 'about', 'huge', '+1-876-765-5868x5127', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.sanders.info/', 'Kelsey', 'Fleming', 'richardbrown@example.com', 'little', 'direction', '(689)328-6646', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://perez.com/', 'Jonathan', 'Oliver', 'vlewis@example.com', 'yes', 'happen', '311-909-6179', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.lewis.com/', 'Thomas', 'Schneider', 'ramirezbenjamin@example.org', 'there', 'determine', '790.946.3378x61371', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://edwards-may.biz/', 'Nancy', 'Figueroa', 'nthomas@example.com', 'tough', 'cut', '(260)253-8444x46306', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.lucas-lee.com/', 'Debra', 'Sanchez', 'huertakim@example.org', 'car', 'respond', '8255895529', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.morrison-bradford.com/', 'Donald', 'Nicholson', 'kristine73@example.org', 'protect', 'part', '+1-863-496-0962', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://weaver.com/', 'David', 'Smith', 'mirandacisneros@example.net', 'listen', 'address', '(458)726-3128x1964', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://arnold.com/', 'Ashley', 'Farrell', 'onelson@example.org', 'purpose', 'hospital', '311.806.0920', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://davila.com/', 'Benjamin', 'Roberts', 'thomasjoshua@example.org', 'particular', 'teach', '5278523343', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.edwards.com/', 'Michele', 'Moore', 'morgan76@example.net', 'bill', 'himself', '001-440-641-2091x17911', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://porter-edwards.biz/', 'Richard', 'Ross', 'elizabethgreen@example.org', 'although', 'admit', '321-917-5361x706', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.leonard.net/', 'Melody', 'Jones', 'jacobsonroy@example.com', 'discover', 'five', '+1-213-366-5722x4029', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.matthews.info/', 'Sally', 'Price', 'jamesmcmahon@example.com', 'skill', 'watch', '257-499-8028x41390', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://hernandez.com/', 'Michael', 'Ford', 'ynichols@example.org', 'cup', 'food', '451.630.5231', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.aguirre.com/', 'Megan', 'Davis', 'sgomez@example.net', 'kitchen', 'morning', '573-615-8477x686', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://floyd-morgan.com/', 'Stephanie', 'Owens', 'jmorrow@example.net', 'same', 'tell', '(534)961-9942', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.schroeder.org/', 'Nathaniel', 'Day', 'christiancontreras@example.net', 'office', 'trip', '(776)394-5919x66395', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.burton.com/', 'Evelyn', 'Mccullough', 'mariodowns@example.net', 'staff', 'capital', '220.384.9649x856', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.davis-edwards.com/', 'William', 'Marshall', 'alexis72@example.com', 'compare', 'scene', '(756)425-3135', 1169, 'theory');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.ray-gomez.com/', 'Jose', 'Miller', 'daniel64@example.net', 'plant', 'money', '001-851-605-0537x95381', 1169, 'theory');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://www.dawson.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://gallegos.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://jenkins.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://adams.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://www.velasquez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://butler.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://www.taylor.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://www.harris.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://alexander-durham.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://www.miller-martinez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://www.young.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://ortega.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://www.morrison-hatfield.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://munoz-rogers.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://www.ortega-gray.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://smith.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://www.martinez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://parks.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'http://schultz.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://www.washington.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('room', 'https://vincent.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://moore.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://www.sanders.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'https://perez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'https://www.lewis.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://edwards-may.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://www.lucas-lee.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://www.morrison-bradford.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://weaver.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://arnold.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://davila.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'https://www.edwards.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'https://porter-edwards.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'https://www.leonard.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://www.matthews.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://hernandez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://www.aguirre.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://floyd-morgan.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'https://www.schroeder.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://www.burton.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'https://www.davis-edwards.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('outside', 'http://www.ray-gomez.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Alvin Wilson',)
('Alvin Wilson',)
*/

-- Prediction Query
SELECT DISTINCT event.event_name FROM event INNER JOIN attendance ON event.event_id = attendance.link_to_event WHERE event.type <> 'fundraiser' GROUP BY event.event_id HAVING COUNT(attendance.link_to_member) > 20;

/*
Prediction Result:
('Alvin Wilson',)
*/