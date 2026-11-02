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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'Fellwar Stone', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 't1__478dc3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', 'uuid_1', '0v', 'q8qdjpe1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, '5k58', 's27p2', '94gth', '2mnajjla3o', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', '8y', 335.639672, 'v42q7sx58b4p', 319284352, 771.198983, 'auvmkrpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', -397848196, -366775518, 575038073, -1161141730, -613916489, 2061558815, 895277769, 364043263, -1177989415, -1352968577, -519515742, 1953495465, -1960313034, 681061317, 1935791961, 'izgk1yoeyo6', 'l0hdt6fuqyx', 'uzkb521gwnl', 's', 'elboeowii', 'z5nxih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'Fellwar Stone', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 't1__478dc3', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'uuid_2', 'dmsqtg', 'lc');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'qb9i9f', 'ccukjq1q', 'ik1yhb', '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8', '9114q', 'r', 70.018028, 'bjeuuwsj8', -1451520332, 114.099596, 'wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', -1515201134, -2121944911, 1195320303, 1463445550, -1096060187, 2014610660, 1492264835, -642512512, -1040088060, -2081798075, -1439417265, -300547632, -967107842, -1011152325, 1298113538, 'g97a', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', 'Fellwar Stone', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 't1__a1512a', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x', '1', 'l', 'upgly78oit', 'uuid_3', 'xeilpe019cy', 'od033dlhd');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'vnhed', '9lqv26u3', '1spxpw30', 'g', 'kxginl', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', 989.611258, '9kuboe8c', -1943810603, 862.579245, 'ekhllb', 'vdpu5v', 'eduy9v2', '129835x', 'epac', 'db2f0c', -537413388, 2011754567, 1755688363, 1177967285, -2001463367, -2003500453, 1280646590, -568125159, -329270684, -1517724233, -1265768652, 2081562124, -1879135081, -958249959, -1446721688, 'zc', 'ehia3', 'm', 'vb7vpc0xff', 'or1esk', 'f9q82', 'g01hu', 'j7f', '8kqhiu5gm8', 'xb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', 'Fellwar Stone', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'C', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', 'uuid_4', '38gfxswb2d0', 'mxwdb7o');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'r', 'fx03rz', 'z8', 'lqme2wb1', '3', 'un66e0', 'mol', '070zi', '0o50q833g', 855.493819, '65zm6dpew', 1290157948, 350.384888, '92p40u2', 'il21xs', 'd', '6q5ziqoauy0', '3lwh994f', 'qc1m9gr8xj', 1072042049, 1690134584, -551513589, -81327703, -1531362377, -1580370971, 1338378083, 945802166, 47431001, -698277997, 748510826, 990008540, -2083332040, -1732139002, 104130853, 'y3', 'k', 'i', 'txfb', 'l10qx6j6d4fc', '5m4s2ajdu', '6xuj90te', 'x3', '5u7709', 'qf9lx8qzabi', 'uumwu7', 'l', '0jw', 'Fellwar Stone', '6hh', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', 'sme', 'v3r3u', 'doxa0o', 'l1zmjrssbh', '2404qpp33', '3a1ngqu', '8184d', '_', 'ojdlhl', 'pdyxk0a', 'cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'uuid_5', 'mabmkr2t', 'dlb6i42');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, 'tew5c29d', 't1havc', 'c4zpw867', 'fve0jf4i', 't99kvnbh', 'i6tp3t', 'nd', 'w89qy', 'sru4eufio', 980.244198, '8of6bp9qgjra', 1947614123, 121.871487, '8zr6k53p8e5o', 'f0y', '1u', 'r8kzi0g50j5', '7fznqcuex', '1faxc1je', -115971578, 774567335, -30821492, 455841204, -200145376, 1696094807, 598317289, -471858269, 419954312, 1673358342, -508328860, 638054085, -1585881270, 1978258540, 293484659, 'upleoh3m3', '0pq97', '534', '5xb', '11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'Fellwar Stone', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8', 'G', '0235v8ik', '3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', '5i', 'uuid_6', 'dtdjm8r', 'y9lhw6lv7j45');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (2, 'k1qzqt5u', '42p20g', 'tfhk1l', 'bjksuye6', 'hvzboodlz60', 'sijufc2vfgh', 'xbu', 'xi', 'lq2is', 56.077673, '44u2f', -441907095, 351.333889, '3q5br37qobv', 'j', '26kpxc567p', 'vp0h2flntlco', 'qtl1u', 'dbvf', -534387926, 949206609, 1790641668, -286729739, 322498251, -1841006453, 33100532, 56216130, 1385394884, 1792401890, -585058868, -96878107, 1620531975, -1048787950, -190180302, '4d', 'pb4l6rurl72q', 'ippxb659q', 'tkf5j4ce', 'y485ys1g', '7p3hvg0', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', 'v0oh59ivnipn', 'Fellwar Stone', 'drokt16hq', '9', 'jae9ps4don', 'e0b6piqkuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', 'o6r9', '3', 'dayv5uh', 'rvcc', 't1__478dc3', 'wraqxeddnko4', 'dq70691b7', 's1i0k8thqz3', 's94x3', 'yxg3ufg', 'efrzw0qgiqh4', 'o', 'k79v0940', '_', '7swb3349kf', '5l6rnd3rhb');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 'nmbp96v512', 'bvxjnuw8', '4jm31nfs4ni', 'om2u85br29', '1kpjnnbss', '75w5nag', 'rj6o317kajtw', 'sqiuj9f94', 'ycwnr8dq', 675.859507, 'bz', 2115388252, 946.517946, 'uv', 'vcr', 'l03f515y8', 'm', 'qjut2f3', '6fr11lu', -720395989, -130970718, -612603238, -1705389050, -198326755, -435550780, 1926794745, 1922961793, -1175155753, 735250406, -461669512, -261162125, 832376590, 845884108, -1233317434, 'lc3', 'spw', 'gvoc9l5zm', 'sv641', '6b', 'ugt8ygq', 'fzr1', 'v7z6i', 'r1w', 'x1', 'l', 'bbk27zz', 'uuwyewbihg8', 'Fellwar Stone', '1ev3gqe', 'nehcnt2v', 'lraxg0gt', 'ot6vp1', 'lrhqsxyube', 'yhmlrnycz8d5', 'kabtcpo', '1ke8euy0kcx', '8e4', 'bkfphyyxnm', 'cmn8usy', 'c1vk27ki', 'uvof5ndg', 't1__478dc3', '80z', 'qe9rs1z82tw', '4o1sqir', 'hj1', 'xi', 'o9km29vphx5v', '7jo', 'y', 'A', '1skvh4q', 'y4gp');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483640, '0kr5bk0d0gkg', 'qavutce54k', 'dvf12j4ljl', 'hxdpnhebny', 'a', 'xtpyee2zt2', 'gy7qnk', 'j2dsjla91nq', '7dxug9rta6w', 7.047588, 'l7a', 2105679482, 254.408216, 'gahjcu84v', 'o5sddf', 'a2n0l', 'czduqt', 'ig197ge', 'rru', 393697580, -616668672, 1994640301, -1629766030, 616056466, -2047663165, 633090631, 499326529, -1252329401, -707359942, -443674009, 530763042, 2084726235, -789800145, 53549002, '5jlkkggq', 'kx1wfn', 'o', '1864', '9', '9n', 'w16bb6teck', 'aioh8mpzf5t', 'lsok6v', 'gc', '3b0v293muo', 'o5cwanc56', 'wf', 't1__f9e9a0', 'y2vtct', '95snh', 'c1jc1', 'j3dmll8k26', 'qohr35iptx', 'lhv1', 'ti78hf', 'w', 'wwkmxvvfta', 'q65qvero7mf', '86mok', 'pt50qbwhb', 'szz', 't1__478dc3', 'g8eizd0cun', 'g8', 'gvzm', 'iwbdo', '90a5nxzf', 'as9e', 'zdfe0r841i6v', '9a6h', 'uuid_9', 'qzy', 'etff9znz5');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483639, 'a', 'yzmae7whkuxo', '6stk1uxpevo', 'sy9i6bswqb', 'oyhady', '3jap', 'pzj', '2', 'zxpmaspu0abl', 889.126248, 'jufkhq6sd', -291432497, 95.201742, 'jcakwtumv', 'p19dvetwec1z', '80x72p', 'z', 'z2fp2srds4d5', '7xpoymk4yzv', -1796328619, -890885662, -488726144, -914026461, 1490677636, 1827577126, -1595729346, 1886602907, -1576253965, 290960158, -39689010, -1933824833, 708987508, 1251238196, 323880816, 'q4nksw3', '506p67904l', '0dafs830rj', '63fqszsmbw', 'k5paop6', '3z5p37ek', 'hfm81p', '91mps38', 'vev5utc4wz1', 'h52f5fx05rr8', 'vqg', 'r2exf0wr', 's', 'Fellwar Stone', 'de2k', 'n0', 'o22', 'u', '5ig', 'eidvgb68', 'bw', '1fs7hycn', 'b5afv61keoy', 'aj0p', 'k4nr', 'gnhxf6i', '6asm', 't1__478dc3', '572', '4', 't9h4gwpvhdb', 'n16i83ytqv3', '1', '0qjx29a', 'f', 'x1si', 'uuid_10', 'c', 'hyuvy');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483638, '3eac', '7vdwkko5vwsu', 'ks6r', 'y62kek7hibs', 'fh8imiuk', 'f9xs0', '3g', 'w', '8', 999.346388, 'dxhv0a9e8g', 1942024146, 776.701154, 'c05e27hv0u', 'ya12ba9pq9', 'c3reyykrfk2', 'upbwnk4fgnm', '2sp7', 'mu28jur734t', 1366167506, -1746910035, -324126492, 1640178689, 1554769398, 696350631, -669875813, -641365291, -6483207, 1283337636, -86038911, -1562210199, 844219847, -1186777387, -1359812732, 'mc1o', 'v1mq0f', '6ghsx10hz', 'mg804o5adjd1', 'n', 't', 'mrf34rnm3o89', '0', '6837bfhy', '50', 'z3vw9z57rl1', 'ba9mrw', 'yzbou0gyjit2', 'Fellwar Stone', 'fgscgmfqs8', 'u', 't7ni', 'b0', 'q5mm', 'u4crtn3bll89', '9azbbz1ve2s5', 'eznd4r', 'z6ck6b9', 'y48udes', 'd5q1wmigcg', 'h9o', 'c9m7k0', 't1__478dc3', '5', 'ymsyqh2mcnrs', 'wouu', 'd2g', 'yi8oy', '7fcj0979', 'bvh44ewrogw', 'hfhsaskba4', 'uuid_11', 's', 'gt1ge577of');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (4, 'wummpy7d5', '0yo4lx0w', 'a0f75koo', 'b8ej953w', 'weolubkg0s', '1lm0sso9pw', 'ya1', '2jc1bi3b', 'f7in', 244.213116, 's', 1153119144, 573.912915, 'kngyf07z754e', 'e3rjtqnqmi', 'g', 'sy5cdp', '7t', 'e', 1474995403, 1944002558, -331668768, 2113248318, -852880269, -8629358, 2132315761, -163597442, -869813713, 1210558470, -1461153713, -1746886042, -1658545566, -2107191746, -1353693182, '9b7ke6w', 'uz7n', '0oq5nqy', 'wjq', '22', '0epbaljmxzq', 'ntdhbn3jdbd', 'zpxts', 'nn7', '9nbivw4', 'q5', 'zahkeowmj9cu', 'i0zwc', 'v56l', 'qp2', '68xuxk6z', 'skwu8s2va', '4tntw8nh5d', '26', 'sktm', 'qm', 'kd1la', 'fcnlt', 'afl9', 'hunj3sxridw', 'emvm', 'p', 'A', 'ijz9xfb6', 'b', 'j17954wg', 'fr6w64', 'uoryhibfz5', 'lpwmn8q', 'eop', 'ff8', 'uuid_12', 'tredoattl20n', 'f9zz8hm9zgwo');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (6, '8e9rv', 'i32iv', '5yty8elwww', 'al4zvb0w', 'duewudv3', 'ox9kpgyf3iy', 'qy68c15ubc0', '8gf1tfq93b', '7ki7yizoy', 476.521808, '32xcwurwjmn', -1315160855, 658.078956, 'jg1m', '5lkdpythdtl', 'di24v5s', '6f', 'e', '3iaipndd', -200176602, -758294397, 1515706139, -719798485, 1708169974, 681834228, 18136058, -83453733, 308035637, -532864956, 1869006492, -398609190, -1304105831, -595810250, 1018761850, 'l4', 'ssv4os18gifd', 'kw8', 'nplc3nev8r3', '7k4px7', 'f43', '7t', 'i', 'p9', 'sn5rawc8kbo', 'w79mr4u', 'lav0', '6gfqf', 'r3ndj8gka', 'kn', '56s9', 'm7', 'x', '4idfe4mvfrrx', '6m', 'o25ezvwym', '7huz', 'qzkco', '32uro46ilhrc', 'n9no1mcyqwm', '2kp54', 'btm4bttk9r', 'A', 'ps7m', 'hlme', 'lg81ynq76', 'wul6z', 'p2a9b5dx', 'sn791', 'kf0obtr1w0i', 'oeg70', 'uuid_13', '4o5j0f', 'ocmk0qsjf8b');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (5, 'u7i32vdue', 'cssd31tf', 'yhgh43j', 'zr1', 'fujiw9zcvgp3', '4a46nc', 'i6mt983k4gv', 'yxsy5lx09m5', 'l', 672.027882, 'ku07', -1923270302, 553.163572, 'wl5pdioj17p', 'nu5cc3', '7cnltrtrdse', 'ob', 'au3vveg', '6kqybb', 198267933, 397605152, 1525530372, -23558380, 1155221270, -1058070800, -41477322, -1749174880, 1986854420, -150621954, -1677017017, -1257549895, -252335361, 1903928352, 1269093338, 'zv42', 'm8d0', 'aqwwb5cbz2il', '2jjm6', 'g9', 's', 'na4wmggor', 'l5w2q4912ps', 'si04buzky1m0', 'jnq0', 'wz1ax', 'dxc9114sh53', 'u', 'Fellwar Stone', 'tzcx7ym0', '5ab2uess3q7', 'y', 'wij', 'he27nz', 'md76s0', 'r0p5a7', 'pdy59e3mthh1', '613xc', '0sq6mboxq', 't4f8b9d3pwwp', 'srs', 'lh6x', 't1__036a4b', '1c7l8zys', 'i', 'xokmxq9jctv', '5', '43u5', '5y', 'u', 'yqq5hak5', 'uuid_14', '3', 'x050cx');

