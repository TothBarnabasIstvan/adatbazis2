CREATE TABLE users(
ID NUMBER NOT NULL PRIMARY KEY,
name VARCHAR2(40) NOT NULL,
email VARCHAR2(40) NOT NULL,
role VARCHAR2(20) NOT NULL,
permission VARCHAR2(30) NOT NULL,
mod_user varchar2(300),
created_on timestamp,
last_mod timestamp,
DML_FLAG varchar2(1),
VERSION number
);

select * from users;

CREATE TABLE image(
ID NUMBER NOT NULL PRIMARY KEY,
upload_date DATE DEFAULT SYSDATE NOT NULL,
processing_status VARCHAR2(20) NOT NULL,
mod_user varchar2(300),
created_on timestamp,
last_mod timestamp,
DML_FLAG varchar2(1),
VERSION number
);

select * from image;

CREATE TABLE segmentation_data(
ID NUMBER NOT NULL PRIMARY KEY,
image_id NUMBER NOT NULL,
number_of_segmented_cells NUMBER DEFAULT 0,
segment_type VARCHAR2(30) NOT NULL,
created_date DATE DEFAULT SYSDATE NOT NULL,
mod_user varchar2(300),
created_on timestamp,
last_mod timestamp,
DML_FLAG varchar2(1),
VERSION number
);

select * from segmentation_data;

CREATE TABLE feedback(
ID NUMBER NOT NULL PRIMARY KEY,
user_id NUMBER NOT NULL,
image_id NUMBER NOT NULL,
feedback_text VARCHAR2(200) NOT NULL,
created_date DATE,
mod_user varchar2(300),
created_on timestamp,
last_mod timestamp,
DML_FLAG varchar2(1),
VERSION number
);

select * from feedback;


CREATE TABLE exported_data(
ID NUMBER NOT NULL PRIMARY KEY,
user_id NUMBER NOT NULL,
export_format VARCHAR2(30) NOT NULL,
created_date DATE DEFAULT SYSDATE NOT NULL,
mod_user varchar2(300),
created_on timestamp,
last_mod timestamp,
DML_FLAG varchar2(1),
VERSION number
);

select * from exported_data;

ALTER TABLE segmentation_data ADD CONSTRAINT image_id_fk FOREIGN KEY (image_id) REFERENCES image(ID);
ALTER TABLE feedback ADD CONSTRAINT user_id_fk FOREIGN KEY (user_id) REFERENCES users(ID);
ALTER TABLE feedback ADD CONSTRAINT fk_image_id FOREIGN KEY (image_id) REFERENCES image(ID);
ALTER TABLE exported_data ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(ID);


-- histroy táblák
CREATE TABLE user_h(
id NUMBER,
name VARCHAR2(40),
email VARCHAR2(40),
role VARCHAR2(20),
permission VARCHAR2(30),
mod_user      varchar2(300),
created_on    timestamp(6),
last_mod      timestamp(6),
dml_flag	    varchar2(1),
version	      number
);

select * from user_h;

CREATE TABLE image_h(
id NUMBER,
upload_date DATE,
processing_status VARCHAR2(20),
mod_user      varchar2(300),
created_on    timestamp(6),
last_mod      timestamp(6),
dml_flag	    varchar2(1),
version	      number
);

select * from image_h;

CREATE TABLE segmentation_data_h(
id NUMBER,
image_id number,
number_of_segmented_cells NUMBER,
segment_type VARCHAR2(30),
created_date DATE,
mod_user      varchar2(300),
created_on    timestamp(6),
last_mod      timestamp(6),
dml_flag	    varchar2(1),
version	      number
);

select * from segmentation_data_h;


CREATE TABLE feedback_h(
ID NUMBER,
user_id NUMBER,
image_id NUMBER,
feedback_text VARCHAR2(200),
created_date DATE,
mod_user      varchar2(300),
created_on    timestamp(6),
last_mod      timestamp(6),
dml_flag	    varchar2(1),
version	      number
);

select * from feedback_h;


CREATE TABLE exported_data_h(
ID NUMBER,
user_id NUMBER,
export_format VARCHAR2(30),
created_date DATE,
mod_user      varchar2(300),
created_on    timestamp(6),
last_mod      timestamp(6),
dml_flag	    varchar2(1),
version	      number
);

