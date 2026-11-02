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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', 't1__f28b29', 'o22', '8507cvtjp');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 'tmu2n', 76.823924, '78lfvyz7zz', -2052653308, 543.387709, 'vkv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 1719800120, -210159774, 270415200, -2071531094, -397848196, -366775518, 575038073, -1161141730, -613916489, 2061558815, 895277769, 364043263, -1177989415, -1352968577, -519515742, 'gc1dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'C', 'lc', 'qb9i9f');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'ztv', '6', '4iz7', 'aqqlud8ft', '8', '9114q', 'r', '6b', 'jeuuwsj8kj', 114.099596, 'wpxlvris', 2042428747, 852.317741, 'z0kaq', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', 'sj', -1652411404, -553121210, 1720208360, -1243923337, 1231129324, -1782325492, -544173163, -958321297, 2015039199, -641927001, 558684943, -120625031, 572453185, 1348973408, -911953404, '97', 'aqz2o20pj6d', 'dlysu6iphd', 'u2g', 'r31', 'wq51oa', 'sb3uoi1p', 'avcvwnyqroui', 'lrpou', 't63', 'xyfvmjwpp26', 'b3aj', '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', '6dvdx', 'o', 'v7t3gvpl', '9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', 'g', 'A', 'kxginl', '6id');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', 419.701122, '96xiyet8', 1177967285, 141.586667, 'cf', '6cfperxa', '1sjv8nv3d', 'r', 'kuez', 'ctehia3cmvb', -1077762203, -1798310553, -1174073066, -1853296452, 2056318381, 1749319777, -213453775, -1721445347, -314024594, -786313930, 184502432, 1387373331, 1599677804, 2095228319, 1190577316, 'gm8gxb5qjl', 'awsp4', 'wi3', 'l7', 'j43y795ybv83', 'r3w', 'jn2z19xg', 'jac', 'gmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', '90nhs', '9gob', '6', '_', 'rn5u', 'phy');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'm2rlxcrw', 'x0', '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'olt0', '0zi90o50q', '33g865zm6', 'p', 980.288295, 'ewew092p40', 2074088791, 865.945447, 'il21xs', 'd', '6q5ziqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 1338378083, 945802166, 47431001, -698277997, 748510826, 990008540, -2083332040, -1732139002, 104130853, -1764222999, -144370926, -1436037867, -1567310198, 1484560348, 373735911, 'qx6j6d4', 'fc75m4s2ajdu', '6xuj90te', 'x3', '5u7709', 'qf9lx8qzabi', 'uumwu7', 'l', '0jw', '6hh', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', 'sme', 'v3r3u', 'doxa0o', 'l1zmjrssbh', '2404qpp33', '3a1ngqu', '8184d', 'ojdlhl', 'pdyxk0a', 'cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 'c4zpw867', 'fve0jf4i', 'G', 't99kvnbh', 'i6tp3t');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, '41faxc', 'je448u5', 'vdb', '3ceh', 'e3oylci', 'if0ly46upl', 'eoh3m3q0pq97', '534', '5xb', 169.135301, '1yspzc7', -587900447, 816.716584, 'pmpjjvec', 'trn6j72v', 'kwegrf6snl45', 'jw5pbgwojn', 'hh6va3tdx5hn', '5b733o58z', -2046523774, -561761019, -859943149, 1333753099, -2096555342, 453154609, 823950453, -20815215, -116159477, -269097713, -663558450, -168704210, 535909504, -215535291, -1116027668, '9fo', 't', 'kcq2iae6a', '6ql', '676lk8q', 'azkjyfxsov', '98', '8', '0235v8ik', '3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', '5i', 'dtdjm8r', 'y9lhw6lv7j45', 'k1qzqt5u', '42p20g', 'tfhk1l', 'bjksuye6', 'hvzboodlz60', 'sijufc2vfgh', 'xbu', 'xi', 'lq2is', 'q', '4u2fkzbw', '3q5br3', 'qobvbj26k', 'xc56', 'pvp0h2fln', 'lcorq', 'l1uod', 'v', 'O', 'f3ya6l431gf', 'g6');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483642, 'rl72q8ippxb6', '59q4tkf5j4c', '2y', '485ys1gz7p3h', 'g0wytz', 'p2a', 'd2hqs4zc1', '2282rnfvk', 'mfoqp', 392.435394, 'cnn53i', 178068376, 349.996895, 'wx0hv', 'v0oh59ivnipn', 'drokt16hq', '9', 'jae9ps4don', 'e0b6piqkuizi', -223111865, -1085464899, 1234250708, 868170608, 1027490015, -607926366, -250218274, 1888170894, 1590087415, 278497828, -393305044, -343838991, 1772920250, 382158362, 1992197254, 'apcw1gn', 'o6r9d3zdayv5', 'horvcc', 'wraqxeddnko4', 'dq70691b7', 's1i0k8thqz3', 's94x3', 'yxg3ufg', 'efrzw0qgiqh4', 'o', 'k79v0940', '7swb3349kf', '5l6rnd3rhb', 'nmbp96v512', 'bvxjnuw8', '4jm31nfs4ni', 'om2u85br29', '1kpjnnbss', '75w5nag', 'rj6o317kajtw', 'sqiuj9f94', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', '7wggg', '0zchdq8o', 'xze42', 'wen', '4ilc', 'kspw6gvo', 'c9l5zmrsv64', 'h6b1ugt', 'ygqofzr1q', '7z6ikr', 'Q', '1whx1dlzbb', '27z');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483641, 'ot6vp1', 'lrhqsxyube', 'yhmlrnycz8d5', 'kabtcpo', '1ke8euy0kcx', '8e4', 'bkfphyyxnm', 'cmn8usy', 'c1vk27ki', 470.030221, 'vof5ndgi80', 748669029, 76.400203, 'rs1z82twy', '4o1sqirlhj1', 'xi', 'o9km29vphx5v', '7jo', 'y', -341340731, 1033208903, -1445498465, -1625027824, -1044387325, -97237819, 940306450, -1475649316, -60939452, -1429787934, -1890822320, 1233437190, 1121644957, 382154633, -2122774702, 'tce54k', 'dvf12j4ljl', 'hxdpnhebny', 'a', 'xtpyee2zt2', 'gy7qnk', 'j2dsjla91nq', '7dxug9rta6w', 'n', 'l7a', 'q6gahjc', '84vxo5', 'ddfra', '2n0lwczduqt0', 'ig197gelrrul', 'blhtkb', 'og8ol', '9cnlvwnzp', 'cpw', '0q9z43yul6g', '5jlkkggq', 'kx1wfn', 'o', '1864', '9', '9n', 'w16bb6teck', 'aioh8mpzf5t', 'lsok6v', 'gc', '3b0v293muo', 'o5cwanc56', 'wf', 'y2vtct', '95snh', 'c1jc1', 't2__6d8b34', 'j3dmll8k26', 'qohr35iptx');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483640, '0qbwhbis', 'zzg8eizd0cun', 'g8', 'gvzm', 'iwbdo', '90a5nxzf', 'as9e', 'zdfe0r841i6v', '9a6h', 169.089297, 'y7etff9', 1245769485, 808.637382, '5cayzma', '7w', 'ku', 'o6stk1', 'xpevos', '9i6bswq', 1478841250, -480965409, 1185535353, 1703600624, -536008365, 1508846780, 1789545044, 435918223, -438688587, 1299411857, 941288614, -540669402, 424293966, -2098530635, -1085049437, 'abl7juf', 'hq6', 'd1hg2', 'jcakwtumv', 'p19dvetwec1z', '80x72p', 'z', 'z2fp2srds4d5', '7xpoymk4yzv', 'ff', '4e2yc', 'ssva836i', 'iizc5c', 'dllp4l71l0q', 'nksw3506', '6790', '4l0dafs830', 'j63fq', 'szsmbwzk5pa', 'p643', '5p37ekw', 'fm', '1p091mps3', 'vev5utc4w', '1h52f5f', '05rr8l', 'vqg3r2exf0w', 'asmde', 'khn0io22', 'u', '5ig', 'eidvgb68', 'bw', '1fs7hycn', 'b5afv61keoy', 'aj0p', 't3__e9169f', 'k4nr', 'gnhxf6i');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483648, 'ttg6bnou5zi3', 't3__353704', -68044929, 'kf', 'oacd07z2zez', 'o7w', 't1__f28b29');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483647, 'ccukjq1q', 't3__353704', -796609690, '1yh', '0', 'hlst1pqom', 'C');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483646, 'n', 't3__353704', 1487440939, 'y', 'hvyx8s', 'r', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, 'nd', 't3__353704', 2071439307, '89qy6s', 'u4euf', 'of8', 'G');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'qgjradfhj', 't3__353704', -417454764, 'k53p8e5ol', 'f0yf1ur8kzi', '0g50j597fz', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, '6gifj', 't3__353704', 1792401890, 'xt41zj', 'f1qj3se4dp', '4', 'O');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483642, 'uuwyewb', 't3__353704', 1533864667, 'g8', '1ev3gqe', 'nehcnt2v', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483641, 'lhv1', 't3__353704', -575776570, 'i78hfcwwwk', 'xvvf', 'aq65q', 't2__6d8b34');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, '6asm', 't3__353704', -1482138792, '2d4t9h4gw', 'pvhdbn16i83y', 'qv3c1', 't3__e9169f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, '0qjx29a', 't3__538844', 2096669052, 'px', 'siacshy', 'vyn3ea', 't3__e9169f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483638, 'vdwkko5vws', 't3__353704', 408038605, 'ks6r', 'y62kek7hibs', 'fh8imiuk', 't2__6d8b34');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483637, '3g', 't3__353704', 1718041231, 'wa8dxhv0a9e', 'gzmc05e27', 'v0', 't2__6d8b34');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483636, 'pq9c3reyy', 't3__353704', -1451517159, 'k2', 'upbwnk4fgnm', '2sp7', 't1__f28b29');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483635, 'bf', NULL, -45772902, 'p8sxfswd', 'wyo5krex79', 'kiyf8voo', 't1__f28b29');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, '9n8', '4', -734455130, '4h', 'ia2yp', 'uzhsrwbbp6lu', 't1__f28b29');

