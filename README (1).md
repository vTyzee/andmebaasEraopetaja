# Arhitektuur, protsess ja projektikorraldus

## Diagrammid

### Use Case diagramm
Use Case diagramm kirjeldab süsteemi põhifunktsioone rollide lõikes:
- õpilane otsib õpetajat, broneerib ja maksab;
- õpetaja haldab profiili ja broneeringuid;
- moderaator kontrollib profiile ja arvustusi;
- kasutajatugi lahendab probleeme;
- administraator haldab kasutajaid ja õigusi.

### ERD
Projekt sisaldab kahte ERD taset:
- **kontseptuaalne ERD** - näitab põhiobjekte ja seoseid;
- **füüsiline ERD** - näitab tabelid, PK/FK seosed, andmetüübid ja piirangud.

### Olekudiagrammid
Kirjeldavad süsteemi objektide olekute muutumist:
- `Lesson`: näiteks planned -> confirmed -> completed / cancelled;
- `Payment`: pending -> paid / failed / refunded;
- `Tutor verification`: kontrollimisel -> kinnitatud / tagasi lükatud.

### Tegevusdiagramm
Kirjeldab süsteemi töövoogu rollide vaates:
- õpilane otsib õpetajat, valib aja, broneerib ja maksab;
- õpetaja haldab profiili ja reageerib broneeringutele;
- moderaator kinnitab profiile;
- kasutajatugi lahendab probleeme;
- administraator haldab süsteemi.

### Järjestusdiagramm
Näitab samm-sammult suhtlust kasutaja, veebirakenduse ja andmebaasi vahel.
Põhistsenaariumid:
- broneeringu loomine;
- makse tegemine;
- broneeringu staatuse uuendamine;
- õpetaja kinnitamine;
- moderaatori kontroll.

## Figma
Projektidokumendis on viide Figma prototüübile. GitHubi repositooriumis tasub lisada:
- otselink Figma failile;
- vähemalt mõned ekraanipildid `assets/` kausta.

## Jira ja tööjaotus
Projektis on kasutatud Jira tööde jaotamiseks. Repositooriumis võib lisada:
- Jira lingi;
- ekraanipildi sprintidest või töövoost;
- lühikese kirjelduse, kes mille eest vastutas.

## Soovitus GitHubi jaoks
Et repositoorium näeks korrektne välja:
- hoia README lühike ja selge;
- tõsta detailne info `docs/` kausta;
- hoia SQL eraldi `database/` kaustas;
- lisa diagrammide pildid `assets/` kausta.
