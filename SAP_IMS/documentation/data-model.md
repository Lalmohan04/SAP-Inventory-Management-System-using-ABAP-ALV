# Data Model

## Main Inventory Tables

| Table | Purpose |
|---|---|
| MARD | Stock quantities at plant and storage-location level |
| MARA | General material information |
| MAKT | Material descriptions |

## Movement Tables

| Table | Purpose |
|---|---|
| MSEG | Material movement details |
| MKPF | Material document header and posting date |
| T156T | Movement type descriptions |

## Main Output Fields

- MATNR — Material
- MAKTX — Description
- MTART — Material Type
- WERKS — Plant
- LGORT — Storage Location
- LABST — Stock
- LIGHT — Traffic-light indicator

## Movement Drill-Down Fields

- MATNR — Material
- MBLNR — Document
- MENGE — Quantity
- BWART — Movement Type
- BTEXT — Movement Description
- BUDAT — Posting Date
