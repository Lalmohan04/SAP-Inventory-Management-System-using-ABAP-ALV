# Data Model

The SAP Inventory Management System uses SAP standard inventory, material, and material-movement tables. The main inventory information is retrieved from `MARD`, `MARA`, and `MAKT`, while `MSEG`, `MKPF`, and `T156T` support the material movement drill-down.

---

## 1. Main Inventory Tables

| Table | Purpose | Data Used |
|---|---|---|
| `MARD` | Stores stock quantities at plant and storage-location level | MATNR, WERKS, LGORT, LABST |
| `MARA` | Contains general material information | MATNR, MTART |
| `MAKT` | Stores material descriptions | MATNR, MAKTX |

### Relationship

The main inventory dataset is formed by joining the material and inventory information:

```text
MARD
  |
  | MATNR
  v
MARA
  |
  | MATNR
  v
MAKT