-- Inserting into table: legalities --
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483648, 'legacy', 'xd', 't1__f28b29');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483647, 'legacy', 'p61l', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483646, 'legacy', 'fs3qn0b', '_');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483645, 'legacy', 'f6bp', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483644, 'legacy', 'qcue', '_');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483643, 'legacy', '6ru', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483642, 'legacy', 'lraxg0gt', 'Q');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (2, 'legacy', 'vero7mfr86mo', 't2__6d8b34');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (3, 'legacy', '7pt', 't2__6d8b34');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483639, 'legacy', '7', 't3__e9169f');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483638, 'legacy', 'f9xs0', 't3__e9169f');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483637, 'legacy', 'ya12ba', 't3__e9169f');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483636, 't2__8b97b3', 'mu28jur734t', 't1__f28b29');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483635, 'legacy', 'lynm', 't1__f28b29');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (4, NULL, '5k5swwqcgs', 't1__f28b29');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.uuid, T3.language FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid INNER JOIN foreign_data AS T3 ON T1.uuid = T3.uuid WHERE T2.format = 'legacy';

/*
Gold Result:
('t1__f28b29', None)
('t1__f28b29', '4')
('t1__f28b29', 't3__353704')
('t1__f28b29', 't3__353704')
('A', 't3__353704')
('A', 't3__353704')
('A', 't3__353704')
('A', 't3__353704')
('A', 't3__353704')
('A', 't3__353704')
('A', 't3__353704')
('A', 't3__353704')
('A', 't3__353704')
('t3__e9169f', 't3__353704')
('t3__e9169f', 't3__538844')
('t3__e9169f', 't3__353704')
('t3__e9169f', 't3__538844')
('t3__e9169f', 't3__353704')
('t3__e9169f', 't3__538844')
('t1__f28b29', None)
('t1__f28b29', '4')
('t1__f28b29', 't3__353704')
('t1__f28b29', 't3__353704')
('t2__6d8b34', 't3__353704')
('t2__6d8b34', 't3__353704')
('t2__6d8b34', 't3__353704')
('t2__6d8b34', 't3__353704')
('t2__6d8b34', 't3__353704')
('t2__6d8b34', 't3__353704')
*/

-- Prediction Query
SELECT DISTINCT legalities.uuid, foreign_data.language FROM legalities INNER JOIN foreign_data ON legalities.uuid = foreign_data.uuid WHERE legalities.format = 'legacy';

/*
Prediction Result:
('t1__f28b29', None)
('t1__f28b29', '4')
('t1__f28b29', 't3__353704')
('A', 't3__353704')
('t3__e9169f', 't3__353704')
('t3__e9169f', 't3__538844')
('t2__6d8b34', 't3__353704')
*/