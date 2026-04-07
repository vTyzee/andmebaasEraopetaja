# Eraõpetajate otsingu teenus

Veebipõhise infosüsteemi projekt, mille eesmärk on võimaldada õpilastel leida sobiv eraõpetaja, broneerida tunde, teha makseid ning jätta pärast tundi tagasisidet.

See GitHubi repositoorium on koostatud algse projektidokumendi põhjal ning vormistatud GitHubi jaoks selgeks ja esitamiseks sobivaks dokumentatsiooniks.

## Projekti eesmärgid

- luua relatsioonandmebaasil põhinev infosüsteem eraõpetajate leidmiseks;
- toetada rollipõhist ligipääsu erinevatele kasutajatele;
- võimaldada tundide planeerimist, broneerimist ja haldamist;
- salvestada ja kontrollida makseid;
- võimaldada õpilastel jätta arvustusi ja hinnanguid.

## Süsteemi peamised rollid

- **Administraator** - haldab kasutajaid, rolle ja õigusi.
- **Moderaator** - kontrollib õpetajate profiile ja arvustusi.
- **Eraõpetaja** - haldab enda profiili, aineid ja broneeringuid.
- **Õpilane** - otsib õpetajaid, broneerib tunde, tasub ja jätab arvustusi.
- **Kasutajatugi** - aitab kasutajaid konto-, makse- ja broneeringuprobleemide korral.

## Funktsionaalsus

- õpetaja otsing aine või hinna järgi;
- kasutajakontod erinevate rollidega;
- tundide ajastamine, kinnitamine ja tühistamine;
- maksete haldus;
- arvustused ja hinnangud;
- andmebaasi vaated, funktsioonid ja õiguste haldus.

## Repositooriumi struktuur

```text
eraopetajate-otsingu-teenus/
├── README.md
├── .gitignore
├── assets/
│   ├── README.md
│   ├── use-case-diagramm.png
│   ├── erd-page.png
│   ├── oleku-tegevus-jarjestus-diagrammid.png
│   └── jira-toojaotus.png
├── database/
│   ├── schema.sql
│   ├── permissions.sql
│   └── views_and_function.sql
└── docs/
    ├── 01-projekti-kirjeldus.md
    ├── 02-kasutajad-ja-kasutuslood.md
    ├── 03-andmebaasi-mudel.md
    ├── 04-sql-oigused-vaated.md
    ├── 05-arhitektuur-ja-protsess.md
    ├── 06-github-checklist.md
    └── source/
        └── EraopetajaProjekt.pdf
```

## Dokumentatsiooni sisu

### `docs/01-projekti-kirjeldus.md`
Projekti eesmärk, ulatus ja põhilised funktsioonid.

### `docs/02-kasutajad-ja-kasutuslood.md`
Süsteemi kasutajarollid ja peamised kasutuslood.

### `docs/03-andmebaasi-mudel.md`
Andmebaasi objektid, seosed ja tabelite loogika.

### `docs/04-sql-oigused-vaated.md`
Andmebaasi kasutajad, õigused, vaated ja funktsioonid.

### `docs/05-arhitektuur-ja-protsess.md`
Oleku-, tegevus- ja järjestusdiagrammide kokkuvõte ning projekti töökorraldus.

### `docs/06-github-checklist.md`
Kontrollnimekiri enne repositooriumi üleslaadimist.

## Kuidas kasutada

1. Loo GitHubis uus repositoorium.
2. Laadi üles kõik selle kausta failid.
3. Impordi andmebaasi loomiseks fail `database/schema.sql`.
4. Impordi kasutajate ja õiguste jaoks `database/permissions.sql`.
5. Impordi vaadete ja funktsiooni jaoks `database/views_and_function.sql`.
6. Vajadusel lisa projekti lõplik Figma link, Jira link ja andmebaasi eksport.

## Märkus

Algdokumendis esineb mõnes kohas nimetuste erinevusi (näiteks `Roles` / `role_type`, samuti viited `Tutors` ja `Students` tabelitele). Selles repositooriumis on nimetused ühtlustatud, et dokumentatsioon ja SQL oleksid selgemad ja järjepidevad.

## Staatus

Dokumentatsioon on valmis GitHubi üleslaadimiseks. Enne esitlust või lõplikku esitust tasub üle kontrollida:
- Figma link;
- Jira link;
- lõplik andmebaasi eksport;
- meeskonnaliikmete nimed ja panus.
