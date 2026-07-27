# Deploy and Host OpenEMR on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/openemr?utm_medium=integration&utm_source=button&utm_campaign=openemr)

[OpenEMR](https://www.open-emr.org/) is the most widely used open-source electronic medical records and practice management system: patient charts, scheduling, e-prescribing, billing, lab integrations, telehealth, and a patient portal — ONC-certified and translated into 30+ languages. A self-hosted alternative to per-provider-per-month EHR subscriptions.

## About Hosting OpenEMR

This template runs OpenEMR (7.0.4) next to a MySQL 8 service. First boot is fully automatic: OpenEMR creates its database and application user via the generated root credentials, then sets up the admin account from the `OE_USER` / `OE_PASS` template variables — no installer wizard. Patient documents, site configuration, and uploads persist on a volume at `/var/www/localhost/htdocs/openemr/sites`; everything else lives in MySQL (volume-backed as well). Railway terminates TLS at the edge, so the app serves plain HTTP internally.

## Common Use Cases

- A small practice or clinic running its own EHR instead of paying per-provider SaaS fees
- Medical NGOs and clinics in regions where patient data must stay on infrastructure they control
- A staging or training environment for OpenEMR customization, themes, and integrations

## Dependencies for OpenEMR Hosting

- MySQL 8 (included in this template)

### Deployment Dependencies

- [OpenEMR documentation](https://www.open-emr.org/wiki/)
- [Template source on GitHub](https://github.com/nomideusz/openemr-railway)

### Implementation Details

**Your OpenEMR lives at the service's Railway domain** — it redirects straight to the login page. Sign in with the `OE_USER` / `OE_PASS` values from your template variables, then change the password in Administration → Users.

| Service | Role |
|---|---|
| openemr | Apache + PHP application; sites volume for documents & config |
| mysql | MySQL 8; data volume (datadir in a subdir to coexist with Railway volume mounts) |

Notes:

- First boot takes a few minutes while OpenEMR installs its database — watch the deploy logs; the service is ready when Apache logs "resuming normal operations".
- **Compliance is your responsibility.** Railway does not advertise HIPAA BAAs — for US production use with real PHI, verify your obligations first. For practices outside the US, for GDPR-style self-hosting, or for staging/training instances, this template is a direct fit.
- Back up both volumes (sites + MySQL). OpenEMR's built-in backup lives in Administration → Backup.

## Why Deploy OpenEMR on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying OpenEMR on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
