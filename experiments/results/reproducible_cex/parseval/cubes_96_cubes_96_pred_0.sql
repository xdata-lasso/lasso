-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: tv_channel --
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_1', '5k5swwqcgs', '9n8', 'tv__f6645f', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_2', 'tti', 'bnp', 'tv__f6645f', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_3', 'zbuo4nrqrof', 'qyp5s5bbp0', 'tv__f6645f', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_4', '13pyu', '8d99rljsl', 'tv__6f981e', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_5', 'v', 'ph2', 'tv__6f981e', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_6', 'ozk3zbily', 'kn6vc', 'tv__6f981e', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_7', 'jja', '5dh', 'tv__f6645f', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_8', 'jh3den8', 'c68x8vacx7', 'tv__f6645f', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_9', 'q8qdjpe1', 'o22', 'tv__f6645f', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_10', 'd5ysxc', 'r0oz', 'tv__6f981e', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'r94gth2m', 'ajjl');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_11', '3', 'okv8uttmu2', 'tv__6f981e', 'e578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_12', 'pmaus3auvmkr', 'pdjwzw5chn9', 'tv__6f981e', 'o705', 'a9n0jxfofws', 'do2zobb', 'q0k32od', 'cl5ams');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_13', 'orlwyngc1dj', '9erhizgk1yoe', 'tv__f6645f', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_14', '2q2xlyoto', '9oaawg', 'tv__f6645f', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_15', 'vzxw1rxe', '9yfk7qk162n', 'tv__f6645f', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_16', 'wt', 'xxnja', 'tv__6f981e', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_17', 'qta8y3a17v4y', 'ma', 'tv__6f981e', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_18', 'dmsqtg', 'lc', 'tv__6f981e', 'qb9i9f', 'ccukjq1q', 'ik1yhb', '8hlst1p', 'qomiztvb6m');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_19', 'iz78aqql', 'd8ftb8', NULL, '9114q', 'r', '6b', 'jeuuwsj8kj', '85');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_20', 'pxlvri', 'surz0kaqtncg', NULL, 'c8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', 'han');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_21', 'xdpunmw', 'wx', NULL, 'rlawk', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_22', 'dk', 'u2gir31vwq5', NULL, 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_23', 'mjwpp2', 'mb3aj0ju0', NULL, '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_24', '2', 'zg3r', NULL, 'jkwns47j2j', '8', 'c', 'y', 'vjwq49yr');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_25', 'nxs6dvdxdo2v', '7t3gvplj9f', 'tv__f6645f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_26', '1', 'l', 'tv__f6645f', 'upgly78oit', 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_27', '1spxpw30', 'g', 'tv__f6645f', 'kxginl', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_28', '49kuboe8cd', '4u', 'tv__6f981e', 'kh', 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_29', 'c296xiy', 'et8xjhcf46c', 'tv__6f981e', 'pe', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_30', '1esks', '9q', 'tv__6f981e', '2qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_31', '3y795ybv', '3kr3w4jn2', 'tv__f6645f', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_32', 'cel8mhfcim', 'n5enii0fmbgz', 'tv__f6645f', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_33', 'mn', 'w4m0', 'tv__f6645f', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_34', 'qkna', '38gfxswb2d0', 'tv__6f981e', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_35', '90nhs', '9gob', 'tv__6f981e', '6', 'rn5u', 'phy', 'n', 'a');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_36', 'vhvyx8s', 'r', 'tv__6f981e', 'fs3qn0b', 'm2rlxcrw', 'x0', '3rzgz84lqm', '2w');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_37', 'b1b3vun66e0i', 'olt0', 'tv__f6645f', '0zi90o50q', '33g865zm6', 'p', 'ewew092p40', '2vil21');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_38', 'sad6q5', 'iqoauy0', 'tv__f6645f', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_39', 'dip', 'txfbl10qx6j', 'tv__f6645f', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_40', 'alj0jwk6h', '2o', 'tv__6f981e', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_41', 'in', 'bciv', 'tv__6f981e', 'ojsmeqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_42', 'a1ngqut8', '184dwojdlhlz', 'tv__6f981e', 'dyxk', '0a0cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_43', 'a4gkjog8d', 'w16f5tqhjd', 'tv__f6645f', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 'c4zpw867');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_44', 'fve0jf4i', 't99kvnbh', 'tv__f6645f', 'i6tp3t', 'nd', 'w89qy', 'sru4eufio', '8o');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_45', '6b', 'p9qgjradfhj', 'tv__f6645f', '8zr6k53p8e5o', 'f0y', '1u', 'r8kzi0g50j5', '7fznqcuex');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_46', '1faxc1je', '48u5lvdb', 'tv__6f981e', '3ceh', 'e3oylci', 'if0ly46upl', 'eoh3m3q0pq97', '534');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_47', '5xb', '11y', 'tv__6f981e', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_48', '2vkwegrf6snl', '5jw5pbgw', 'tv__6f981e', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_49', '4', 'yi4h5c4f1q', 'tv__f6645f', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_50', 'azkjy', 'fxsove98b8', 'tv__f6645f', '0235v8ik', '3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_51', '4qpog5smdhct', 'nj8y6whwhl', 'tv__f6645f', '5i', 'dtdjm8r', 'y9lhw6lv7j45', 'k1qzqt5u', '42p20g');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_52', 'tfhk1l', 'bjksuye6', 'tv__6f981e', 'hvzboodlz60', 'sijufc2vfgh', 'xbu', 'xi', 'lq2is');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_53', 'q', '4u2fkzbw', 'tv__6f981e', '3q5br3', 'qobvbj26k', 'xc56', 'pvp0h2fln', 'lcorq');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_54', 'l1uod', 'v', 'tv__6f981e', 'f3ya6l431gf', 'g6', '6gifj', 'vxt41', 'jf1qj3s');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_55', '4d', 'pb4l6rurl72q', 'tv__f6645f', 'ippxb659q', 'tkf5j4ce', 'y485ys1g', '7p3hvg0', 'ytzip2');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_56', 'a6d2hqs4zc1', '2282rnfvk', 'tv__f6645f', 'mfoqp', 'ucnn53i', '8owqwx0hv', 'v0oh59ivnipn', 'drokt16hq');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_57', '9', 'jae9ps4don', 'tv__f6645f', 'e0b6piqkuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_58', 'cw1g', 'o6r9', 'tv__6f981e', '3', 'dayv5uh', 'rvcc', 'wraqxeddnko4', 'dq70691b7');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_59', 's1i0k8thqz3', 's94x3', 'tv__6f981e', 'yxg3ufg', 'efrzw0qgiqh4', 'o', 'k79v0940', '7swb3349kf');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_60', '5l6rnd3rhb', 'nmbp96v512', 'tv__6f981e', 'bvxjnuw8', '4jm31nfs4ni', 'om2u85br29', '1kpjnnbss', '75w5nag');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_61', 'rj6o317kajtw', 'sqiuj9f94', 'tv__f6645f', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_62', '7wggg', '0zchdq8o', 'tv__f6645f', 'xze42', 'wen', '4ilc', 'kspw6gvo', 'c9l5zmrsv64');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_63', 'h6b1ugt', 'ygqofzr1q', 'tv__f6645f', '7z6ikr', '1whx1dlzbb', '27z', 'uuwyewb', 'hg8');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_64', '1ev3gqe', 'nehcnt2v', 'tv__6f981e', 'lraxg0gt', 'ot6vp1', 'lrhqsxyube', 'yhmlrnycz8d5', 'kabtcpo');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_65', '1ke8euy0kcx', '8e4', 'tv__6f981e', 'bkfphyyxnm', 'cmn8usy', 'c1vk27ki', 'uvof5ndg', '80z');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_66', 'qe9rs1z82tw', '4o1sqir', 'tv__6f981e', 'hj1', 'xi', 'o9km29vphx5v', '7jo', 'y');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_67', '1skvh4q', 'y4gp', 'tv__f6645f', '0kr5bk0d0gkg', 'qavutce54k', 'dvf12j4ljl', 'hxdpnhebny', 'a');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_68', 'xtpyee2zt2', 'gy7qnk', 'tv__f6645f', 'j2dsjla91nq', '7dxug9rta6w', 'n', 'l7a', 'q6gahjc');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_69', '84vxo5', 'ddfra', 'tv__f6645f', '2n0lwczduqt0', 'ig197gelrrul', 'blhtkb', 'og8ol', '9cnlvwnzp');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_70', 'cpw', '0q9z43yul6g', 'tv__6f981e', '5jlkkggq', 'kx1wfn', 'o', '1864', '9');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_71', '9n', 'w16bb6teck', 'tv__6f981e', 'aioh8mpzf5t', 'lsok6v', 'gc', '3b0v293muo', 'o5cwanc56');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_72', 'wf', 'y2vtct', 'tv__6f981e', '95snh', 'c1jc1', 'j3dmll8k26', 'qohr35iptx', 'lhv1');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_73', 'ti78hf', 'w', 'tv__f6645f', 'wwkmxvvfta', 'q65qvero7mf', '86mok', 'pt50qbwhb', 'szz');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_74', 'g8eizd0cun', 'g8', 'tv__f6645f', 'gvzm', 'iwbdo', '90a5nxzf', 'as9e', 'zdfe0r841i6v');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_75', '9a6h', 'qzy', 'tv__f6645f', 'etff9znz5', 'a', 'yzmae7whkuxo', '6stk1uxpevo', 'sy9i6bswqb');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_76', 'oyhady', '3jap', 'tv__6f981e', 'pzj', '2', 'zxpmaspu0abl', 'jufkhq6sd', 'hg28jca');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_77', 'wtu', 'mvp19dvetw', 'tv__6f981e', 'ec1zu80x72pb', 'z2fp2sr', 's', 'd57xpoym', '4yz');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_78', 'effs4e', 'yc4ssva8', 'tv__6f981e', '6iviizc5', 'd', 'lp4', 'l71l0q4nksw', '506p6790');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_79', '4l0dafs830', 'j63fq', 'tv__f6645f', 'szsmbwzk5pa', 'p643', '5p37ekw', 'fm', '1p091mps3');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_80', 'vev5utc4w', '1h52f5f', 'tv__f6645f', '05rr8l', 'vqg3r2exf0w', 'asmde', 'khn0io22', 'u');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_81', '5ig', 'eidvgb68', 'tv__f6645f', 'bw', '1fs7hycn', 'b5afv61keoy', 'aj0p', 'k4nr');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_82', 'gnhxf6i', '6asm', 'tv__6f981e', '572', '4', 't9h4gwpvhdb', 'n16i83ytqv3', '1');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_83', '0qjx29a', 'f', 'tv__6f981e', 'x1si', 'c', 'hyuvy', '3eac', '7vdwkko5vwsu');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_84', 'ks6r', 'y62kek7hibs', 'tv__6f981e', 'fh8imiuk', 'f9xs0', '3g', 'w', '8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT language_other AS LANGUAGE, n_other AS count___ FROM (SELECT LHS.language AS LANGUAGE, LHS.n AS n, RHS.language AS language_other, RHS.n AS n_other FROM (SELECT LANGUAGE, COUNT(*) AS n FROM tv_channel GROUP BY LANGUAGE) AS LHS CROSS JOIN (SELECT LANGUAGE, COUNT(*) AS n FROM tv_channel GROUP BY LANGUAGE) AS RHS) WHERE (n > n_other) ORDER BY LANGUAGE, count___ NULLS LAST;

/*
Gold Result:
(None, 6)
(None, 6)
*/

-- Prediction Query
SELECT LANGUAGE, COUNT(*) FROM TV_Channel GROUP BY LANGUAGE ORDER BY COUNT(*) ASC, LANGUAGE NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, 6)
*/