# DavidCare

Flutter pharmacy SaaS for Ghana and West Africa. **One Flutter app** serves the marketing landing, pharmacy web workspaces, and the patient mobile UI.

| Surface | Route | What it is |
| --- | --- | --- |
| SaaS landing | `/` | Stitch pharmacy landing + Get Started |
| Pharmacy onboarding | `/get-started` | Log in / sign up → pharmacist, manager, or staff |
| Pharmacist web | `/pharmacist` | Clinical Action Center (not a POS) |
| Manager web | `/manager` | Demand, catalogue, staff, ops |
| Dispensing staff | `/staff` | Orders, pickup PINs, counter hub |
| Patient app | `/login` → `/home` | Stitch mobile screens (phone-width) |

**Get Started** on the landing opens Flutter onboarding, then isolated gateways into the dashboards. **Download Patient App** opens the customer welcome screen.

## Local preview

```powershell
powershell -ExecutionPolicy Bypass -File scripts\preview.ps1
```

Then open http://localhost:8094/

Or from the app folder:

```powershell
cd apps\davecare
C:\dev\flutter\bin\flutter.bat run -d chrome --release --web-port 8094
```

## Repo / live preview

- Repo: https://github.com/perezpixels/davecare
- Pages: https://perezpixels.github.io/davecare/
