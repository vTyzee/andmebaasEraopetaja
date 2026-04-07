# Andmebaasi mudel

## Ülevaade
Andmebaasi mudel kirjeldab süsteemi põhiobjekte ja nendevahelisi seoseid. Keskseks objektiks on kasutaja, kellel on roll. Kasutajast võivad sõltuvalt rollist kujuneda õpetaja profiil või õpilase profiil.

## Peamised tabelid

### `roles`
Sisaldab süsteemi rollide loendit.
- `role_id`
- `role_name`

### `users`
Sisaldab kõiki süsteemi kasutajaid.
- `user_id`
- `role_id`
- `first_name`
- `last_name`
- `email`
- `password_hash`
- `phone`
- `status`
- `created_at`

### `teacher_profile`
Sisaldab õpetajate profiiliandmeid.
- `teacher_id`
- `bio`
- `experience_years`
- `price_per_hour`
- `rating`

### `student_profile`
Sisaldab õpilase profiili.
- `student_id`

### `subjects`
Sisaldab õppeainete nimekirja.
- `subject_id`
- `subject_name`
- `description`

### `teacher_subjects`
Seostabel õpetajate ja ainete vahel.
- `teacher_id`
- `subject_id`

### `lessons`
Sisaldab tundide andmeid.
- `lesson_id`
- `teacher_id`
- `student_id`
- `subject_id`
- `lesson_datetime`
- `duration_minutes`
- `status`
- `price`

### `payments`
Sisaldab maksete infot.
- `payment_id`
- `lesson_id`
- `amount`
- `payment_date`
- `status`

### `reviews`
Sisaldab tundidega seotud tagasisidet.
- `review_id`
- `lesson_id`
- `rating`
- `comment`
- `created_at`

### `documents`
Sisaldab õpetajate dokumente verifitseerimise jaoks.
- `document_id`
- `teacher_id`
- `file_path`
- `verification_status`
- `uploaded_at`

### `logs`
Sisaldab süsteemi tegevuste logi.
- `log_id`
- `user_id`
- `action`
- `entity_type`
- `timestamp`
- `ip_address`
- `details`

## Peamised seosed
- üks roll võib olla seotud mitme kasutajaga;
- ühel kasutajal võib olla üks õpetaja profiil või üks õpilase profiil;
- õpetaja võib õpetada mitut ainet;
- õpilane saab broneerida mitu tundi;
- iga tund on seotud ühe õpetaja, ühe õpilase ja ühe ainega;
- tunni kohta saab salvestada makse;
- tunni kohta saab jätta ühe arvustuse.

## Tähelepanekud
Algses projektidokumendis esines mõnes kohas nimetuste ebaühtlust. GitHubi versioonis on kasutatud järgmisi ühtseid nimetusi:
- `roles` asemel ei kasutata eraldi nimetust `role_type`;
- `teacher_profile` ja `student_profile` asendavad varasemaid ebaühtlaseid viiteid `Tutors` ja `Students`.

See muudab dokumentatsiooni loetavamaks ja SQL-struktuuri selgemaks.
