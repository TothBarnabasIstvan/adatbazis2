create or replace package update_package  is

  PROCEDURE update_image_status(p_image_id INT, p_new_status VARCHAR2);
  
  PROCEDURE update_user_permissions(p_user_id INT, p_new_role VARCHAR2, p_new_permissions VARCHAR2);

end update_package ;
/
create or replace package body update_package  is

  -- Procedure: update_image_status
  PROCEDURE update_image_status(p_image_id INT, p_new_status VARCHAR2) IS
  BEGIN
    UPDATE image 
    SET processing_status = p_new_status
    WHERE id = p_image_id;

    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'No image found with the provided ID.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Image status successfully updated to: ' || p_new_status);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'An error occurred: ' || SQLERRM);
  END update_image_status;

  -- Procedure: update_user_permissions
  PROCEDURE update_user_permissions(p_user_id INT, p_new_role VARCHAR2, p_new_permissions VARCHAR2) IS
  BEGIN
    UPDATE users u
    SET u.role = p_new_role, u.permission = p_new_permissions
    WHERE u.id = p_user_id;

    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'No user found with the provided ID.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('User permissions successfully updated: Role = ' || p_new_role || ', Permissions = ' || p_new_permissions);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'An error occurred: ' || SQLERRM);
  END update_user_permissions;
  
end update_package ;
/
