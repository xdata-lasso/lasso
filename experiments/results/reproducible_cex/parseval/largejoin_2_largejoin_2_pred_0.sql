-- Schema DDL
CREATE TABLE RA (A1 TEXT(5) PRIMARY KEY, B TEXT(5));

CREATE TABLE RB (A2 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RA (A1));

CREATE TABLE RC (A3 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RB (A2));

CREATE TABLE RD (A4 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RC (A3));

CREATE TABLE RE (A5 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RD (A4));

CREATE TABLE RF (A6 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RE (A5));

CREATE TABLE RG (A7 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RF (A6));

CREATE TABLE RH (A8 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RG (A7));

CREATE TABLE RI (A9 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RH (A8));

CREATE TABLE RJ (A10 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RI (A9));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ra --
INSERT INTO "ra" ("a1", "b") VALUES ('value', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('rb__231bc3', 'value');

INSERT INTO "ra" ("a1", "b") VALUES ('A', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('C', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_6', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('rb__8ec25a', 'value');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_11', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_12', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_13', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_14', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('@', '4cf81');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_24', '_');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_25', '_');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_26', '_');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_27', '_');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_36', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_37', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_38', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_39', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('?', '4cf81');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_49', 'w');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_50', 'w');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_51', 'w');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_52', 'w');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('O', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_61', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_64', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_65', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_66', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_67', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_72', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_74', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_75', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_76', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_77', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('_', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_82', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_85', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_86', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_87', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_88', 'O');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('G', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_93', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_96', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_97', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_98', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_99', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59_60', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59_60_61', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59_60_61_62', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59_60_61_62_63', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59_60_61_62_63_64', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59_60_61_62_63_64_65', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59_60_61_62_63_64_65_66', 'ra__2d4da0');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55_56_57_58_59_60_61_62_63_64_65_66_67', 'ra__2d4da0');

-- Inserting into table: rb --
INSERT INTO "rb" ("a2", "b") VALUES ('ra__2d4da0', 'rb__231bc3');

INSERT INTO "rb" ("a2", "b") VALUES ('rc__576d6b', 'rb__231bc3');

INSERT INTO "rb" ("a2", "b") VALUES ('a2_3', 'rb__8ec25a');

INSERT INTO "rb" ("a2", "b") VALUES ('rc__13e786', 'value_1_2');

INSERT INTO "rb" ("a2", "b") VALUES ('A', 'rb__231bc3');

INSERT INTO "rb" ("a2", "b") VALUES ('@', '@');

INSERT INTO "rb" ("a2", "b") VALUES ('G', 'rb__231bc3');

INSERT INTO "rb" ("a2", "b") VALUES ('O', 'rb__231bc3');

INSERT INTO "rb" ("a2", "b") VALUES ('rb__17f2e0', 'value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42_43_44_45_46_47_48_49_50_51_52_53_54_55');

-- Inserting into table: rc --
INSERT INTO "rc" ("a3", "b") VALUES ('rb__231bc3', 'rc__576d6b');

INSERT INTO "rc" ("a3", "b") VALUES ('a3_2', 'rc__13e786');

INSERT INTO "rc" ("a3", "b") VALUES ('A', 'rc__576d6b');

INSERT INTO "rc" ("a3", "b") VALUES ('O', 'rc__576d6b');

INSERT INTO "rc" ("a3", "b") VALUES ('G', 'rc__576d6b');

INSERT INTO "rc" ("a3", "b") VALUES ('rc__538345', 'O');

-- Inserting into table: rd --
INSERT INTO "rd" ("a4", "b") VALUES ('rc__576d6b', 'rb__231bc3');

INSERT INTO "rd" ("a4", "b") VALUES ('a4_2', 'a3_2');

INSERT INTO "rd" ("a4", "b") VALUES ('@', 'a3_2');

INSERT INTO "rd" ("a4", "b") VALUES ('A', 'rb__231bc3');

INSERT INTO "rd" ("a4", "b") VALUES ('C', 'rb__231bc3');

INSERT INTO "rd" ("a4", "b") VALUES ('rd__4e89c1', 'O');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RA.B FROM RA INNER JOIN RB ON (RA.B = RB.A2) INNER JOIN RC ON (RB.B = RC.A3) INNER JOIN RD ON (RC.B = RD.A4) GROUP BY RA.B HAVING COUNT(RA.B) > 3;

/*
Gold Result:
('G',)
('O',)
('ra__2d4da0',)
*/

-- Prediction Query
SELECT RA.B FROM RA WHERE 1 = 2;

/*
Prediction Result:
*/