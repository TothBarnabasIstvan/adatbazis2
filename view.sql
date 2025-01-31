CREATE OR REPLACE VIEW user_feedback_view AS
SELECT u.id AS user_id, u.name AS user_name, f.image_id, f.feedback_text, f.created_date
FROM users u join feedback f on u.id = f.user_id;

select * from user_feedback_view;

------------------------------------------------------

CREATE OR REPLACE VIEW segmented_image_summary AS
SELECT i.id AS image_id, i.upload_date, i.processing_status, 
       NVL(SUM(sd.number_of_segmented_cells), 0) AS total_segmented_cells
FROM image i LEFT JOIN segmentation_data sd ON i.id = sd.image_id
GROUP BY i.id, i.upload_date, i.processing_status;

select * from segmented_image_summary;
