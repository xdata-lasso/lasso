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
INSERT INTO REF_TEMPLATE_TYPES VALUES (-4, 0);
INSERT INTO REF_TEMPLATE_TYPES VALUES (-3, 0);
INSERT INTO TEMPLATES VALUES (1, -4, 0, 13, 14, 15);
INSERT INTO TEMPLATES VALUES (0, -3, 1, 9, 10, 11);
INSERT INTO DOCUMENTS VALUES (0, 0, 0, 0, 0);
INSERT INTO DOCUMENTS VALUES (-1, 0, 0, 0, 0);
INSERT INTO PARAGRAPHS VALUES (0, -1, 0, 0);
INSERT INTO PARAGRAPHS VALUES (1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT template_type_code, COUNT(*) AS n FROM templates GROUP BY template_type_code) AS RHS ON (LHS.version_number = RHS.n AND LHS.template_type_code = RHS.template_type_code)) ORDER BY template_type_code;

/*
Gold Result:
('-3',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates GROUP BY template_type_code ORDER BY COUNT(*) DESC, template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('-3',)
*/