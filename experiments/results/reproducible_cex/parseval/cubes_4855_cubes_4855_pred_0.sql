-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Staff" ("Staff_ID" INTEGER PRIMARY KEY, "Staff_Details" TEXT(255));

CREATE TABLE "Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATETIME, "End_Date" DATETIME, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claim_Headers" ("Claim_Header_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Claim_Status_Code" TEXT(15), "Claim_Type_Code" TEXT(15), "Date_of_Claim" DATETIME, "Date_of_Settlement" DATETIME, "Amount_Claimed" REAL(20, 4), "Amount_Piad" REAL(20, 4), FOREIGN KEY ("Policy_ID") REFERENCES "Policies" ("Policy_ID"));

CREATE TABLE "Claims_Documents" ("Claim_ID" INTEGER, "Document_Type_Code" TEXT(15), "Created_by_Staff_ID" INTEGER, "Created_Date" INTEGER, PRIMARY KEY ("Claim_ID", "Document_Type_Code"), FOREIGN KEY ("Created_by_Staff_ID") REFERENCES "Staff" ("Staff_ID"), FOREIGN KEY ("Claim_ID") REFERENCES "Claim_Headers" ("Claim_Header_ID"));

CREATE TABLE "Claims_Processing_Stages" ("Claim_Stage_ID" INTEGER PRIMARY KEY, "Next_Claim_Stage_ID" INTEGER, "Claim_Status_Name" TEXT(255), "Claim_Status_Description" TEXT(255));