select * from exported_data_h;

--Táblák feltöltése
INSERT INTO users (name, email, role, permission) VALUES ('Anna Kovács', 'anna.kovacs@example.com', 'kutató', 'read');
INSERT INTO users (name, email, role, permission) VALUES ('Péter Szabó', 'peter.szabo@example.com', 'kutató', 'read');
INSERT INTO users (name, email, role, permission) VALUES ('Mária Nagy', 'maria.nagy@example.com', 'admin', 'read,write,delete');
INSERT INTO users (name, email, role, permission) VALUES ('Gábor Tóth', 'gabor.toth@example.com', 'kutató', 'read');
INSERT INTO users (name, email, role, permission) VALUES ('János Kiss', 'janos.kiss@example.com', 'admin', 'read,write');
INSERT INTO users (name, email, role, permission) VALUES ('Éva Horváth', 'eva.horvath@example.com', 'kutató', 'read');
INSERT INTO users (name, email, role, permission) VALUES ('László Molnár', 'laszlo.molnar@example.com', 'kutató', 'read,write');


INSERT INTO image (upload_date, processing_status) VALUES (TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'feldolgozatlan');
INSERT INTO image (upload_date, processing_status) VALUES (TO_DATE('2024-11-02', 'YYYY-MM-DD'), 'feldolgozatlan');
INSERT INTO image (upload_date, processing_status) VALUES (TO_DATE('2024-11-03', 'YYYY-MM-DD'), 'feldolgozott');
INSERT INTO image (upload_date, processing_status) VALUES (TO_DATE('2024-11-04', 'YYYY-MM-DD'), 'feldolgozatlan');
INSERT INTO image (upload_date, processing_status) VALUES (TO_DATE('2024-11-05', 'YYYY-MM-DD'), 'feldolgozott');
INSERT INTO image (upload_date, processing_status) VALUES (TO_DATE('2024-11-06', 'YYYY-MM-DD'), 'feldolgozatlan');
INSERT INTO image (upload_date, processing_status) VALUES (TO_DATE('2024-11-07', 'YYYY-MM-DD'), 'feldolgozott');

-- segmentation_data feltöltése
BEGIN
  FOR rec IN (SELECT ID FROM image ORDER BY ID) LOOP
    INSERT INTO segmentation_data (image_id, number_of_segmented_cells, segment_type, created_date)
    VALUES (rec.ID, TRUNC(DBMS_RANDOM.VALUE(10, 100)), 'Type ' || CHR(65 + MOD(rec.ID, 3)), SYSDATE - rec.ID * 10);
  END LOOP;
END;


-- feedback feltöltése
BEGIN
  FOR rec IN (SELECT ID FROM image ORDER BY ID) LOOP
    FOR user_rec IN (SELECT ID FROM users ORDER BY DBMS_RANDOM.VALUE) LOOP
      INSERT INTO feedback (user_id, image_id, feedback_text, created_date)
      VALUES (
        user_rec.ID,                        
        rec.ID,                              
        'Feedback for image ' || rec.ID,      
        SYSDATE - rec.ID * 5                 
      );
      EXIT; 
    END LOOP;
  END LOOP;
END;


-- exported_data feltöltése
BEGIN
  FOR rec IN (SELECT ID FROM users ORDER BY ID) LOOP
    INSERT INTO exported_data (user_id, export_format, created_date)
    VALUES (
      rec.ID,                               
      CASE 
        WHEN MOD(rec.ID, 3) = 0 THEN 'CSV'  
        WHEN MOD(rec.ID, 3) = 1 THEN 'JSON'
        ELSE 'XML'
      END,
      SYSDATE - rec.ID * 7                  
    );
  END LOOP;
END;


--Típus létrehozása
CREATE OR REPLACE TYPE image_data_type AS OBJECT (
  image_id NUMBER,
  segmented_cell_count NUMBER,
  processing_status VARCHAR2(20),
  segment_type VARCHAR2(50) 
  );

CREATE OR REPLACE TYPE image_data_type_l IS TABLE OF image_data_type;


