CREATE OR REPLACE TRIGGER set_feedback_date
BEFORE INSERT ON feedback 
for each row
  begin 
    if :new.created_date IS NULL
      then 
        :new.created_date := sysdate;
      end if;
  end;
  
-------------------------------------------------------------  
CREATE OR REPLACE TRIGGER update_image_status
AFTER INSERT ON segmentation_data
for each row
  BEGIN
  UPDATE image
  SET processing_status = 'feldolgozott'
  WHERE ID = :new.image_id;
END;

--------------------------------------------------------------------

CREATE OR REPLACE TRIGGER user_trg
  BEFORE INSERT OR UPDATE ON users
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := user_id_seq.nextval;
    END IF;
  
    :new.created_on := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
  ELSE
    IF nvl(:new.dml_flag, 'U') <> 'D'
    THEN
      :new.dml_flag := 'U';
    END IF;
  
    :new.version := :old.version + 1;
  END IF;

  :new.last_mod := SYSDATE;
  :new.mod_user := sys_context('USERENV', 'OS_USER');
END;

----------------------------------------------------------------
CREATE OR REPLACE TRIGGER user_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON users
  FOR EACH ROW
DECLARE
  v_mod_user user_h.mod_user%TYPE;
  v_mod_time user_h.last_mod%TYPE;