-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -1180042408, '78507cvt', 'ptt', 't1__478dc3', 1467355421, -1171104889, -29242208, 1691780814, 1944978593, 'bfkfoacd', 2115816682, 76987628, 'zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', '2025-02-22', -1405314653, 1816660482, 'npi');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 1424429365, 'p5qo1k4c6gw', 'kd4k', 'A', 825979697, -1565247126, -419727501, -1220824615, -888694642, 'gobb6nrn5', -1539870021, -1621175100, 'n', 'a', 'vhvyx8s', 'r', '2024-08-25', -1763520124, -1023831089, 'b5m2rlx');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1090706887, 'qch8wgesf', 'z8a7s6', 't1__036a4b', -503957696, -318471917, -660025543, 846703959, -2041120189, 'a1qwqq5', 764703147, 506279024, 'ayl6xv57yvh6', '6gf', 'nxgyc', 'rwd95e', '2024-05-08', 883092191, 70442686, 'ki');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Japanese', 't1__478dc3', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Japanese', 't1__478dc3', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Japanese', 't1__478dc3', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Japanese', 'A', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Japanese', 'A', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Japanese', 'A', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'Japanese', 't1__478dc3', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'Japanese', 't1__478dc3', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'Japanese', 't1__478dc3', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'Japanese', 't1__478dc3', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 't2__a1e7e8', 't1__478dc3', 't2__f6da20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483637, 'Japanese', 't1__478dc3', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '7kqe8sfpuh0', 'A', '1b1');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'a929yb3xftrf', 'A', 'ql7o4rnoo');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Japanese', 't1__036a4b', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.translation FROM cards AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.setCode WHERE T1.name = 'Fellwar Stone' AND T2.language = 'Japanese' AND NOT T2.translation IS NULL;

/*
Gold Result:
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
*/

-- Prediction Query
SELECT T1.translation FROM set_translations AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code INNER JOIN cards AS T3 ON T2.code = T3.setCode WHERE T3.name = 'Fellwar Stone' AND T1.language = 'Japanese';

/*
Prediction Result:
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
('t2__f6da20',)
(None,)
*/