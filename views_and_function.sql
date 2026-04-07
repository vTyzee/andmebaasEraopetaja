# SQL, õigused, vaated ja funktsioonid

## Andmebaasi loomine
Fail `database/schema.sql` sisaldab:
- tabelite loomist;
- primaar- ja võõrvõtmeid;
- unikaalsuspiiranguid;
- kontrollpiiranguid;
- olekute ENUM tüüpe.

## Andmebaasi kasutajad
Fail `database/permissions.sql` loob järgmised andmebaasi kasutajad:
- `database_admin`
- `database_moderator`
- `database_teacher`
- `database_student`
- `database_support`

## Õiguste loogika
### Administraator
- täielik ligipääs kogu andmebaasile.

### Moderaator
- kõikide andmete lugemine;
- õpetajaprofiilide, dokumentide ja arvustuste uuendamine;
- arvustuste kustutamine.

### Eraõpetaja
- kõikide andmete lugemine;
- enda profiili ja tundide muutmine.

### Õpilane
- kõikide andmete lugemine;
- tundide lisamine, muutmine ja kustutamine;
- maksete lisamine;
- arvustuste lisamine, muutmine ja kustutamine.

### Kasutajatugi
- kõikide andmete lugemine;
- tundide staatuste uuendamine kasutajate abistamiseks.

## Vaated
Fail `database/views_and_function.sql` sisaldab järgmisi vaateid:

### `vw_teacher_average_rating`
Näitab õpetaja keskmist hinnangut ja arvustuste arvu.

### `vw_future_lessons`
Näitab tulevasi tunde koos õpetaja ja õpilase nimega.

### `vw_lessons_history`
Näitab tundide ajalugu koos osapoolte ja aine nimega.

## Funktsioon
### `get_teacher_average_rating(teacher_identifier INT)`
Tagastab valitud õpetaja keskmise hinnangu.
