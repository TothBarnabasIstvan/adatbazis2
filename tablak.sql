CREATE TABLE users(
ID NUMBER NOT NULL PRIMARY KEY,
name VARCHAR2(40) NOT NULL,
email VARCHAR2(40) NOT NULL,
role VARCHAR2(20) NOT NULL,
permission VARCHAR2(30) NOT NULL
);

select * from users;

CREATE TABLE image(
ID NUMBER NOT NULL PRIMARY KEY,
upload_date DATE DEFAULT SYSDATE NOT NULL,
processing_status VARCHAR2(20) NOT NULL
);

select * from image;

CREATE TABLE segmentation_data(
ID NUMBER NOT NULL PRIMARY KEY,
image_id NUMBER NOT NULL,
number_of_segmented_cells NUMBER DEFAULT 0,
segment_type VARCHAR2(30) NOT NULL,
created_date DATE DEFAULT SYSDATE NOT NULL
);

select * from segmentation_data;

CREATE TABLE feedback(
ID NUMBER NOT NULL PRIMARY KEY,
user_id NUMBER NOT NULL,
image_id NUMBER NOT NULL,
feedback_text VARCHAR2(200) NOT NULL,
created_date DATE
);

select * from feedback;


CREATE TABLE exported_data(
ID NUMBER NOT NULL PRIMARY KEY,
user_id NUMBER NOT NULL,
export_format VARCHAR2(30) NOT NULL,
created_date DATE DEFAULT SYSDATE NOT NULL
);

select * from exported_data;

ALTER TABLE segmentation_data ADD CONSTRAINT image_id_fk FOREIGN KEY (image_id) REFERENCES image(ID);
ALTER TABLE feedback ADD CONSTRAINT user_id_fk FOREIGN KEY (user_id) REFERENCES users(ID);
ALTER TABLE feedback ADD CONSTRAINT fk_image_id FOREIGN KEY (image_id) REFERENCES image(ID);
ALTER TABLE exported_data ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(ID);

--Táblák feltöltése
INSERT INTO users (ID, name, email, role, permission) VALUES (1, 'Anna Kovács', 'anna.kovacs@example.com', 'kutató', 'read');
INSERT INTO users (ID, name, email, role, permission) VALUES (2, 'Péter Szabó', 'peter.szabo@example.com', 'kutató', 'read');
INSERT INTO users (ID, name, email, role, permission) VALUES (3, 'Mária Nagy', 'maria.nagy@example.com', 'admin', 'read,write,delete');
INSERT INTO users (ID, name, email, role, permission) VALUES (4, 'Gábor Tóth', 'gabor.toth@example.com', 'kutató', 'read');
INSERT INTO users (ID, name, email, role, permission) VALUES (5, 'János Kiss', 'janos.kiss@example.com', 'admin', 'read,write');
INSERT INTO users (ID, name, email, role, permission) VALUES (6, 'Éva Horváth', 'eva.horvath@example.com', 'kutató', 'read');
INSERT INTO users (ID, name, email, role, permission) VALUES (7, 'László Molnár', 'laszlo.molnar@example.com', 'kutató', 'read,write');


INSERT INTO image (ID, upload_date, processing_status) VALUES (1, TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'feldolgozatlan');
INSERT INTO image (ID, upload_date, processing_status) VALUES (2, TO_DATE('2024-11-02', 'YYYY-MM-DD'), 'feldolgozatlan');
INSERT INTO image (ID, upload_date, processing_status) VALUES (3, TO_DATE('2024-11-03', 'YYYY-MM-DD'), 'feldolgozott');
INSERT INTO image (ID, upload_date, processing_status) VALUES (4, TO_DATE('2024-11-04', 'YYYY-MM-DD'), 'feldolgozatlan');
INSERT INTO image (ID, upload_date, processing_status) VALUES (5, TO_DATE('2024-11-05', 'YYYY-MM-DD'), 'feldolgozott');
INSERT INTO image (ID, upload_date, processing_status) VALUES (6, TO_DATE('2024-11-06', 'YYYY-MM-DD'), 'feldolgozatlan');
INSERT INTO image (ID, upload_date, processing_status) VALUES (7, TO_DATE('2024-11-07', 'YYYY-MM-DD'), 'feldolgozott');


