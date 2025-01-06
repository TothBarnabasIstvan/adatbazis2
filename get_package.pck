create or replace package get_package is

  PROCEDURE get_image_data(p_image_id IN NUMBER, p_image_data OUT image_data_type_l);

end get_package;
/
create or replace package body get_package is

 PROCEDURE get_image_data (p_image_id IN NUMBER, p_image_data OUT image_data_type_l) IS

BEGIN
  
SELECT image_data_type (i.id, NVL(s.number_of_segmented_cells, 0), i.processing_status, s.segment_type)
BULK COLLECT INTO p_image_data
FROM  image i join segmentation_data s on i.id = s.image_id
WHERE i.id = p_image_id;

IF p_image_data.COUNT = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Image not found!');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
    RAISE;
    
END get_image_data;

end get_package;
/
