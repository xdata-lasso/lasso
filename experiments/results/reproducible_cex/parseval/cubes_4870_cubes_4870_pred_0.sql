-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483648, 'cus_8a62ed');

-- Inserting into table: customer_policies --
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483648, -2147483648, 'cus_56250a', '2025-06-17', '2021-11-08');

-- Inserting into table: claims --
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (-2147483648, -2147483648, '2025-06-13', '2023-03-15', -664303813, -1022641847);

-- Inserting into table: settlements --
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (-2147483648, -2147483648, '2021-02-05', '2023-04-14', 247012447, -1980249628, -734455130);

-- Inserting into table: payments --
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483648, -2147483648, 'pay_6faa20', '2020-09-26', -1633151678);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483647, -2147483648, 'pay_6faa20', '2020-01-20', 1268590800);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483646, -2147483648, 'pay_6faa20', '2022-09-17', -1670923962);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483645, -2147483648, 'pay_02cc31', '2023-11-30', 1908028688);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483644, -2147483648, 'pay_02cc31', '2022-08-24', 13244799);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483643, -2147483648, 'pay_02cc31', '2021-04-10', -1910425938);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483642, -2147483648, 'pay_6faa20', '2023-05-30', -1610064545);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483641, -2147483648, 'pay_6faa20', '2022-04-29', 462974032);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483640, -2147483648, 'pay_6faa20', '2022-07-21', -918961358);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483639, -2147483648, 'pay_02cc31', '2020-11-04', -45536098);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483638, -2147483648, 'pay_02cc31', '2023-11-17', -1399556171);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483637, -2147483648, 'pay_02cc31', '2024-07-24', 546571701);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483636, -2147483648, 'pay_6faa20', '2023-05-08', 1408123494);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483635, -2147483648, 'pay_6faa20', '2025-04-12', 374105386);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483634, -2147483648, 'pay_6faa20', '2021-06-11', 1149850321);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483633, -2147483648, 'pay_02cc31', '2020-10-26', -1585009206);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483632, -2147483648, 'pay_02cc31', '2025-06-20', 742285925);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483631, -2147483648, 'pay_02cc31', '2023-08-27', -1179823637);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483630, -2147483648, NULL, '2023-02-21', -967741825);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483629, -2147483648, NULL, '2022-11-29', -472966518);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483628, -2147483648, NULL, '2023-03-15', 902551284);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483627, -2147483648, NULL, '2022-08-27', 882961052);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483626, -2147483648, NULL, '2020-11-05', -751275471);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483625, -2147483648, NULL, '2021-07-19', 1673584235);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483624, -2147483648, 'pay_6faa20', '2024-10-16', 2074205376);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483623, -2147483648, 'pay_6faa20', '2024-03-30', -525979501);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483622, -2147483648, 'pay_6faa20', '2022-08-06', 1644911394);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483621, -2147483648, 'pay_02cc31', '2021-04-03', 90119032);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483620, -2147483648, 'pay_02cc31', '2021-12-23', -305670381);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483619, -2147483648, 'pay_02cc31', '2021-06-29', -453362185);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483618, -2147483648, 'pay_6faa20', '2023-07-07', 1909986641);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483617, -2147483648, 'pay_6faa20', '2024-04-09', -953437896);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483616, -2147483648, 'pay_6faa20', '2025-02-23', 2142703426);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483615, -2147483648, 'pay_02cc31', '2023-09-01', 176380444);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483614, -2147483648, 'pay_02cc31', '2022-01-18', 1661181156);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483613, -2147483648, 'pay_02cc31', '2024-09-13', -2031361952);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483612, -2147483648, 'pay_6faa20', '2022-09-10', -1025564911);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483611, -2147483648, 'pay_6faa20', '2023-01-22', 2056419640);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483610, -2147483648, 'pay_6faa20', '2022-12-15', 537874887);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483609, -2147483648, 'pay_02cc31', '2024-08-06', 836513442);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483608, -2147483648, 'pay_02cc31', '2020-11-04', 1196308825);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483607, -2147483648, 'pay_02cc31', '2025-01-26', 1675430660);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483606, -2147483648, 'pay_6faa20', '2024-05-17', -792092619);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483605, -2147483648, 'pay_6faa20', '2025-05-18', -1612443122);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483604, -2147483648, 'pay_6faa20', '2020-07-26', -736979194);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483603, -2147483648, 'pay_02cc31', '2021-04-26', -261132974);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483602, -2147483648, 'pay_02cc31', '2020-08-28', -1052964641);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483601, -2147483648, 'pay_02cc31', '2022-10-24', -1660358170);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483600, -2147483648, 'pay_6faa20', '2022-09-19', -988981234);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483599, -2147483648, 'pay_6faa20', '2023-07-15', -361507387);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483598, -2147483648, 'pay_6faa20', '2025-11-06', 401805964);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483597, -2147483648, 'pay_02cc31', '2021-01-21', -1255130038);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483596, -2147483648, 'pay_02cc31', '2025-02-11', 806170397);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483595, -2147483648, 'pay_02cc31', '2023-10-23', -1454058168);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483594, -2147483648, 'pay_6faa20', '2020-03-07', -1554531873);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483593, -2147483648, 'pay_6faa20', '2023-02-18', 1038566008);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483592, -2147483648, 'pay_6faa20', '2025-09-09', -688098735);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483591, -2147483648, 'pay_02cc31', '2025-09-14', -1672720816);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483590, -2147483648, 'pay_02cc31', '2025-12-20', -1520489792);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483589, -2147483648, 'pay_02cc31', '2023-12-09', -1388029300);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483588, -2147483648, 'pay_6faa20', '2020-03-27', 602161869);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483587, -2147483648, 'pay_6faa20', '2024-03-11', -961217731);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483586, -2147483648, 'pay_6faa20', '2020-09-03', 564390026);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483585, -2147483648, 'pay_02cc31', '2021-06-18', 2011234363);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483584, -2147483648, 'pay_02cc31', '2020-01-31', -7597509);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483583, -2147483648, 'pay_02cc31', '2025-06-24', -1738458256);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483582, -2147483648, 'pay_6faa20', '2021-09-30', -458359144);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483581, -2147483648, 'pay_6faa20', '2020-02-11', -1794176801);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483580, -2147483648, 'pay_6faa20', '2021-03-06', -946046410);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483579, -2147483648, 'pay_02cc31', '2023-04-01', -1478134144);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483578, -2147483648, 'pay_02cc31', '2024-04-27', -598313376);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483577, -2147483648, 'pay_02cc31', '2022-11-12', 804529642);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483576, -2147483648, 'pay_6faa20', '2024-08-06', 1923912467);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483575, -2147483648, 'pay_6faa20', '2021-05-19', -163600466);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483574, -2147483648, 'pay_6faa20', '2022-06-06', 357330522);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483573, -2147483648, 'pay_02cc31', '2023-10-28', 1732258051);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483572, -2147483648, 'pay_02cc31', '2021-01-02', -47052816);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483571, -2147483648, 'pay_02cc31', '2022-06-30', 76996700);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483570, -2147483648, 'pay_6faa20', '2022-07-09', 1992637800);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483569, -2147483648, 'pay_6faa20', '2020-07-27', 481546706);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483568, -2147483648, 'pay_6faa20', '2021-02-23', -242584410);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483567, -2147483648, 'pay_02cc31', '2023-10-13', 820970595);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483566, -2147483648, 'pay_02cc31', '2020-08-09', 569007824);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483565, -2147483648, 'pay_02cc31', '2020-10-02', -288338724);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483564, -2147483648, 'pay_6faa20', '2024-12-22', 199672698);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483563, -2147483648, 'pay_6faa20', '2025-11-04', 2004147439);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483562, -2147483648, 'pay_6faa20', '2023-05-06', -1523347137);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483561, -2147483648, 'pay_02cc31', '2023-05-24', 1467355421);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483560, -2147483648, 'pay_02cc31', '2022-07-20', 944975670);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483559, -2147483648, 'pay_02cc31', '2021-06-29', 1944978593);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483558, -2147483648, 'pay_6faa20', '2020-03-12', -1776877925);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483557, -2147483648, 'pay_6faa20', '2022-07-17', -1950324754);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483556, -2147483648, 'pay_6faa20', '2025-10-22', -406331049);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483555, -2147483648, 'pay_02cc31', '2020-09-19', -468701684);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483554, -2147483648, 'pay_02cc31', '2025-11-13', 304189298);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483553, -2147483648, 'pay_02cc31', '2024-03-10', -57705450);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483552, -2147483648, 'pay_6faa20', '2024-03-06', -2005628382);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483551, -2147483648, 'pay_6faa20', '2024-08-05', 1269522000);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483550, -2147483648, 'pay_6faa20', '2023-05-02', -1935752926);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483549, -2147483648, 'pay_02cc31', '2025-07-21', -1609653472);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483548, -2147483648, 'pay_02cc31', '2022-12-17', 1816660482);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483547, -2147483648, 'pay_02cc31', '2022-06-10', -1556979799);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483546, -2147483648, 'pay_6faa20', '2021-11-16', 1379859112);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483545, -2147483648, 'pay_6faa20', '2023-03-22', 1615073310);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483544, -2147483648, 'pay_6faa20', '2025-01-27', 1497321728);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483543, -2147483648, 'pay_02cc31', '2021-02-12', -244633520);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483542, -2147483648, 'pay_02cc31', '2020-01-11', -1524425594);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483541, -2147483648, 'pay_02cc31', '2020-02-18', 1919033056);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483540, -2147483648, 'pay_6faa20', '2023-10-18', -761353513);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483539, -2147483648, 'pay_6faa20', '2022-03-08', 1553368934);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483538, -2147483648, 'pay_6faa20', '2020-11-10', 1908593332);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483537, -2147483648, 'pay_02cc31', '2023-10-17', -526633767);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483536, -2147483648, 'pay_02cc31', '2024-05-20', -2052653308);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483535, -2147483648, 'pay_02cc31', '2023-10-06', -72442907);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_method_code_other AS payment_method_code FROM (SELECT LHS.payment_method_code AS payment_method_code, LHS.n AS n, LHS.maxn AS maxn, RHS.payment_method_code AS payment_method_code_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT payment_method_code, n, MAX(n) OVER () AS maxn FROM (SELECT payment_method_code, COUNT(*) AS n FROM payments GROUP BY payment_method_code)) AS LHS CROSS JOIN (SELECT payment_method_code, n, MAX(n) OVER () AS maxn FROM (SELECT payment_method_code, COUNT(*) AS n FROM payments GROUP BY payment_method_code)) AS RHS) WHERE (n < maxn_other AND maxn <= n_other) ORDER BY payment_method_code;

/*
Gold Result:
('pay_02cc31',)
('pay_6faa20',)
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) DESC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('pay_02cc31',)
*/