INSERT INTO segmentation_data (ID, image_id, number_of_segmented_cells, segment_type, created_date) VALUES (1, 1, 25, 'sejthártya', TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO segmentation_data (ID, image_id, number_of_segmented_cells, segment_type, created_date) VALUES (2, 2, 30, 'sejthártya', TO_DATE('2024-11-02', 'YYYY-MM-DD'));
INSERT INTO segmentation_data (ID, image_id, number_of_segmented_cells, segment_type, created_date) VALUES (3, 3, 0, 'sejttest', TO_DATE('2024-11-03', 'YYYY-MM-DD'));
INSERT INTO segmentation_data (ID, image_id, number_of_segmented_cells, segment_type, created_date) VALUES (4, 4, 15, 'sejttest', TO_DATE('2024-11-04', 'YYYY-MM-DD'));
INSERT INTO segmentation_data (ID, image_id, number_of_segmented_cells, segment_type, created_date) VALUES (5, 5, 50, 'sejthártya', TO_DATE('2024-11-05', 'YYYY-MM-DD'));
INSERT INTO segmentation_data (ID, image_id, number_of_segmented_cells, segment_type, created_date) VALUES (6, 6, 0, 'sejttest', TO_DATE('2024-11-06', 'YYYY-MM-DD'));
INSERT INTO segmentation_data (ID, image_id, number_of_segmented_cells, segment_type, created_date) VALUES (7, 7, 40, 'sejthártya', TO_DATE('2024-11-07', 'YYYY-MM-DD'));


INSERT INTO feedback (ID, user_id, image_id, feedback_text, created_date) VALUES (1, 1, 1, 'Nagyon jó minõségû kép, a szegmentációk pontosak.', TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO feedback (ID, user_id, image_id, feedback_text, created_date) VALUES (2, 2, 2, 'A képen látható sejtek jól elkülöníthetõk, de az egyes szegmensek határai kicsit elmosódottak.', TO_DATE('2024-11-02', 'YYYY-MM-DD'));
INSERT INTO feedback (ID, user_id, image_id, feedback_text, created_date) VALUES (3, 3, 3, 'A szegmentációs eredményeket nem tartom eléggé pontosnak, szükséges javítás.', TO_DATE('2024-11-03', 'YYYY-MM-DD'));
INSERT INTO feedback (ID, user_id, image_id, feedback_text, created_date) VALUES (4, 4, 4, 'A sejthártya szegmentációja rendben van, de a sejttestek nem jól lettek meghatározva.', TO_DATE('2024-11-04', 'YYYY-MM-DD'));
INSERT INTO feedback (ID, user_id, image_id, feedback_text, created_date) VALUES (5, 5, 5, 'Kiváló eredmény, a szegmentációk és a sejtípusok jól vannak elkülönítve.', TO_DATE('2024-11-05', 'YYYY-MM-DD'));
INSERT INTO feedback (ID, user_id, image_id, feedback_text, created_date) VALUES (6, 6, 6, 'A képek felbontása nem elégséges a szegmentáláshoz, a sejtek nehezen felismerhetõk.', TO_DATE('2024-11-06', 'YYYY-MM-DD'));
INSERT INTO feedback (ID, user_id, image_id, feedback_text, created_date) VALUES (7, 7, 7, 'A szegmentációk elfogadhatók, de lehetne még javítani a sejtüreg és a sejthártya közötti határokon.', TO_DATE('2024-11-07', 'YYYY-MM-DD'));

INSERT INTO exported_data (ID, user_id, export_format, created_date) VALUES (1, 1, 'CSV', TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO exported_data (ID, user_id, export_format, created_date) VALUES (2, 2, 'CSV', TO_DATE('2024-11-02', 'YYYY-MM-DD'));
INSERT INTO exported_data (ID, user_id, export_format, created_date) VALUES (3, 3, 'szegmentált kép', TO_DATE('2024-11-03', 'YYYY-MM-DD'));
INSERT INTO exported_data (ID, user_id, export_format, created_date) VALUES (4, 4, 'CSV', TO_DATE('2024-11-04', 'YYYY-MM-DD'));
INSERT INTO exported_data (ID, user_id, export_format, created_date) VALUES (5, 5, 'szegmentált kép', TO_DATE('2024-11-05', 'YYYY-MM-DD'));
INSERT INTO exported_data (ID, user_id, export_format, created_date) VALUES (6, 6, 'CSV', TO_DATE('2024-11-06', 'YYYY-MM-DD'));
INSERT INTO exported_data (ID, user_id, export_format, created_date) VALUES (7, 7, 'szegmentált kép', TO_DATE('2024-11-07', 'YYYY-MM-DD'));



alter table users add mod_user varchar2(300);
alter table users add created_on timestamp;
alter table users add last_mod timestamp;
alter table users add DML_FLAG varchar2(1);
alter table users add VERSION number;

alter table image add mod_user varchar2(300);
alter table image add created_on timestamp;
alter table image add last_mod timestamp;
alter table image add DML_FLAG varchar2(1);
alter table image add VERSION number;

alter table segmentation_data add mod_user varchar2(300);
alter table segmentation_data add created_on timestamp;
alter table segmentation_data add last_mod timestamp;
alter table segmentation_data add DML_FLAG varchar2(1);
alter table segmentation_data add VERSION number;

alter table feedback add mod_user varchar2(300);
alter table feedback add created_on timestamp;
alter table feedback add last_mod timestamp;
alter table feedback add DML_FLAG varchar2(1);
alter table feedback add VERSION number;

alter table exported_data add mod_user varchar2(300);
alter table exported_data add created_on timestamp;
alter table exported_data add last_mod timestamp;
alter table exported_data add DML_FLAG varchar2(1);
alter table exported_data add VERSION number;


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
