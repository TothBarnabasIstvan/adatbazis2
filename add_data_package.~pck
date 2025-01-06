create or replace package add_data_package  is

  PROCEDURE add_feedback(p_user_id INT, p_image_id INT, p_feedback_text VARCHAR2);
  
  PROCEDURE add_user(p_name VARCHAR2, p_email VARCHAR2, p_role VARCHAR2, p_permissions VARCHAR2);
  
  PROCEDURE add_segmentation_data(p_image_id NUMBER, p_number_of_segmented_cells NUMBER, p_segment_type VARCHAR2, p_date DATE);
 
  PROCEDURE add_exported_data(p_user_id NUMBER, p_export_format VARCHAR2, p_date DATE);
  
  PROCEDURE add_image(p_upload_date DATE, p_processing_status VARCHAR2);

end add_data_package ;
/
create or replace package body add_data_package  is

  -- Add Feedback Procedure
  PROCEDURE add_feedback(p_user_id INT, p_image_id INT, p_feedback_text VARCHAR2) IS
  BEGIN
    INSERT INTO feedback
    (user_id, image_id, feedback_text, created_date)
    VALUES
    (p_user_id, p_image_id, p_feedback_text, SYSDATE);
    
    DBMS_OUTPUT.PUT_LINE('Feedback successfully added for User ID = ' || p_user_id || ' and Image ID = ' || p_image_id);

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'An error occurred while adding feedback: ' || SQLERRM);
  END add_feedback;

  -- Add User Procedure
  PROCEDURE add_user(p_name VARCHAR2, p_email VARCHAR2, p_role VARCHAR2, p_permissions VARCHAR2) IS
  BEGIN
    INSERT INTO users
    (name, email, role, permission)
    VALUES
    (p_name, p_email, p_role, p_permissions);
    
    DBMS_OUTPUT.PUT_LINE('New user successfully added: ' || p_name);
    
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'An error occurred while adding the user: ' || SQLERRM);
  END add_user;

  -- Add Segmentation Data Procedure
  PROCEDURE add_segmentation_data(p_image_id NUMBER, p_number_of_segmented_cells NUMBER, p_segment_type VARCHAR2, p_date DATE) IS
  BEGIN 
    INSERT INTO segmentation_data
    (image_id, number_of_segmented_cells, segment_type, created_date)
    VALUES
    (p_image_id, NVL(p_number_of_segmented_cells, 0), p_segment_type, NVL(p_date, SYSDATE));
    
    DBMS_OUTPUT.PUT_LINE('Segmentation data successfully added for image ID: ' || p_image_id);
    
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'An error occurred while adding segmentation data: ' || SQLERRM);
  END add_segmentation_data;

  -- Add Exported Data Procedure
  PROCEDURE add_exported_data(p_user_id NUMBER, p_export_format VARCHAR2, p_date DATE) IS
  BEGIN 
    INSERT INTO exported_data
    (user_id, export_format, created_date)
    VALUES
    (p_user_id, p_export_format, NVL(p_date, SYSDATE));
    
    DBMS_OUTPUT.PUT_LINE('Exported data successfully added for user ID: ' || p_user_id);
    
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'An error occurred while adding exported data: ' || SQLERRM);
  END add_exported_data;

  -- Add Image Procedure
  PROCEDURE add_image(p_upload_date DATE, p_processing_status VARCHAR2) IS
  BEGIN
    INSERT INTO image
    (upload_date, processing_status)
    VALUES
    (NVL(p_upload_date, SYSDATE), p_processing_status);
    
    DBMS_OUTPUT.PUT_LINE('Image was successfully added');
    
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'An error occurred while adding image: ' || SQLERRM);
  END add_image;
  
end add_data_package ;
/