BEGIN
  v_mod_user := sys_context('USERENV', 'OS_USER');
  v_mod_time := SYSDATE;

  IF deleting
  THEN
    INSERT INTO user_h
      (id
      ,name
      ,email
      ,role
      ,permission
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.id
      ,:old.name
      ,:old.email
      ,:old.role
      ,:old.permission
      ,v_mod_user
      ,:old.created_on
      ,v_mod_time
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO user_h
      (id
      ,name
      ,email
      ,role
      ,permission
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.id
      ,:new.name
      ,:new.email
      ,:new.role
      ,:new.permission
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
---------------------------------------------------------------------

CREATE OR REPLACE TRIGGER image_trg
  BEFORE INSERT OR UPDATE ON image
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := image_id_seq.nextval;
    END IF;
  
    :new.created_on := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
  ELSE
    IF nvl(:new.dml_flag, 'U') <> 'D'
    THEN
      :new.dml_flag := 'U';
    END IF;
  
    :new.version := :old.version + 1;
  END IF;

  :new.last_mod := SYSDATE;
  :new.mod_user := sys_context('USERENV', 'OS_USER');
END;
---------------------------------------------------------------------

CREATE OR REPLACE TRIGGER image_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON image
  FOR EACH ROW
DECLARE
  v_mod_user image_h.mod_user%TYPE;
  v_mod_time image_h.last_mod%TYPE;
BEGIN
  v_mod_user := sys_context('USERENV', 'OS_USER');
  v_mod_time := SYSDATE;

  IF deleting
  THEN
    INSERT INTO image_h
      (id
      ,upload_date
      ,processing_status
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.id
      ,:old.upload_date
      ,:old.processing_status
      ,v_mod_user
      ,:old.created_on
      ,v_mod_time
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO image_h
      (id
      ,upload_date
      ,processing_status
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.id
      ,:new.upload_date
      ,:new.processing_status
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
------------------------------------------------------

CREATE OR REPLACE TRIGGER segmentation_data_trg
  BEFORE INSERT OR UPDATE ON segmentation_data
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := segmentation_data_id_seq.nextval;
    END IF;
  
    :new.created_on := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
  ELSE
    IF nvl(:new.dml_flag, 'U') <> 'D'
    THEN
      :new.dml_flag := 'U';
    END IF;
  
    :new.version := :old.version + 1;
  END IF;

  :new.last_mod := SYSDATE;
  :new.mod_user := sys_context('USERENV', 'OS_USER');
END;
--------------------------------------------------------------

CREATE OR REPLACE TRIGGER segmentation_data_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON segmentation_data
  FOR EACH ROW
DECLARE
  v_mod_user segmentation_data_h.mod_user%TYPE;
  v_mod_time segmentation_data.last_mod%TYPE;
BEGIN
  v_mod_user := sys_context('USERENV', 'OS_USER');
  v_mod_time := SYSDATE;

  IF deleting
  THEN
    INSERT INTO segmentation_data_h
      (id
      ,image_id
      ,number_of_segmented_cells
      ,segment_type
      ,created_date
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.id
      ,:old.image_id
      ,:old.number_of_segmented_cells
      ,:old.segment_type
      ,:old.created_date
      ,v_mod_user
      ,:old.created_on
      ,v_mod_time
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO segmentation_data_h
      (id
      ,image_id
      ,number_of_segmented_cells
      ,segment_type
      ,created_date
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.id
      ,:new.image_id
      ,:new.number_of_segmented_cells
      ,:new.segment_type
      ,:new.created_date
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
-----------------------------------------------------

CREATE OR REPLACE TRIGGER feedback_trg
  BEFORE INSERT OR UPDATE ON feedback
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := feedback_id_seq.nextval;
    END IF;
  
    :new.created_on := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
  ELSE
    IF nvl(:new.dml_flag, 'U') <> 'D'
    THEN
      :new.dml_flag := 'U';
    END IF;
  
    :new.version := :old.version + 1;
  END IF;

  :new.last_mod := SYSDATE;
  :new.mod_user := sys_context('USERENV', 'OS_USER');
END;
--------------------------------------------------------

CREATE OR REPLACE TRIGGER feedback_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON feedback
  FOR EACH ROW
DECLARE
  v_mod_user feedback_h.mod_user%TYPE;
  v_mod_time feedback_h.last_mod%TYPE;
BEGIN
  v_mod_user := sys_context('USERENV', 'OS_USER');
  v_mod_time := SYSDATE;

  IF deleting
  THEN
    INSERT INTO feedback_h
      (id
      ,user_id
      ,image_id
      ,feedback_text
      ,created_date
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.id
      ,:old.user_id
      ,:old.image_id
      ,:old.feedback_text
      ,:old.created_date
      ,v_mod_user
      ,:old.created_on
      ,v_mod_time
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO feedback_h
      (id
      ,user_id
      ,image_id
      ,feedback_text
      ,created_date
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.id
      ,:new.user_id
      ,:new.image_id
      ,:new.feedback_text
      ,:new.created_date
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
--------------------------------------------------------

CREATE OR REPLACE TRIGGER exported_data_trg
  BEFORE INSERT OR UPDATE ON exported_data
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := export_id_seq.nextval;
    END IF;
  
    :new.created_on := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
  ELSE
    IF nvl(:new.dml_flag, 'U') <> 'D'
    THEN
      :new.dml_flag := 'U';
    END IF;
  
    :new.version := :old.version + 1;
  END IF;

  :new.last_mod := SYSDATE;
  :new.mod_user := sys_context('USERENV', 'OS_USER');
END;
------------------------------------------------------------

CREATE OR REPLACE TRIGGER exported_data_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON exported_data
  FOR EACH ROW
DECLARE
  v_mod_user exported_data_h.mod_user%TYPE;
  v_mod_time exported_data_h.last_mod%TYPE;
BEGIN
  v_mod_user := sys_context('USERENV', 'OS_USER');
  v_mod_time := SYSDATE;

  IF deleting
  THEN
    INSERT INTO exported_data_h
      (id
      ,user_id
      ,export_format
      ,created_date
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.id
      ,:old.user_id
      ,:old.export_format
      ,:old.created_date
      ,v_mod_user
      ,:old.created_on
      ,v_mod_time
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO exported_data_h
      (id
      ,user_id
      ,export_format
      ,created_date
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.id
      ,:new.user_id
      ,:new.export_format
      ,:new.created_date
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END exported_data_h_trg;
