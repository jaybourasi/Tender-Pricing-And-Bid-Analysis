-- Create a backup table
CREATE TABLE tenders_backup AS TABLE tenders;

-- Convert columns to desired data types and clean data
ALTER TABLE tenders
    ALTER COLUMN Basic_Amount TYPE NUMERIC(10, 2) USING REPLACE(basic_amount, ',', '')::numeric(10, 2),
    ALTER COLUMN Quantity TYPE INT USING REPLACE(quantity, ',', '')::integer,
    ALTER COLUMN Tender_no TYPE INT USING REPLACE(tender_no, ',', '')::integer,
    ALTER COLUMN Comp_A TYPE NUMERIC(10, 2) USING REPLACE(comp_a, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_B TYPE NUMERIC(10, 2) USING REPLACE(comp_b, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_C TYPE NUMERIC(10, 2) USING REPLACE(comp_c, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_D TYPE NUMERIC(10, 2) USING REPLACE(comp_d, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_E TYPE NUMERIC(10, 2) USING REPLACE(comp_e, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_F TYPE NUMERIC(10, 2) USING REPLACE(comp_f, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_G TYPE NUMERIC(10, 2) USING REPLACE(comp_g, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_H TYPE NUMERIC(10, 2) USING REPLACE(comp_h, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_I TYPE NUMERIC(10, 2) USING REPLACE(comp_i, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_J TYPE NUMERIC(10, 2) USING REPLACE(comp_j, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_K TYPE NUMERIC(10, 2) USING REPLACE(comp_k, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_L TYPE NUMERIC(10, 2) USING REPLACE(comp_l, ',', '')::numeric(10, 2);

-- Split parts of competitors' columns and update them
UPDATE tenders
SET Comp_A = split_part(comp_a, ' ', 1),
    Comp_B = split_part(comp_b, ' ', 1),
    Comp_C = split_part(comp_c, ' ', 1),
    Comp_D = split_part(comp_d, ' ', 1),
    Comp_E = split_part(comp_e, ' ', 1),
    Comp_F = split_part(comp_f, ' ', 1),
    Comp_G = split_part(comp_g, ' ', 1),
    Comp_H = split_part(comp_h, ' ', 1),
    Comp_I = split_part(comp_i, ' ', 1),
    Comp_J = split_part(comp_j, ' ', 1),
    Comp_K = split_part(comp_k, ' ', 1),
    Comp_L = split_part(comp_l, ' ', 1);

-- Convert the split parts to numeric data type
ALTER TABLE tenders
    ALTER COLUMN Comp_A TYPE NUMERIC(10, 2) USING REPLACE(comp_a, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_B TYPE NUMERIC(10, 2) USING REPLACE(comp_b, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_C TYPE NUMERIC(10, 2) USING REPLACE(comp_c, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_D TYPE NUMERIC(10, 2) USING REPLACE(comp_d, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_E TYPE NUMERIC(10, 2) USING REPLACE(comp_e, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_F TYPE NUMERIC(10, 2) USING REPLACE(comp_f, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_G TYPE NUMERIC(10, 2) USING REPLACE(comp_g, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_H TYPE NUMERIC(10, 2) USING REPLACE(comp_h, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_I TYPE NUMERIC(10, 2) USING REPLACE(comp_i, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_J TYPE NUMERIC(10, 2) USING REPLACE(comp_j, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_K TYPE NUMERIC(10, 2) USING REPLACE(comp_k, ',', '')::numeric(10, 2),
    ALTER COLUMN Comp_L TYPE NUMERIC(10, 2) USING REPLACE(comp_l, ',', '')::numeric(10, 2);

-- Convert Opening_Date to proper date format
UPDATE tenders
SET Opening_Date = TO_DATE(Opening_Date, 'YYYY.MM.DD')
WHERE Opening_Date ~ '^\d{4}\.\d{2}\.\d{2}$';

UPDATE tenders
SET Opening_Date = TO_DATE(Opening_Date, 'DD.MM.YYYY')
WHERE Opening_Date ~ '^\d{2}\.\d{2}\.\d{4}$';

ALTER TABLE tenders
ALTER COLUMN Opening_Date TYPE DATE USING TO_DATE(Opening_Date, 'DD.MM.YYYY');

-- Normalize string columns to uppercase
UPDATE tenders
SET railway_name = UPPER(railway_name),
    tender_nature = INITCAP(tender_nature),
    awarded_to = INITCAP(awarded_to),
    material_type = INITCAP(material_type);

-- Rename column if needed
ALTER TABLE tenders RENAME COLUMN tender_no TO tender_number;

-- Final select statements for verification
SELECT * FROM tenders;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'tenders';

SELECT * 
FROM tenders 
WHERE L1_Price IS NULL OR Quantity IS NULL OR Opening_Date IS NULL;

SELECT * FROM tenders_backup;
