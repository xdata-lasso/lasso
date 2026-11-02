-- Schema DDL
CREATE TABLE "artists" ("id" INTEGER PRIMARY KEY, "name" TEXT(120));

CREATE TABLE "albums" ("id" INTEGER PRIMARY KEY, "artist_id" INTEGER, "title" TEXT(160), FOREIGN KEY ("artist_id") REFERENCES "artists" ("id"));

CREATE TABLE "employees" ("id" INTEGER PRIMARY KEY, "reports_to" INTEGER, "last_name" TEXT(20), "first_name" TEXT(20), "title" TEXT(30), "birth_date" TIMESTAMP, "hire_date" TIMESTAMP, "address" TEXT(70), "city" TEXT(40), "state" TEXT(40), "country" TEXT(40), "postal_code" TEXT(10), "phone" TEXT(24), "fax" TEXT(24), "email" TEXT(60), FOREIGN KEY ("reports_to") REFERENCES "employees" ("id"));

CREATE TABLE "customers" ("id" INTEGER PRIMARY KEY, "support_rep_id" INTEGER, "first_name" TEXT(40), "last_name" TEXT(20), "company" TEXT(80), "address" TEXT(70), "city" TEXT(40), "state" TEXT(40), "country" TEXT(40), "postal_code" TEXT(10), "phone" TEXT(24), "fax" TEXT(24), "email" TEXT(60), FOREIGN KEY ("support_rep_id") REFERENCES "employees" ("id"));

CREATE TABLE "genres" ("id" INTEGER PRIMARY KEY, "name" TEXT(120));