CREATE TABLE "Claims_Processing" ("Claim_Processing_ID" INTEGER PRIMARY KEY, "Staff_ID" INTEGER, "Claim_ID" INTEGER, "Claim_Outcome_Code" TEXT(15), "Claim_Stage_ID" INTEGER, FOREIGN KEY ("Staff_ID") REFERENCES "Staff" ("Staff_ID"), FOREIGN KEY ("Claim_ID") REFERENCES "Claim_Headers" ("Claim_Header_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483648, 'cus_8a62ed');

-- Inserting into table: policies --
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483648, -2147483648, 'pol_77d7e5', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483647, -2147483648, 'pol_77d7e5', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483646, -2147483648, 'pol_77d7e5', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483645, -2147483648, 'pol_8ef4fa', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483644, -2147483648, 'pol_8ef4fa', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483643, -2147483648, 'pol_8ef4fa', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483642, -2147483648, 'pol_77d7e5', '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483641, -2147483648, 'pol_77d7e5', '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483640, -2147483648, 'pol_77d7e5', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483639, -2147483648, 'pol_8ef4fa', '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483638, -2147483648, 'pol_8ef4fa', '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483637, -2147483648, 'pol_8ef4fa', '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483636, -2147483648, 'pol_77d7e5', '2023-05-25 17:04:36+00:00', '2020-12-10 17:36:20+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483635, -2147483648, 'pol_77d7e5', '2025-08-22 00:34:24+00:00', '2022-04-13 09:01:25+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483634, -2147483648, 'pol_77d7e5', '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483633, -2147483648, 'pol_8ef4fa', '2024-04-12 00:38:47+00:00', '2021-07-31 11:04:01+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483632, -2147483648, 'pol_8ef4fa', '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483631, -2147483648, 'pol_8ef4fa', '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483630, -2147483648, NULL, '2021-01-23 18:11:33+00:00', '2021-07-20 10:41:36+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483629, -2147483648, NULL, '2025-02-07 06:53:31+00:00', '2021-10-06 00:40:57+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483628, -2147483648, NULL, '2022-04-12 01:47:28+00:00', '2021-08-20 16:50:24+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483627, -2147483648, NULL, '2021-12-31 07:20:26+00:00', '2021-12-08 15:32:00+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483626, -2147483648, NULL, '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483625, -2147483648, NULL, '2024-02-29 12:08:41+00:00', '2022-10-15 07:04:26+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483624, -2147483648, 'pol_77d7e5', '2022-12-10 02:38:39+00:00', '2024-05-04 23:07:19+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483623, -2147483648, 'pol_77d7e5', '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483622, -2147483648, 'pol_77d7e5', '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483621, -2147483648, 'pol_8ef4fa', '2025-05-02 19:47:39+00:00', '2023-07-26 05:50:21+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483620, -2147483648, 'pol_8ef4fa', '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483619, -2147483648, 'pol_8ef4fa', '2025-08-21 21:00:40+00:00', '2024-01-02 11:27:20+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483618, -2147483648, 'pol_77d7e5', '2020-05-12 00:10:04+00:00', '2021-02-04 01:21:18+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483617, -2147483648, 'pol_77d7e5', '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483616, -2147483648, 'pol_77d7e5', '2023-12-22 03:17:01+00:00', '2024-05-26 02:52:16+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483615, -2147483648, 'pol_8ef4fa', '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483614, -2147483648, 'pol_8ef4fa', '2024-10-24 14:16:53+00:00', '2024-02-23 22:32:48+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483613, -2147483648, 'pol_8ef4fa', '2025-09-21 09:36:38+00:00', '2023-05-17 17:49:21+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483612, -2147483648, 'pol_77d7e5', '2025-10-02 08:51:14+00:00', '2022-10-09 12:52:21+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483611, -2147483648, 'pol_77d7e5', '2024-01-27 22:01:59+00:00', '2021-09-24 11:50:48+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483610, -2147483648, 'pol_77d7e5', '2025-10-19 18:29:54+00:00', '2022-02-18 18:38:40+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483609, -2147483648, 'pol_8ef4fa', '2021-11-17 08:00:56+00:00', '2025-10-15 06:50:58+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483608, -2147483648, 'pol_8ef4fa', '2024-12-28 10:57:01+00:00', '2022-03-17 22:33:35+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483607, -2147483648, 'pol_8ef4fa', '2022-01-22 16:14:13+00:00', '2024-02-28 04:46:49+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483606, -2147483648, 'pol_77d7e5', '2024-04-01 02:40:29+00:00', '2020-02-25 10:33:58+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483605, -2147483648, 'pol_77d7e5', '2022-01-05 17:19:47+00:00', '2023-07-13 23:57:06+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483604, -2147483648, 'pol_77d7e5', '2024-11-25 22:27:17+00:00', '2020-08-22 17:31:36+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483603, -2147483648, 'pol_8ef4fa', '2022-07-13 23:48:43+00:00', '2021-08-01 11:21:15+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483602, -2147483648, 'pol_8ef4fa', '2022-02-19 15:51:21+00:00', '2020-01-22 05:30:29+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483601, -2147483648, 'pol_8ef4fa', '2023-08-19 04:29:46+00:00', '2022-05-03 02:13:10+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483600, -2147483648, 'pol_77d7e5', '2024-10-18 05:00:47+00:00', '2023-03-18 23:06:49+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483599, -2147483648, 'pol_77d7e5', '2025-09-09 06:56:52+00:00', '2021-11-25 10:04:53+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483598, -2147483648, 'pol_77d7e5', '2023-11-18 08:10:54+00:00', '2021-12-11 04:26:48+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483597, -2147483648, 'pol_8ef4fa', '2021-08-05 01:19:54+00:00', '2025-11-19 11:50:18+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483596, -2147483648, 'pol_8ef4fa', '2021-05-27 14:39:41+00:00', '2021-07-01 18:29:24+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483595, -2147483648, 'pol_8ef4fa', '2023-03-10 01:47:11+00:00', '2023-08-25 07:55:29+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483594, -2147483648, 'pol_77d7e5', '2021-03-25 19:22:18+00:00', '2021-02-17 21:51:43+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483593, -2147483648, 'pol_77d7e5', '2023-01-02 05:47:29+00:00', '2025-03-16 12:14:02+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483592, -2147483648, 'pol_77d7e5', '2022-08-31 15:38:50+00:00', '2023-10-12 22:40:24+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483591, -2147483648, 'pol_8ef4fa', '2023-01-13 04:58:30+00:00', '2024-12-22 09:14:04+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483590, -2147483648, 'pol_8ef4fa', '2022-05-13 17:57:39+00:00', '2022-03-25 08:00:08+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483589, -2147483648, 'pol_8ef4fa', '2025-01-11 14:32:08+00:00', '2023-11-27 00:51:18+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483588, -2147483648, 'pol_77d7e5', '2023-03-13 16:07:34+00:00', '2022-10-12 16:19:32+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483587, -2147483648, 'pol_77d7e5', '2024-09-04 21:17:21+00:00', '2024-09-26 13:13:01+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483586, -2147483648, 'pol_77d7e5', '2021-07-21 20:51:39+00:00', '2021-03-27 18:00:10+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483585, -2147483648, 'pol_8ef4fa', '2021-07-14 21:04:24+00:00', '2023-07-26 21:52:05+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483584, -2147483648, 'pol_8ef4fa', '2023-12-31 18:03:51+00:00', '2023-04-11 01:23:11+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483583, -2147483648, 'pol_8ef4fa', '2024-03-18 20:04:07+00:00', '2022-03-22 13:45:21+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483582, -2147483648, 'pol_77d7e5', '2023-10-21 02:54:45+00:00', '2022-04-27 23:55:02+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483581, -2147483648, 'pol_77d7e5', '2020-10-15 10:13:01+00:00', '2024-09-10 08:04:52+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483580, -2147483648, 'pol_77d7e5', '2022-03-30 02:18:34+00:00', '2025-02-21 13:28:29+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483579, -2147483648, 'pol_8ef4fa', '2024-02-28 14:45:41+00:00', '2024-08-09 01:13:45+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483578, -2147483648, 'pol_8ef4fa', '2025-12-09 03:18:27+00:00', '2024-12-24 08:31:16+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483577, -2147483648, 'pol_8ef4fa', '2023-06-28 05:47:44+00:00', '2025-11-28 13:30:18+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483576, -2147483648, 'pol_77d7e5', '2025-12-29 07:05:42+00:00', '2024-08-08 03:54:09+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483575, -2147483648, 'pol_77d7e5', '2020-08-21 23:51:43+00:00', '2020-10-30 07:33:08+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483574, -2147483648, 'pol_77d7e5', '2023-11-06 04:09:03+00:00', '2023-09-10 09:37:01+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483573, -2147483648, 'pol_8ef4fa', '2023-04-27 18:28:48+00:00', '2025-07-25 08:53:04+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483572, -2147483648, 'pol_8ef4fa', '2023-02-15 11:45:56+00:00', '2024-12-23 02:48:29+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483571, -2147483648, 'pol_8ef4fa', '2024-01-30 01:02:36+00:00', '2021-01-22 00:53:52+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483570, -2147483648, 'pol_77d7e5', '2020-03-11 08:08:02+00:00', '2020-06-06 08:33:45+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483569, -2147483648, 'pol_77d7e5', '2021-07-30 02:29:08+00:00', '2022-01-26 11:13:48+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483568, -2147483648, 'pol_77d7e5', '2023-09-26 13:08:37+00:00', '2020-12-04 21:49:29+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483567, -2147483648, 'pol_8ef4fa', '2020-07-01 12:41:54+00:00', '2022-03-02 18:03:57+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483566, -2147483648, 'pol_8ef4fa', '2021-10-14 08:16:37+00:00', '2022-02-18 09:12:59+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483565, -2147483648, 'pol_8ef4fa', '2025-05-09 05:17:21+00:00', '2023-02-13 21:14:29+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483564, -2147483648, 'pol_77d7e5', '2025-05-27 16:57:17+00:00', '2020-12-18 09:02:22+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483563, -2147483648, 'pol_77d7e5', '2020-05-10 07:36:02+00:00', '2022-01-23 03:13:33+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483562, -2147483648, 'pol_77d7e5', '2021-04-06 16:11:52+00:00', '2022-08-03 01:56:16+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483561, -2147483648, 'pol_8ef4fa', '2023-07-15 22:31:56+00:00', '2020-06-29 02:04:50+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483560, -2147483648, 'pol_8ef4fa', '2024-06-08 14:05:00+00:00', '2024-09-12 11:18:07+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483559, -2147483648, 'pol_8ef4fa', '2021-04-23 15:57:00+00:00', '2020-10-20 06:14:04+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483558, -2147483648, 'pol_77d7e5', '2024-08-10 07:57:32+00:00', '2021-10-07 12:15:00+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483557, -2147483648, 'pol_77d7e5', '2020-10-05 05:32:26+00:00', '2023-11-18 03:19:57+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483556, -2147483648, 'pol_77d7e5', '2025-08-02 02:30:29+00:00', '2025-05-19 00:55:13+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483555, -2147483648, 'pol_8ef4fa', '2022-11-21 14:30:10+00:00', '2023-06-17 22:27:46+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483554, -2147483648, 'pol_8ef4fa', '2020-04-25 22:30:05+00:00', '2020-04-02 07:45:47+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483553, -2147483648, 'pol_8ef4fa', '2023-05-31 07:22:36+00:00', '2021-05-16 14:38:12+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483552, -2147483648, 'pol_77d7e5', '2023-05-15 04:44:08+00:00', '2020-02-20 05:24:11+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483551, -2147483648, 'pol_77d7e5', '2021-07-02 01:45:48+00:00', '2023-03-28 14:41:46+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483550, -2147483648, 'pol_77d7e5', '2021-06-12 16:42:05+00:00', '2025-03-26 10:17:14+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483549, -2147483648, 'pol_8ef4fa', '2025-11-22 09:05:23+00:00', '2024-04-25 17:48:47+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483548, -2147483648, 'pol_8ef4fa', '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483547, -2147483648, 'pol_8ef4fa', '2025-01-10 14:09:09+00:00', '2025-11-27 06:11:21+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483546, -2147483648, 'pol_77d7e5', '2023-07-25 15:03:55+00:00', '2020-10-15 18:29:15+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483545, -2147483648, 'pol_77d7e5', '2022-05-28 16:44:30+00:00', '2022-12-13 04:17:12+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483544, -2147483648, 'pol_77d7e5', '2021-07-03 08:58:16+00:00', '2022-03-20 09:18:33+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483543, -2147483648, 'pol_8ef4fa', '2020-03-06 15:32:29+00:00', '2025-02-02 06:02:30+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483542, -2147483648, 'pol_8ef4fa', '2020-09-05 12:25:49+00:00', '2023-03-07 13:22:39+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483541, -2147483648, 'pol_8ef4fa', '2024-12-20 11:42:02+00:00', '2024-06-05 23:32:14+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483540, -2147483648, 'pol_77d7e5', '2023-03-26 06:11:01+00:00', '2020-09-26 17:28:32+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483539, -2147483648, 'pol_77d7e5', '2022-05-09 09:35:03+00:00', '2025-10-16 14:52:58+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483538, -2147483648, 'pol_77d7e5', '2025-05-15 17:08:24+00:00', '2023-09-09 00:28:32+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483537, -2147483648, 'pol_8ef4fa', '2021-02-09 08:26:06+00:00', '2021-04-15 20:48:35+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483536, -2147483648, 'pol_8ef4fa', '2020-01-23 21:20:16+00:00', '2021-02-04 08:22:25+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483535, -2147483648, 'pol_8ef4fa', '2020-07-12 19:51:25+00:00', '2025-07-17 09:46:47+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT policy_type_code_other AS policy_type_code FROM (SELECT LHS.policy_type_code AS policy_type_code, LHS.n AS n, LHS.maxn AS maxn, RHS.policy_type_code AS policy_type_code_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT policy_type_code, n, MAX(n) OVER () AS maxn FROM (SELECT policy_type_code, COUNT(*) AS n FROM policies GROUP BY policy_type_code)) AS LHS CROSS JOIN (SELECT policy_type_code, n, MAX(n) OVER () AS maxn FROM (SELECT policy_type_code, COUNT(*) AS n FROM policies GROUP BY policy_type_code)) AS RHS) WHERE (maxn = maxn_other AND n_other >= maxn_other) ORDER BY policy_type_code;

/*
Gold Result:
('pol_77d7e5',)
('pol_8ef4fa',)
*/

-- Prediction Query
SELECT policy_type_code FROM policies GROUP BY policy_type_code ORDER BY COUNT(*) DESC, policy_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('pol_77d7e5',)
*/