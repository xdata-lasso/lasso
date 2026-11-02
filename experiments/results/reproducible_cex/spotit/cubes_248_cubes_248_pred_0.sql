-- Schema DDL
CREATE TABLE "REF_TEMPLATE_TYPES" (
    "TEMPLATE_TYPE_CODE" TEXT,
    "TEMPLATE_TYPE_DESCRIPTION" TEXT,
    PRIMARY KEY ("TEMPLATE_TYPE_CODE")
);
CREATE TABLE "TEMPLATES" (
    "TEMPLATE_ID" INT,
    "TEMPLATE_TYPE_CODE" TEXT,
    "VERSION_NUMBER" INT,
    "DATE_EFFECTIVE_FROM" DATETIME,
    "DATE_EFFECTIVE_TO" DATETIME,
    "TEMPLATE_DETAILS" TEXT,
    PRIMARY KEY ("TEMPLATE_ID"),
    FOREIGN KEY ("TEMPLATE_TYPE_CODE") REFERENCES "REF_TEMPLATE_TYPES"("TEMPLATE_TYPE_CODE")
);
CREATE TABLE "DOCUMENTS" (
    "DOCUMENT_ID" INT,
    "TEMPLATE_ID" INT,
    "DOCUMENT_NAME" TEXT,
    "DOCUMENT_DESCRIPTION" TEXT,
    "OTHER_DETAILS" TEXT,
    PRIMARY KEY ("DOCUMENT_ID"),
    FOREIGN KEY ("TEMPLATE_ID") REFERENCES "TEMPLATES"("TEMPLATE_ID")
);
CREATE TABLE "PARAGRAPHS" (
    "PARAGRAPH_ID" INT,
    "DOCUMENT_ID" INT,
    "PARAGRAPH_TEXT" TEXT,
    "OTHER_DETAILS" TEXT,
    PRIMARY KEY ("PARAGRAPH_ID"),
    FOREIGN KEY ("DOCUMENT_ID") REFERENCES "DOCUMENTS"("DOCUMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO REF_TEMPLATE_TYPES VALUES (-1, 0);
INSERT INTO REF_TEMPLATE_TYPES VALUES (0, 0);
INSERT INTO TEMPLATES VALUES (2, 0, 0, NULL, 43, 44);
INSERT INTO TEMPLATES VALUES (1, -1, 0, 45, 46, 47);
INSERT INTO DOCUMENTS VALUES (1, 1, 15, 16, 17);
INSERT INTO DOCUMENTS VALUES (0, 2, 18, 19, 20);
INSERT INTO PARAGRAPHS VALUES (1, 1, 0, 0);
INSERT INTO PARAGRAPHS VALUES (0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.n AS n, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM (SELECT template_id, version_number, template_type_code, date_effective_from, date_effective_to, template_details, template_id AS n FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM templates) AS RHS ON (LHS.template_id = RHS.n))) AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) ORDER BY template_type_code;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id GROUP BY T1.template_type_code ORDER BY COUNT(*) DESC, T1.template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/