CREATE TABLE "invoices" ("id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "invoice_date" TIMESTAMP, "billing_address" TEXT(70), "billing_city" TEXT(40), "billing_state" TEXT(40), "billing_country" TEXT(40), "billing_postal_code" TEXT(10), "total" REAL(10, 2), FOREIGN KEY ("customer_id") REFERENCES "customers" ("id"));

CREATE TABLE "media_types" ("id" INTEGER PRIMARY KEY, "name" TEXT(120));

CREATE TABLE "tracks" ("id" INTEGER PRIMARY KEY, "media_type_id" INTEGER, "genre_id" INTEGER, "album_id" INTEGER, "name" TEXT(200), "composer" TEXT(220), "milliseconds" INTEGER, "bytes" INTEGER, "unit_price" REAL(10, 2), FOREIGN KEY ("media_type_id") REFERENCES "media_types" ("id"), FOREIGN KEY ("genre_id") REFERENCES "genres" ("id"), FOREIGN KEY ("album_id") REFERENCES "albums" ("id"));

CREATE TABLE "invoice_lines" ("id" INTEGER PRIMARY KEY, "track_id" INTEGER, "invoice_id" INTEGER, "unit_price" REAL(10, 2), "quantity" INTEGER, FOREIGN KEY ("track_id") REFERENCES "tracks" ("id"), FOREIGN KEY ("invoice_id") REFERENCES "invoices" ("id"));

CREATE TABLE "playlists" ("id" INTEGER PRIMARY KEY, "name" TEXT(120));

CREATE TABLE "playlist_tracks" ("playlist_id" INTEGER, "track_id" INTEGER, PRIMARY KEY ("playlist_id", "track_id"), FOREIGN KEY ("track_id") REFERENCES "tracks" ("id"), FOREIGN KEY ("playlist_id") REFERENCES "playlists" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1882, 1883, 'Jordan', 'Johnathan', 'Chemical engineer', '1987-01-14', '1988-02-15', '35157 Alexandria Brooks Apt. 805
East Aaronhaven, AL 01111', 'Paultown', 'val_1884', 'South Georgia and the South Sandwich Islands', '74960', '001-551-723-9728', 'bill', 'carolberry@example.com');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1932, 1933, 'Smith', 'Lindsay', 'Waste management officer', '1997-11-01', '1998-01-02', '519 Brian Dam Apt. 121
North Ryanbury, IL 07054', 'South Lukehaven', 'val_1934', 'Congo', '62897', '479.227.4907', 'base', 'terribaker@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1883, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1933, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1893, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1894, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1895, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1896, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1897, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1898, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1899, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1943, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1944, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1945, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1946, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1947, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1948, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1949, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1885, 1882, 'Jasmine', 'Shepard', 'Moore, Austin and Rogers', '158 Sherman Row
West Luke, NV 26458', 'Danielville', 'val_1900', 'Saint Vincent and the Grenadines', '66511', '(854)425-7306', 'director', 'rachel86@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1886, 1893, 'Nichole', 'Aguirre', 'Mcfarland-Kelley', '6617 Travis Islands Suite 964
Gayport, WI 90161', 'Carsonborough', 'val_1901', 'Cambodia', '25269', '681-432-3570x7139', 'seem', 'jason27@example.org');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1887, 1894, 'Gregory', 'Collins', 'Bowers-Raymond', '14998 Danielle Streets
New Anthonyport, MS 25173', 'New Meghanborough', 'val_1902', 'Kenya', '28082', '(285)401-1688', 'cut', 'xevans@example.net');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1888, 1895, 'Eduardo', 'Bailey', 'Spencer, Morgan and Diaz', '688 William Springs
East Coreyburgh, MH 29542', 'New Wendy', 'val_1903', 'Nepal', '95516', '001-355-502-1306x0906', 'outside', 'nwilliams@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1889, 1896, 'Lori', 'White', 'Horne Group', '373 Brandon Light
Lake Darren, LA 01122', 'Mendozaville', 'val_1904', 'Seychelles', '42171', '001-909-681-0796x49673', 'day', 'donnagiles@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1890, 1897, 'Anthony', 'Stone', 'Bauer Inc', 'PSC 5263, Box 5602
APO AE 78980', 'North Marissa', 'val_1905', 'Armenia', '06236', '(677)427-8532x426', 'yourself', 'sherryjohnson@example.org');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1891, 1898, 'Benjamin', 'Mccullough', 'Brown-Haas', '9434 Vaughn Mall Suite 643
Kingtown, SC 91271', 'North Kathryn', 'val_1906', 'Panama', '75054', '(706)542-0768x362', 'TV', 'lbradley@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1892, 1899, 'Amanda', 'Jimenez', 'Cochran-Browning', '31112 Jones Plain Suite 246
Amandaport, PR 75226', 'East Ryanstad', 'val_1907', 'Vietnam', '02363', '(566)577-7675x5562', 'shoulder', 'danielleandrews@example.org');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1935, 1932, 'Barbara', 'Foster', 'Schmidt Ltd', '5757 Hines Island Apt. 392
Lake Michaelmouth, FM 61009', 'West Melanie', 'val_1950', 'Madagascar', '01931', '+1-361-657-2768x2975', 'detail', 'william26@example.org');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1936, 1943, 'Jaime', 'Huff', 'King, Webster and Brown', '7722 Barnes Burg Apt. 562
Diazchester, WY 87240', 'South Johntown', 'val_1951', 'Finland', '39583', '243.797.4292x501', 'drug', 'amandaherman@example.net');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1937, 1944, 'David', 'Phillips', 'Snyder Ltd', 'PSC 2923, Box 1067
APO AE 36007', 'Michaelfort', 'val_1952', 'Egypt', '34709', '+1-775-825-6806', 'pass', 'joseph58@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1938, 1945, 'Kathleen', 'Gutierrez', 'Harvey Group', '6248 Perez Oval
Reynoldsburgh, NM 87767', 'Port Joseph', 'val_1953', 'Somalia', '27271', '(259)404-5990', 'million', 'marywebster@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1939, 1946, 'Jacob', 'Davidson', 'Craig Ltd', '57942 April Park
South Tracy, ME 83274', 'Toddmouth', 'val_1954', 'Jamaica', '19383', '311.822.1823x1555', 'account', 'james46@example.org');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1940, 1947, 'Melinda', 'Robinson', 'Smith-Garner', '969 Carol Pines Suite 552
Annettefort, CA 02822', 'Port Lisa', 'val_1955', 'Reunion', '39311', '417-368-0866x28137', 'happy', 'shannon79@example.net');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1941, 1948, 'Katelyn', 'King', 'Flores LLC', '35357 Peters Ports Suite 325
Lake Brittany, IA 33150', 'New Cassie', 'val_1956', 'Svalbard & Jan Mayen Islands', '03814', '001-443-430-8003x70033', 'science', 'hharris@example.org');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1942, 1949, 'Jeremy', 'Cooper', 'Becker, Gregory and Jones', '58162 Miller Overpass Suite 941
Priceborough, WY 36704', 'Jessicaborough', 'val_1957', 'Timor-Leste', '04278', '555.266.0847x06810', 'be', 'vballard@example.org');
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1908, 1885, '1989-03-16', '3275 Erica Turnpike Apt. 100
West Melissamouth, MH 47253', 'Lake Emilyfurt', 'val_1916', NULL, '23714', 1924.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1909, 1886, '1989-03-17', '41595 Alvarez Squares
West Kevin, AS 74148', 'Michaelhaven', 'val_1917', NULL, '49441', 1943.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1910, 1887, '1989-03-18', '61896 Anna Road
Gravesview, UT 33189', 'Russellmouth', 'val_1918', NULL, '09015', 1962.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1911, 1888, '1989-03-19', 'Unit 2710 Box 2676
DPO AA 22843', 'West Jennifer', 'val_1919', NULL, '20686', 1981.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1912, 1889, '1989-03-20', '9927 Tara Skyway Suite 515
East Dennisport, TX 52093', 'South Juan', 'val_1920', NULL, '75462', 2000.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1913, 1890, '1989-03-21', 'PSC 1354, Box 1597
APO AE 82009', 'South Samanthaland', 'val_1921', NULL, '31557', 2019.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1914, 1891, '1989-03-22', '54384 Tracy Expressway Apt. 344
Ferrellmouth, AZ 36262', 'Michelleville', 'val_1922', NULL, '11954', 2038.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1915, 1892, '1989-03-23', '158 David Road Apt. 904
Gonzalezfort, MS 51408', 'Port Davidville', 'val_1923', NULL, '10385', 2057.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1958, 1935, '1970-02-03', '394 Ford Rue Apt. 943
West Alexanderburgh, VI 44270', 'West Jill', 'val_1966', 'Guam', '66869', 1974.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1959, 1936, '1970-02-04', '576 Samantha Neck Suite 319
North Melissaton, PR 01970', 'Richardshire', 'val_1967', 'Guam', '82429', 1993.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1960, 1937, '1970-02-05', 'USS Turner
FPO AA 96019', 'Watsonstad', 'val_1968', 'Guam', '19513', 2012.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1961, 1938, '1970-02-06', '05336 Jones Mall
West Kayleeville, ME 19092', 'Dylanfort', 'val_1969', 'Guam', '78985', 2031.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1962, 1939, '1970-02-07', '07201 Jenny Motorway
Josephshire, NJ 08795', 'Wardchester', 'val_1970', 'Guam', '45281', 2050.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1963, 1940, '1970-02-08', '16600 Reynolds Mountain
Thompsontown, OK 06272', 'New Jonberg', 'val_1971', 'Guam', '71307', 2069.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1964, 1941, '1970-02-09', '473 Johnson Groves Apt. 370
Port Annachester, OH 92637', 'Sandymouth', 'val_1972', 'Guam', '83429', 2088.5);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1965, 1942, '1970-02-10', '045 Carly Motorway
Stephensstad, TN 49164', 'Molinaburgh', 'val_1973', 'Guam', '98122', 2107.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT billing_country, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT billing_country, COUNT(*) AS n FROM invoices GROUP BY billing_country) ORDER BY n DESC) LIMIT 5);

/*
Gold Result:
(None, 8)
('Guam', 8)
*/

-- Prediction Query
SELECT billing_country, COUNT(*) FROM invoices GROUP BY billing_country ORDER BY COUNT(*) DESC, billing_country NULLS LAST LIMIT 5;

/*
Prediction Result:
('Guam', 8)
(None, 8)
*/