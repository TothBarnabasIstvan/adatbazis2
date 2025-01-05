CREATE OR REPLACE FUNCTION get_segmented_cell_count (p_image_id NUMBER)
RETURN NUMBER IS
  v_segmented_cell_count NUMBER;
  v_exists NUMBER;
BEGIN
  SELECT COUNT(*) 
  INTO v_exists
  FROM segmentation_data
  WHERE image_id = p_image_id;

  IF v_exists = 0 THEN
  RAISE_APPLICATION_ERROR(-20001, 'Image not found!');
END IF;

  SELECT NVL(SUM(s.number_of_segmented_cells), 0)
  INTO v_segmented_cell_count
  FROM segmentation_data s 
  WHERE s.image_id = p_image_id;
  
  RETURN v_segmented_cell_count;
  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
    RAISE;
END get_segmented_cell_count;

-------------------------------------------------------------------


CREATE OR REPLACE FUNCTION is_user_admin (p_user_id NUMBER)
RETURN VARCHAR2 IS
v_user_role VARCHAR2(20);
BEGIN 
  SELECT u.role
  INTO v_user_role
  FROM users u
  WHERE u.id = p_user_id;
  
  RETURN v_user_role;
  
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'User not found!'; 
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
    RAISE;

END;
  
