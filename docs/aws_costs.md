# AWS Kostenanalyse – GroceryMate

Diese Kostenanalyse dokumentiert die monatlichen AWS-Ausgaben für das GroceryMate-Projekt, basierend auf tatsächlichen Daten aus dem AWS Cost Explorer (Oktober – November 2025).

---

## 📊 Gesamtkostenübersicht

| Service | Kosten gesamt |
|--------|----------------|
| **EC2 Instances** | 9,18 $ |
| **VPC** | 3,67 $ |
| **RDS (MySQL)** | 3,29 $ |
| **EC2 Other** | 1,36 $ |
| **Steuern (Tax)** | 3,15 $ |
| **S3** | 0,00 $ |
| **Gesamtkosten** | **20,64 $** |

*(Daten: AWS Cost Explorer, Stand November 2025)*

---

## 📅 Monatliche Entwicklung

| Monat | Kosten |
|-------|--------|
| **Oktober** | 2,34 $ |
| **November (bisher)** | 18,30 $ |
| **Prognose November** | ~30,71 $ |

Die Kosten steigen im November deutlich, da EC2 und RDS durchgehend betrieben werden.

---

# 🖥️ Einzelanalyse der Services

## 1. EC2 – t2.micro (Backend Server)
- **Instanztyp:** t2.micro
- **Region:** eu-central-1
- **Läuft 24/7**
- **Kosten:** 9,18 $ / Monat
- **Funktion:** Hostet das Python-Backend

**Begründung der Kosten:**  
t2.micro hat 1 vCPU und 1GB RAM und ist günstig – jedoch läuft sie dauerhaft, was den Preis erhöht.

---

## 2. RDS – MySQL (db.t3.micro)
- **Engine:** MySQL Community
- **Typ:** db.t3.micro
- **Multi-AZ:** Nein
- **Privat:** Ja (nicht öffentlich erreichbar)
- **Kosten:** 3,29 $ / Monat

**Begründung der Kosten:**  
RDS ist permanent verfügbar und verursacht Grundgebühren für Compute + Storage.

---

## 3. VPC Kosten
- **Kosten:** 3,67 $
- Entstehen durch:
    - Elastic IP für EC2 (wenn zugewiesen)
    - NAT Gateway (falls aktiv) → *wahrscheinlich hier*
    - Datenverkehr innerhalb/VPC Endpoints

---

## 4. S3 Kosten
- **Bucket:** grocerymate-avatars
- **Objekte:** 6 PNG-Dateien
- **Speicher:** nur wenige hundert KB
- **Kosten:** 0,00 $

---

# 💡 Optimierungsempfehlungen

## 🔧 1. EC2 Optimierung
| Option | Einsparung | Empfehlung |
|--------|------------|------------|
| Wechsel zu **t3.micro** | bis zu 30–40% | ✔️ sinnvoll |
| Wechsel zu **t4g.micro (ARM)** | bis zu 50% | ✔️ wenn App kompatibel (Python + MySQL = ok) |
| EC2 **nicht 24/7 laufen lassen** | -50% | ✔️ Stopp nachts/wenn nicht genutzt |

---

## 🗄️ 2. RDS Optimierung
| Option | Wirkung |
|--------|---------|
| Wechsel zu **db.t4g.micro** | günstiger + schneller |
| Backup Retention reduzieren (Standard 7 Tage) | spart Storage |
| Ausschalten, wenn nicht benötigt (dev/test) | bis zu -80% |

---

## 🌐 3. VPC / Networking Kosten reduzieren
Hauptproblem: **NAT Gateway** (kostet 32–35 $ monatlich → aber du zahlst weniger → evtl. billigere Nutzung).

Empfehlung:
- NAT Gateway **entfernen**, falls Backend keinen Internet Outbound benötigt.
- Stattdessen **VPC Endpoint für S3** benutzen (fast kostenlos).

---

## 📦 4. S3 Storage Optimierung
Du nutzt S3 korrekt – keine Optimierung notwendig.
Optional:
- Lifecycle-Regeln: Archivierung nach 90 Tagen → aber irrelevant bei 6 PNGs.

---

# 🧾 Fazit

Die Hauptkosten entstehen durch:
1. **EC2 t2.micro** (Backend)
2. **RDS t3.micro** (MySQL)
3. **VPC Gebühren**

Mit einfachen Optimierungen (t4g.micro + Auto-Stop für dev/test) können die Kosten um **60–70% reduziert** werden.

