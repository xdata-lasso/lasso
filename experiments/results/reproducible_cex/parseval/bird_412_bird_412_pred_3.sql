-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cards --
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, 'Matthew D. Wilson', '5k5swwqcgs', '9n8', 'black', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 179.378884, 'ilbnp', 1236688122, 986.066566, 'dposiie5unw', 'klfa9000t', 'c4ecigce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, -868774469, -1068298341, -314162272, 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2', 'normal', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'car_12767a', 'mfg62', '0v');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, 'Matthew D. Wilson', '6b', 'ou5z', 'black', '36c', 'bfkfoacd', '7z2zezj', '7wgx', '5', 377.388457, 'cmr0oz', -870767087, 104.37745, '5i3lq5lnpim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 618058035, 1553368934, -1252009958, 1908593332, 697257217, -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, -929383517, -2090240067, -699574669, 'rpd', 'normal', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'car_5e649e', 'yd1jmgjach8', 'qta8y3a17v4y');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'Matthew D. Wilson', 'tgelc', 'qb9i9f', 'black', 'ccukjq1q', 'ik1yhb', '8hlst1p', 'qomiztvb6m', 'iz78aqql', 324.663207, 'ftb8r9114', 1639204149, 19.495363, '6b', 'jeuuwsj8kj', '85', 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', -622923312, 1789767331, 1633584225, 1671062261, -1924635316, 313797011, 1946419004, -1215810104, -982188592, 1981548099, -913430713, -1652411404, -553121210, 1720208360, -1243923337, 'fwxqrl', 'normal', 'w', '014', '5dqts', 'g97a', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x', 'C', '1', 'l');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'upgly78oit', 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3', '1spxpw30', 'g', 'kxginl', '6id', 192.956867, '1l2o3ak16', 1562909425, 224.501855, 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'llbwvdpu5v0e', 'u', -699425950, -432771718, 516500236, 171585273, 1870044139, -1147311649, 1599672055, 745344960, -563021857, -2062902911, -1809620481, -1963064871, 8608094, -1863057592, -538774731, 'hcf46cfperxa', '1sjv8nv3d', 'r', 'kuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', '2qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'A', 'mxwdb7o', 'p5qo1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'Matthew D. Wilson', '90nhs', '9gob', 'black', '6', 'rn5u', 'phy', 'n', 'a', 375.525723, 'hvyx8scr0fs3', 1378228777, 203.913632, 'b5m2rlxcrw', 'x0', '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'olt0', 80244587, -379984089, -22540009, 505356655, 162901577, -159167628, -43429869, -1887578409, 498429250, -1869902412, 508276629, 796830191, -115832402, 2074088791, 1571723723, 'il21xs', 'normal', 'd', '6q5ziqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', '2o', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe', 'in', 'bciv', 'ojsmeqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', '0a0cql1c8c', 'wvadbp0760', 'gk2hjz', 'O', 'pg1lcg', 'a4gkjog8d');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, 'Matthew D. Wilson', 've0jf4i5t99k', 'nbhvi6', 'black', 'p3tfn', 'dtw89qy6sru4', 'uf', 'of8', 'f6bp', 557.843587, 'gjrad', -1746125330, 151.41893, 'zr6k53p8e', 'olf0yf1u', 'r8kzi0g50j5', '7fznqcuex', '1faxc1je', '48u5lvdb', 1337608681, 709713623, -1664812348, -1156619022, -1963206903, 1757094915, -1752003636, 500709040, 1346552102, -1110321935, 972288112, 1349808277, -194344351, 2087215165, 90760058, '534j5xbk11y', 'normal', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', '5i', 'dtdjm8r', 'y9lhw6lv7j45', 'k1qzqt5u', '42p20g', 'tfhk1l', 'for_1960ea', 'bjksuye6', 'hvzboodlz60');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483648, 'q8qdjpe1', 'French', -1180042408, 'for_969870', '78507cvt', 'ptt', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, 'ma', 'French', -499203870, 'for_969870', 'qdpuap96', 'ntdqr', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, 'm5', 'French', -648564084, 'for_969870', 'c7d', 'n2np490xdms', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, '4c6', 'French', 749598659, 'for_969870', 'wnkd4kc3ii', 'axz', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'w16f5tqhjd', 'French', -1332047564, 'for_969870', 'm', 'kr2tzdlb6i42', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, 'tew5c29d', 'French', -617631089, 'for_969870', 'havc2c4', 'pw8672f', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483642, 'sijufc2vfgh', 'French', 1608670538, 'for_969870', 'bugxis', 'q2i', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483641, 'dq44u', 'French', 663227128, 'for_969870', 'kz', 'w', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483640, '3q5br3', 'French', -1007920797, 'for_969870', 'bvbj26kpxc56', 'pvp0h2fln', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483639, 'lcorq', 'for_cf2378', -854263126, 'for_969870', 'uodbvf3', 'a6l431g', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483638, 'feg6q6gifj', 'French', 1792401890, NULL, 'xt41zj', 'f1qj3se4dp', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, '5k5swwqcgs', NULL, 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (5, 'luhvdltti', 'French', -1364429300, 'nprmdposii', '5u', 'w6kl', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (6, 'a9', 'French', 1620389964, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (7, 'qyp5s5bbp0', 'French', 743312762, 'eutliqa11r', 'ytoo3o9', 'l7', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (8, 'klex14ji', 'French', -453362185, 'au2dwyrq13', 'yu78', '9', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (9, 'rljsl0b4y', 'French', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (10, 'j4hwbdvlph', 'French', -261132974, 'dqwn', 'cx5hn', 'p', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (11, 'jtu0d', 'French', 401805964, 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'car_12767a');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (12, 'kn6vc', 'French', 1784916884, 'ah0f8jsww', 'q7x', '7', 'car_12767a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM foreign_data WHERE uuid IN (SELECT uuid FROM cards WHERE types = 'Creature' AND layout = 'normal' AND borderColor = 'black' AND artist = 'Matthew D. Wilson') AND language = 'French';

/*
Gold Result:
*/

-- Prediction Query
SELECT foreign_data.name FROM cards INNER JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE cards.artist = 'Matthew D. Wilson' AND cards.borderColor = 'black' AND cards.layout = 'normal' AND foreign_data.language = 'French';

/*
Prediction Result:
('for_969870',)
('for_969870',)
('for_969870',)
('for_969870',)
(None,)
('for_969870',)
('for_969870',)
('nprmdposii',)
('00t5c4ecigc',)
('eutliqa11r',)
('au2dwyrq13',)
('i2rkf',)
('dqwn',)
('gq8',)
('ah0f8jsww',)
*/