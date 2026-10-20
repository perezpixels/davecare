# DAVIDCARE

## Master Engineering Product Requirements Document

### Flutter + Laravel Pharmacy Patient Engagement & Medication Management Platform

**Document Type:** Master Engineering PRD
**Product:** DavidCare
**Version:** MVP v1.0
**Primary Frontend:** Flutter — Mobile + Web
**Backend:** Laravel REST API
**Database:** PostgreSQL
**Primary Market:** Ghana / West Africa
**Development Environment:** Cursor
**UI Source:** Google Stitch
**Architecture:** API-first, multi-tenant, integration-ready SaaS

---

# 1. PRODUCT DEFINITION

DavidCare is a **Pharmacy Patient Engagement & Medication Management Platform**.

It connects pharmacies with their customers and helps customers manage:

* medications
* prescriptions
* refills
* reminders
* consultations
* appointments
* orders
* pharmacy communication
* health documents
* family/dependent medication needs

For pharmacies, DavidCare provides:

* Customer 360
* customer medication timelines
* prescription workflows
* consultation management
* customer follow-ups
* digital order management
* customer demand intelligence
* product availability requests
* communication history
* pharmacy insights
* integrations with existing pharmacy systems
* staff and permission management
* auditability

## Critical positioning

DavidCare is **NOT a POS**.

DavidCare does not replace:

* pharmacy POS systems
* inventory systems
* procurement systems
* accounting systems
* dispensing systems
* existing pharmacy-management software

Instead:

> DavidCare is the customer relationship, medication engagement, communication and pharmacy-care layer that works alongside existing pharmacy systems.

Existing pharmacy systems can become data sources through integrations.

---

# 2. PRODUCT PRINCIPLE

The product should be extremely useful while remaining extremely easy to use.

The primary UX principle is:

> See → Understand → Act → Record → Follow up

Every important screen should answer:

1. What happened?
2. What needs attention?
3. What does this mean?
4. What should I do next?

Avoid vanity dashboards and unnecessary complexity.

---

# 3. CORE PRODUCT LOOP

The core DavidCare loop is:

Customer visits or purchases from pharmacy

↓

Medication / purchase event recorded

↓

Customer medication timeline updated

↓

Prescription / OTC / refill relationship established

↓

Reminder or follow-up becomes relevant

↓

Customer receives useful communication

↓

Customer returns / requests refill / asks pharmacist

↓

Pharmacy receives new customer activity

↓

Customer relationship becomes richer

This customer relationship data is one of DavidCare's primary long-term assets.

---

# 4. USERS

## 4.1 Customer

Can:

* create account
* connect to pharmacy
* browse pharmacy catalogue
* search products
* view product information
* request unavailable products
* receive availability notifications
* order eligible products
* request pickup/delivery
* upload prescriptions
* track prescription review
* request refills
* view medication history
* manage reminders
* ask pharmacist questions
* request consultations
* book appointments
* view health documents
* manage family/dependents
* receive notifications
* manage privacy and consent

---

# 4.2 Pharmacist

Can:

* view assigned customers
* view Customer 360
* review prescriptions
* request clarification
* approve eligible prescriptions
* manage prescription status
* respond to consultations
* create follow-ups
* manage appointments
* review medication timelines
* view permitted customer documents
* communicate with customers
* manage customer care activities

---

# 4.3 Pharmacy Manager

Can:

* manage customers
* manage orders
* manage customer-facing products
* view demand
* view insights
* manage pharmacy configuration
* manage integrations
* manage staff
* manage roles
* manage notification settings
* view audit logs

---

# 4.4 Pharmacy Staff

Can perform only permissions explicitly assigned to their role.

Default capabilities may include:

* customer requests
* orders
* basic customer communication
* availability requests
* appointment administration

Staff must not automatically receive unrestricted access to health information.

---

# 5. MULTI-TENANCY

DavidCare must be architected as a multi-tenant SaaS.

Primary hierarchy:

```text
Platform
    |
    +-- Pharmacy Organization
            |
            +-- Branch / Location
            |
            +-- Staff
            |
            +-- Customers
            |
            +-- Products
            |
            +-- Prescriptions
            |
            +-- Consultations
            |
            +-- Orders
            |
            +-- Appointments
            |
            +-- Integrations
```

Every pharmacy-owned resource must be tenant-scoped.

Never rely only on frontend filtering for tenant isolation.

Backend authorization must enforce tenant ownership.

---

# 6. FRONTEND ARCHITECTURE

Use Flutter for:

* Android
* iOS
* Web

Use a shared codebase with responsive layouts.

Recommended architecture:

```text
lib/
├── app/
│   ├── router/
│   ├── theme/
│   ├── config/
│   └── app.dart
│
├── core/
│   ├── api/
│   ├── auth/
│   ├── errors/
│   ├── storage/
│   ├── network/
│   ├── permissions/
│   ├── notifications/
│   ├── utils/
│   └── widgets/
│
├── features/
│   ├── auth/
│   ├── customer/
│   ├── pharmacy/
│   ├── medications/
│   ├── prescriptions/
│   ├── consultations/
│   ├── appointments/
│   ├── orders/
│   ├── products/
│   ├── demand/
│   ├── notifications/
│   ├── documents/
│   ├── family/
│   ├── integrations/
│   ├── staff/
│   ├── settings/
│   └── audit/
│
└── main.dart
```

Use feature-based architecture.

Do not create one enormous `screens/` directory.

---

# 7. RECOMMENDED FLUTTER STACK

Use:

* Flutter
* Dart
* Riverpod for state management
* GoRouter for routing
* Dio for HTTP
* Freezed for immutable models
* json_serializable
* Flutter Secure Storage where appropriate
* Firebase Cloud Messaging for push notifications
* local persistence where useful

Do not introduce unnecessary state-management frameworks.

---

# 8. DESIGN IMPLEMENTATION

Google Stitch is the visual source of truth.

Cursor implementation must preserve:

* layout hierarchy
* spacing
* typography
* component proportions
* status colours
* responsive behaviour
* interaction patterns
* navigation
* empty states
* loading states
* error states

Do not replace Stitch designs with generic Flutter widgets unless necessary.

Create reusable components.

Examples:

```text
DavidButton
DavidSecondaryButton
DavidTextField
DavidSearchField
DavidStatusBadge
DavidCard
DavidSectionHeader
DavidEmptyState
DavidErrorState
DavidLoadingState
DavidAvatar
DavidBottomSheet
DavidDialog
DavidDataTable
DavidTimeline
DavidMetricCard
DavidNotificationTile
DavidPrescriptionCard
DavidMedicationCard
DavidOrderCard
```

---

# 9. RESPONSIVE DESIGN

## Customer

Primary experience:

Mobile first.

Support:

* Android
* iOS
* responsive web

## Pharmacy

Primary experience:

Desktop web.

Support:

* desktop
* tablet
* mobile responsive fallback

Desktop pharmacy layout:

```text
Sidebar
    |
Main content
    |
Contextual actions
```

Mobile:

```text
Top bar
Content
Bottom navigation / contextual navigation
```

Never simply shrink desktop layouts.

---

# 10. BACKEND ARCHITECTURE

Use Laravel as the API backend.

Recommended structure:

```text
app/
├── Models/
├── Http/
│   ├── Controllers/
│   ├── Requests/
│   └── Resources/
│
├── Services/
├── Actions/
├── Policies/
├── Notifications/
├── Jobs/
├── Events/
├── Listeners/
├── Integrations/
│   ├── Contracts/
│   ├── Adapters/
│   └── Providers/
│
└── Support/
```

Use service/action classes for business logic.

Do not put complex business logic inside controllers.

Controllers should remain thin.

---

# 11. DATABASE

Use PostgreSQL.

Primary entities:

```text
users
pharmacies
branches
staff
roles
permissions
customers
customer_pharmacy
family_groups
family_members
medications
customer_medications
medication_events
medication_reminders
prescriptions
prescription_items
prescription_reviews
prescription_status_history
consultations
consultation_messages
consultation_attachments
follow_ups
appointments
products
product_availability
customer_product_requests
orders
order_items
order_status_history
notifications
notification_preferences
notification_templates
health_documents
payment_transactions
integrations
integration_credentials
integration_permissions
sync_jobs
sync_records
audit_logs
```

---

# 12. CORE DATABASE RELATIONSHIPS

## User

```text
User
- id
- name
- phone
- email
- password
- status
- created_at
- updated_at
```

A user may represent:

* customer
* pharmacist
* manager
* staff
* platform administrator

Use role/permission architecture rather than hard-coded user types throughout the code.

---

# 13. PHARMACY

```text
Pharmacy
- id
- name
- registration_identifier
- phone
- email
- description
- logo
- address
- area
- digital_address
- landmark
- status
- created_at
- updated_at
```

---

# 14. BRANCH

```text
Branch
- id
- pharmacy_id
- name
- phone
- address
- area
- digital_address
- landmark
- status
- opening_hours
```

MVP may support a single branch while preserving branch-aware architecture.

---

# 15. CUSTOMER

```text
Customer
- id
- user_id
- date_of_birth
- gender
- emergency_contact
- profile_photo
- created_at
- updated_at
```

Do not collect unnecessary sensitive information.

Use data minimization.

---

# 16. CUSTOMER-PHARMACY RELATIONSHIP

A customer may eventually connect with multiple pharmacies.

Therefore do not permanently bind a customer to one pharmacy.

Use:

```text
customer_pharmacy
- id
- customer_id
- pharmacy_id
- branch_id
- relationship_status
- connected_at
- last_activity_at
```

---

# 17. MEDICATION MODEL

Medication catalogue:

```text
medications
- id
- generic_name
- brand_name
- dosage_form
- strength
- description
- metadata
```

Customer medication:

```text
customer_medications
- id
- customer_id
- medication_id
- source
- dosage_instruction
- frequency
- start_date
- end_date
- status
```

Medication event:

```text
medication_events
- id
- customer_id
- customer_medication_id
- event_type
- event_date
- source
- metadata
```

Possible event types:

```text
purchased
prescribed
refilled
reminder_created
consultation
pharmacist_note
customer_reported
```

---

# 18. MEDICATION TIMELINE

The medication timeline is a core DavidCare feature.

It should aggregate relevant events chronologically.

Example:

```text
12 Sep
Prescription uploaded

13 Sep
Prescription reviewed

13 Sep
Prescription approved

14 Sep
Order collected

10 Oct
Refill may be due
```

Do not state that a patient definitely ran out of medication based solely on purchase history.

Use:

> "This medication may be due for a refill based on your previous purchase pattern."

---

# 19. PRESCRIPTIONS

Prescription:

```text
prescriptions
- id
- customer_id
- pharmacy_id
- branch_id
- uploaded_by
- file_id
- prescription_number
- issued_date
- expiry_date
- status
- reviewed_by
- reviewed_at
- created_at
- updated_at
```

Prescription statuses:

```text
uploaded
under_review
action_required
approved
partially_available
ready
completed
expired
cancelled
```

---

# 20. PRESCRIPTION ITEMS

```text
prescription_items
- id
- prescription_id
- medication_id
- quantity
- dosage
- frequency
- duration
- instructions
- availability_status
```

---

# 21. PRESCRIPTION REVIEW

A prescription must never be automatically approved.

Workflow:

```text
Customer uploads prescription
        ↓
Uploaded
        ↓
Under review
        ↓
Pharmacist reviews
        ↓
Approved / Action Required / Partially Available
        ↓
Customer notified
```

AI may assist pharmacists later.

AI cannot make the final approval decision.

---

# 22. PRESCRIPTION AUDIT

Every material prescription action must create an audit event.

Examples:

```text
uploaded
opened
review_started
clarification_requested
approved
partially_available
cancelled
completed
```

Record:

* user
* timestamp
* action
* previous status
* new status
* pharmacy
* prescription

---

# 23. CONSULTATIONS

Consultation:

```text
consultations
- id
- customer_id
- pharmacy_id
- assigned_staff_id
- category
- subject
- status
- priority
- created_at
- updated_at
```

Statuses:

```text
open
awaiting_pharmacist
pharmacist_replied
customer_response_needed
follow_up_due
completed
closed
```

---

# 24. CONSULTATION MESSAGES

```text
consultation_messages
- id
- consultation_id
- sender_id
- message
- attachment_id
- sent_at
- read_at
```

Support:

* text
* image
* document

---

# 25. CONSULTATION RULE

"Ask Pharm. David" is a flagship feature.

Customer flow:

```text
Home
↓
Ask Pharm. David
↓
Select question type
↓
Enter question
↓
Attach optional file
↓
Submit
↓
Awaiting pharmacist
↓
Pharmacist response
↓
Customer response
↓
Follow-up
↓
Completed
```

Do not build a generic social chat system.

This is a structured pharmacy-care communication channel.

---

# 26. APPOINTMENTS

```text
appointments
- id
- customer_id
- pharmacy_id
- branch_id
- staff_id
- service_type
- scheduled_at
- duration
- status
- notes
```

Statuses:

```text
requested
confirmed
completed
cancelled
```

Prevent conflicting bookings.

---

# 27. FOLLOW-UPS

```text
follow_ups
- id
- customer_id
- pharmacy_id
- assigned_to
- source_type
- source_id
- due_at
- priority
- status
- notes
```

Examples:

* prescription clarification
* medication concern
* consultation follow-up
* appointment follow-up
* pharmacist check-in

---

# 28. PRODUCTS

DavidCare product catalogue is customer-facing.

It is NOT a replacement inventory system.

```text
products
- id
- pharmacy_id
- external_id
- name
- description
- category
- image
- price
- currency
- availability_status
- requires_prescription
- active
```

Statuses:

```text
in_stock
low_availability
out_of_stock
watching
back_in_stock
```

The actual inventory quantity may remain in the connected pharmacy system.

---

# 29. CUSTOMER DEMAND

One of DavidCare's important intelligence features.

Customer request:

```text
customer_product_requests
- id
- customer_id
- pharmacy_id
- product_id
- requested_product_name
- quantity
- status
- created_at
- fulfilled_at
```

Statuses:

```text
requested
watching
available
not_available
fulfilled
cancelled
```

This enables:

> "Customers are asking for this."

without requiring DavidCare to become an inventory system.

---

# 30. RESTOCK WORKFLOW

Customer:

```text
Product unavailable
↓
Notify me when available
↓
Watching
↓
Availability changes
↓
Notification
↓
Customer returns
↓
Order/request
```

Pharmacy:

```text
Customer demand
↓
Product demand detail
↓
Availability update from integrated system
↓
DavidCare detects availability change
↓
Notify eligible customers
```

---

# 31. ORDERS

Orders are customer-facing digital orders.

They are not POS transactions.

```text
orders
- id
- customer_id
- pharmacy_id
- branch_id
- prescription_id
- order_number
- fulfillment_type
- payment_status
- order_status
- subtotal
- delivery_fee
- total
- currency
- delivery_address
- notes
- created_at
- updated_at
```

Fulfillment:

```text
pickup
delivery
```

Order statuses:

```text
requested
awaiting_review
awaiting_payment
confirmed
preparing
ready_for_pickup
out_for_delivery
delivered
cancelled
```

---

# 32. ORDER ITEMS

```text
order_items
- id
- order_id
- product_id
- product_name_snapshot
- quantity
- unit_price
- requires_prescription
- prescription_item_id
```

Use snapshots for historical order integrity.

---

# 33. PAYMENT ARCHITECTURE

Do not tightly couple DavidCare to one payment provider.

Create:

```text
PaymentProviderInterface
```

Possible implementation:

```text
PaystackPaymentProvider
```

Future providers can implement the same interface.

Payment transaction:

```text
payment_transactions
- id
- order_id
- customer_id
- provider
- provider_reference
- amount
- currency
- status
- paid_at
- metadata
```

Payment statuses:

```text
pending
successful
failed
refunded
cancelled
```

Support Ghanaian payment methods where available:

* Mobile Money
* Card

---

# 34. FAMILY / DEPENDENTS

Family group:

```text
family_groups
- id
- owner_customer_id
- name
```

Family member:

```text
family_members
- id
- family_group_id
- customer_id
- relationship
- permission_level
```

Permissions must be explicit.

Example:

```text
view_medications
view_prescriptions
view_appointments
receive_reminders
```

Never assume family access means unrestricted health-data access.

---

# 35. HEALTH DOCUMENTS

```text
health_documents
- id
- customer_id
- pharmacy_id
- uploaded_by
- document_type
- file_path
- file_name
- mime_type
- size
- visibility
- created_at
```

Examples:

* prescription
* lab document
* referral
* consultation document
* other health document

Use private object storage.

Do not expose files through public URLs.

Use temporary signed access where appropriate.

---

# 36. NOTIFICATION ENGINE

Create a centralized notification service.

Support:

```text
Push
SMS
WhatsApp
Email
In-app
```

Notification:

```text
notifications
- id
- user_id
- type
- title
- body
- channel
- related_type
- related_id
- status
- sent_at
- read_at
```

Notification delivery should be asynchronous.

Use Laravel queues.

---

# 37. NOTIFICATION TYPES

Examples:

```text
prescription_received
prescription_action_required
prescription_approved
prescription_partially_available
order_confirmed
order_ready
order_delivered
appointment_confirmed
appointment_reminder
consultation_response
follow_up_due
refill_reminder
product_back_in_stock
system_alert
```

Transactional notifications should use deterministic templates.

Do not require AI to generate them.

---

# 38. NOTIFICATION PREFERENCES

Customers should control non-critical communication preferences.

Example:

```text
notification_preferences
- user_id
- push_enabled
- sms_enabled
- whatsapp_enabled
- email_enabled
- marketing_enabled
- refill_reminders_enabled
- appointment_reminders_enabled
```

Critical transactional communication may have different requirements.

Do not allow users to accidentally disable necessary security/account messages.

---

# 39. PHARMACY NOTIFICATION TEMPLATES

Templates should support variables:

```text
{{customer_name}}
{{pharmacy_name}}
{{order_number}}
{{appointment_date}}
{{appointment_time}}
{{support_phone}}
```

Never inject arbitrary user content into templates without escaping/sanitization.

---

# 40. INTEGRATION ARCHITECTURE

This is critical.

Use an adapter pattern.

```text
IntegrationProviderInterface
```

Methods may include:

```text
connect()
disconnect()
testConnection()
syncCustomers()
syncProducts()
syncAvailability()
syncPurchaseHistory()
pushOrder()
getStatus()
```

Each external pharmacy system gets an adapter:

```text
Integration/
    Contracts/
        PharmacySystemInterface.php

    Adapters/
        ExampleAdapter.php
```

Do NOT hard-code an external system directly into customer or order services.

---

# 41. INTEGRATION DATA

```text
integrations
- id
- pharmacy_id
- provider
- type
- status
- connected_at
- last_sync_at
- configuration
```

Credentials:

```text
integration_credentials
- id
- integration_id
- encrypted_credentials
- expires_at
```

Never store API secrets in plaintext.

Use Laravel encryption / secret management.

---

# 42. INTEGRATION PERMISSIONS

```text
integration_permissions
- id
- integration_id
- data_type
- access_enabled
```

Possible:

```text
customers
products
availability
purchase_history
prescriptions
orders
```

Use minimum necessary access.

---

# 43. SYNC ENGINE

Synchronization must run through queues.

Example:

```text
IntegrationSyncJob
```

Flow:

```text
Scheduled sync
↓
Create sync job
↓
Load integration adapter
↓
Fetch external data
↓
Validate
↓
Transform
↓
Upsert
↓
Record sync results
↓
Audit
↓
Notify on failure
```

Never block an HTTP request while processing a large synchronization.

---

# 44. SYNC RECORDS

```text
sync_jobs
- id
- integration_id
- type
- started_at
- completed_at
- status
- processed_count
- created_count
- updated_count
- skipped_count
- failed_count
- error_summary
```

Possible statuses:

```text
queued
running
completed
partial
failed
```

---

# 45. DATA MAPPING

External systems may use different field names.

Create a transformation layer.

Example:

```text
external:
mobile_number

DavidCare:
phone
```

Do not hard-code field mapping in controllers.

---

# 46. CSV IMPORT

CSV import should support:

* customer import
* product catalogue import
* availability import where appropriate

Flow:

```text
Upload CSV
↓
Detect columns
↓
Map fields
↓
Validate
↓
Preview
↓
Import
↓
Results
```

Never import directly without validation.

Show:

```text
1,284 rows
1,260 valid
20 warnings
4 errors
```

Allow users to download error details if needed.

---

# 47. STAFF & RBAC

Use role-based access control.

Suggested roles:

```text
Pharmacist
Pharmacy Manager
Staff
```

Permissions should be granular.

Examples:

```text
customers.view
customers.edit

prescriptions.view
prescriptions.review
prescriptions.approve

consultations.view
consultations.reply

orders.view
orders.update

products.view
products.edit

integrations.view
integrations.manage

staff.view
staff.manage

audit.view
```

Never authorize only based on UI visibility.

Backend policies must enforce permissions.

---

# 48. LARAVEL AUTHENTICATION

Use secure API authentication.

Recommended:

Laravel Sanctum.

Support:

* phone/email authentication
* OTP
* password where appropriate
* session/token management
* device/session revocation

OTP flow:

```text
Enter phone
↓
Send OTP
↓
Verify OTP
↓
Authenticate
```

OTP requirements:

* expiration
* attempt limits
* resend cooldown
* rate limiting
* abuse protection

Never log OTP values.

---

# 49. AUTHORIZATION

Use Laravel Policies/Gates.

Every protected resource must verify:

```text
authenticated user
+
role/permission
+
tenant ownership
+
resource access
```

Example:

A pharmacist from Pharmacy A must never access Customer records belonging to Pharmacy B merely by changing an ID in the API request.

---

# 50. API DESIGN

Use versioned REST API.

Example:

```text
/api/v1/auth/...
/api/v1/customers/...
/api/v1/pharmacies/...
/api/v1/prescriptions/...
/api/v1/medications/...
/api/v1/orders/...
/api/v1/consultations/...
/api/v1/appointments/...
/api/v1/products/...
/api/v1/notifications/...
/api/v1/integrations/...
```

Use consistent response structure.

Example:

```json
{
  "data": {},
  "meta": {},
  "message": "Success"
}
```

Validation errors:

```json
{
  "message": "Validation failed",
  "errors": {
    "phone": [
      "The phone number is invalid."
    ]
  }
}
```

---

# 51. API RESOURCES

Use Laravel API Resources rather than exposing Eloquent models directly.

Examples:

```text
CustomerResource
MedicationResource
PrescriptionResource
OrderResource
ConsultationResource
AppointmentResource
ProductResource
NotificationResource
IntegrationResource
```

Do not expose:

* passwords
* OTPs
* API secrets
* internal credentials
* unnecessary sensitive metadata

---

# 52. SEARCH

Create global pharmacy search.

Search:

```text
customers
prescriptions
orders
consultations
appointments
products
```

Return:

```text
type
identifier
name
status
timestamp
```

Implement backend pagination.

Do not retrieve entire tables to Flutter and filter locally.

---

# 53. FILTERING & PAGINATION

Use server-side:

* pagination
* filtering
* sorting
* searching

Example:

```text
GET /api/v1/customers?search=ama&page=1
```

Use cursor pagination where appropriate for timelines/messages.

---

# 54. CUSTOMER 360

Customer 360 should aggregate:

```text
Profile
Medication timeline
Medications
Prescriptions
Orders
Consultations
Appointments
Documents
Communication
Follow-ups
```

Use separate API endpoints where appropriate.

Do not create one gigantic database query for everything.

Use optimized aggregation/read models if necessary later.

---

# 55. CUSTOMER TIMELINE

Timeline events may come from:

```text
orders
prescriptions
medications
consultations
appointments
follow_ups
customer interactions
```

Each event:

```text
event_type
title
description
timestamp
actor
source
metadata
```

Do not expose internal technical metadata to customers.

---

# 56. PHARMACY DASHBOARD

The dashboard should prioritize actions.

Primary sections:

```text
Action Center
Key Metrics
Recent Customer Activity
Prescription Queue
Consultations
Follow-ups
Appointments
Customer Demand
```

Possible metrics:

* prescriptions awaiting review
* consultations awaiting response
* follow-ups due
* orders needing attention
* customer requests
* product demand

Avoid excessive charts.

---

# 57. ACTION CENTER

The Action Center should answer:

"What requires attention now?"

Examples:

```text
8 prescriptions awaiting review

4 consultations awaiting response

3 follow-ups due today

6 customer availability requests

2 orders awaiting action
```

Each action should navigate directly to the relevant workflow.

---

# 58. INSIGHTS

Initial insights should be descriptive rather than clinical.

Examples:

```text
Customers with increasing refill requests

Frequently requested unavailable products

Customers returning after consultation

Customers with upcoming appointments

Frequently purchased products

Unfulfilled customer demand
```

Do not make medical predictions.

---

# 59. CUSTOMER SEGMENTS

Possible descriptive segments:

```text
Frequent customers
Recently inactive
Regular medication customers
Customers with upcoming appointments
Customers awaiting prescription action
Customers with open consultations
```

Segments should be generated from transparent rules.

Do not use unexplained black-box scoring in MVP.

---

# 60. REFILL ENGINE

Refill reminders can be generated from:

* historical purchase intervals
* explicit customer schedule
* pharmacist-created reminder

Use language:

> "Your medication may be due for a refill."

Not:

> "You have run out."

Example logic:

```text
Previous purchase:
01 Aug

Typical interval:
30 days

Current date:
27 Aug

Status:
Refill may be approaching
```

Allow pharmacist/customer adjustment.

---

# 61. REMINDER ENGINE

Reminder types:

```text
Medication reminder
Refill reminder
Appointment reminder
Prescription action reminder
Follow-up reminder
```

Store:

```text
reminder_type
scheduled_at
recurrence
status
related_entity
```

Use queued jobs for delivery.

---

# 62. AI ARCHITECTURE — FUTURE READY

Do not make AI a hard dependency for MVP.

Create an abstraction:

```text
AiAssistantInterface
```

Future capabilities:

```text
Medication information assistance
Prescription OCR
Consultation summarization
Timeline summarization
Customer question classification
Demand analysis
Pharmacist copilot
```

AI must always be assistive.

Rule:

> AI assists. Pharmacist decides.

AI must not:

* diagnose
* prescribe
* approve prescriptions independently
* reject prescriptions independently
* override pharmacists
* make unsupported clinical claims

---

# 63. FILE STORAGE

Use private object storage.

Recommended abstraction:

```text
FileStorageService
```

Supports:

* prescription files
* health documents
* consultation attachments
* profile images

Do not permanently expose private health documents through public URLs.

---

# 64. FILE VALIDATION

Validate:

* MIME type
* file size
* extension
* malware/security where available

Limit upload sizes.

Generate safe filenames.

Do not trust client-provided filenames.

---

# 65. AUDIT LOGGING

Audit important actions.

Examples:

```text
login
logout
customer_viewed
customer_updated
prescription_uploaded
prescription_reviewed
prescription_approved
consultation_replied
order_updated
staff_invited
role_changed
integration_connected
integration_disconnected
data_sync_completed
data_sync_failed
document_accessed
settings_changed
```

Audit record:

```text
audit_logs
- id
- pharmacy_id
- user_id
- action
- resource_type
- resource_id
- old_values
- new_values
- ip_address
- user_agent
- created_at
```

Do not store unnecessary sensitive payloads.

---

# 66. SECURITY REQUIREMENTS

Implement:

* HTTPS
* secure authentication
* rate limiting
* CSRF protection where applicable
* API authorization
* tenant isolation
* encrypted credentials
* private file storage
* input validation
* output escaping
* SQL injection protection
* XSS protection
* secure headers
* audit logging
* session revocation
* password hashing
* OTP rate limiting

Never commit:

```text
.env
API keys
payment secrets
OAuth secrets
database passwords
integration credentials
```

to source control.

---

# 67. GHANA-SPECIFIC REQUIREMENTS

Support:

```text
Country:
Ghana

Currency:
GHS / GH₵

Phone:
+233

Payment:
Mobile Money
Card

Communication:
WhatsApp
SMS

Location:
Digital Address
Area
Landmark
```

Do not hard-code Ghana so deeply that internationalization becomes impossible later.

Create configuration:

```text
country
currency
timezone
locale
```

---

# 68. TIMEZONE

Store timestamps consistently.

Backend:

UTC storage.

Frontend:

Convert to configured pharmacy/customer timezone.

Primary MVP timezone:

```text
Africa/Accra
```

Do not use server-local time implicitly.

---

# 69. NOTIFICATION DELIVERY ARCHITECTURE

Use:

```text
NotificationService
    |
    +-- PushChannel
    +-- SmsChannel
    +-- WhatsAppChannel
    +-- EmailChannel
    +-- InAppChannel
```

Each channel should be independently replaceable.

Failed notifications should be retriable.

Use exponential backoff where appropriate.

---

# 70. BACKGROUND JOBS

Use Laravel queues.

Jobs:

```text
SendNotificationJob
ProcessPrescriptionJob
ProcessCsvImportJob
SyncIntegrationJob
GenerateRefillReminderJob
SendAppointmentReminderJob
UpdateDemandJob
ProcessDocumentJob
```

Do not perform expensive work inside HTTP controllers.

---

# 71. EVENTS

Useful domain events:

```text
PrescriptionUploaded
PrescriptionApproved
PrescriptionNeedsAction
OrderCreated
OrderConfirmed
OrderReady
OrderDelivered
ConsultationCreated
ConsultationReplied
AppointmentConfirmed
ProductAvailabilityChanged
CustomerDemandCreated
IntegrationSyncCompleted
IntegrationSyncFailed
```

Listeners can trigger notifications and analytics.

---

# 72. ERROR HANDLING

Backend errors must be structured.

Frontend should map API errors into understandable UX.

Never show:

```text
SQLSTATE[23000]...
```

to customers.

Show:

> "We couldn't complete that request. Please try again."

Log technical details server-side.

---

# 73. OFFLINE BEHAVIOUR

Customer mobile app should gracefully handle network loss.

Support cached read-only information where safe.

When offline:

Show:

> "You're offline. Some information may be unavailable until you're connected."

Do not allow sensitive operations to silently fail.

Queue only operations where conflict handling is safe.

---

# 74. EMPTY STATES

Every major list requires a useful empty state.

Examples:

No prescriptions:

> "Your prescriptions will appear here once you upload one or your pharmacy adds one."

No consultations:

> "No consultations yet."

No orders:

> "Your pharmacy orders will appear here."

No customer demand:

> "No customer requests yet."

Do not use empty states as dead ends.

Provide relevant next action.

---

# 75. TESTING STRATEGY

## Backend

Test:

* authentication
* authorization
* tenant isolation
* prescription workflow
* order workflow
* consultation workflow
* appointment conflicts
* refill logic
* notifications
* integrations
* CSV imports
* audit logging

## Flutter

Test:

* routing
* authentication
* API repositories
* state management
* critical customer journeys
* critical pharmacy journeys
* responsive layouts

---

# 76. CRITICAL ACCEPTANCE TESTS

## Customer registration

```text
Register
→ Verify OTP
→ Complete profile
→ Enter application
```

Must succeed.

---

## Prescription upload

```text
Customer
→ Health
→ Prescriptions
→ Upload
→ Submit
→ Status = Under Review
```

Pharmacist receives notification.

---

## Prescription review

```text
Pharmacist
→ Prescriptions
→ Select prescription
→ Review
→ Approve
```

Audit event created.

Customer receives notification.

---

## Clarification

```text
Pharmacist
→ Request clarification
→ Customer notified
→ Customer responds
→ Pharmacist receives response
```

---

## Consultation

```text
Customer
→ Ask Pharm. David
→ Submit
→ Pharmacist receives
→ Pharmacist replies
→ Customer receives
```

---

## Order

```text
Customer
→ Product
→ Add to cart
→ Checkout
→ Payment
→ Order created
→ Pharmacy receives
→ Status updates
→ Customer notified
```

---

## Restock

```text
Customer
→ Product unavailable
→ Notify me
→ Request stored

External availability changes
→ Sync
→ DavidCare detects availability
→ Customer notification
```

---

## Integration

```text
Pharmacy
→ Integrations
→ Connect system
→ Test
→ Permissions
→ Data mapping
→ Sync
→ Results
```

---

# 77. API ENDPOINT MAP

Initial API structure:

```text
POST   /api/v1/auth/send-otp
POST   /api/v1/auth/verify-otp
POST   /api/v1/auth/logout
GET    /api/v1/me

GET    /api/v1/pharmacies
GET    /api/v1/pharmacies/{id}

GET    /api/v1/customers
GET    /api/v1/customers/{id}
GET    /api/v1/customers/{id}/timeline
GET    /api/v1/customers/{id}/medications
GET    /api/v1/customers/{id}/prescriptions
GET    /api/v1/customers/{id}/orders
GET    /api/v1/customers/{id}/consultations

GET    /api/v1/medications
GET    /api/v1/medications/{id}

GET    /api/v1/prescriptions
POST   /api/v1/prescriptions
GET    /api/v1/prescriptions/{id}
POST   /api/v1/prescriptions/{id}/review
POST   /api/v1/prescriptions/{id}/approve
POST   /api/v1/prescriptions/{id}/clarification

GET    /api/v1/consultations
POST   /api/v1/consultations
GET    /api/v1/consultations/{id}
POST   /api/v1/consultations/{id}/messages

GET    /api/v1/appointments
POST   /api/v1/appointments
PATCH  /api/v1/appointments/{id}

GET    /api/v1/products
GET    /api/v1/products/{id}
POST   /api/v1/products/{id}/watch
DELETE /api/v1/products/{id}/watch

GET    /api/v1/orders
POST   /api/v1/orders
GET    /api/v1/orders/{id}
PATCH  /api/v1/orders/{id}/status

GET    /api/v1/notifications
PATCH  /api/v1/notifications/{id}/read

GET    /api/v1/integrations
POST   /api/v1/integrations
POST   /api/v1/integrations/{id}/test
POST   /api/v1/integrations/{id}/sync
PATCH  /api/v1/integrations/{id}
DELETE /api/v1/integrations/{id}

GET    /api/v1/staff
POST   /api/v1/staff/invite
PATCH  /api/v1/staff/{id}
PATCH  /api/v1/staff/{id}/role

GET    /api/v1/audit-logs

GET    /api/v1/settings
PATCH  /api/v1/settings
```

Adjust exact routes during implementation when the domain model requires it.

---

# 78. REPOSITORY LAYER

Flutter should not call Dio directly from UI widgets.

Use:

```text
UI
↓
Riverpod Provider
↓
Controller / Notifier
↓
Repository
↓
API Client
↓
Laravel API
```

Example:

```text
PrescriptionRepository
    |
    +-- getPrescriptions()
    +-- getPrescription()
    +-- uploadPrescription()
    +-- requestClarification()
```

---

# 79. STATE MANAGEMENT

Use Riverpod.

Example conceptual structure:

```text
prescriptionListProvider
prescriptionDetailProvider
consultationProvider
customer360Provider
orderProvider
notificationProvider
integrationProvider
```

Do not create global mutable state for everything.

Keep state close to the feature that owns it.

---

# 80. ROUTING

Use GoRouter.

Customer routes:

```text
/login
/home
/shop
/shop/product/:id
/cart
/orders
/orders/:id
/health
/health/medications
/health/prescriptions
/health/prescriptions/:id
/health/reminders
/health/consultations
/health/appointments
/profile
/profile/family
/profile/documents
/profile/privacy
```

Pharmacy routes:

```text
/pharmacy/dashboard
/pharmacy/customers
/pharmacy/customers/:id
/pharmacy/prescriptions
/pharmacy/prescriptions/:id
/pharmacy/consultations
/pharmacy/consultations/:id
/pharmacy/follow-ups
/pharmacy/appointments
/pharmacy/orders
/pharmacy/orders/:id
/pharmacy/products
/pharmacy/products/:id
/pharmacy/demand
/pharmacy/insights
/pharmacy/notifications
/pharmacy/integrations
/pharmacy/settings
/pharmacy/staff
/pharmacy/audit
```

Route guards must verify authentication and role/permissions.

---

# 81. UX IMPLEMENTATION RULE

Do not implement every screen as a separate bespoke design.

Build reusable design primitives.

For example:

```text
ListPage
DetailPage
Timeline
StatusCard
FilterBar
SearchBar
FormSection
ConfirmationDialog
EmptyState
```

Then compose them into feature screens.

---

# 82. CUSTOMER BOTTOM NAVIGATION

Use:

```text
Home
Shop
Orders
Health
Profile
```

Notifications remain accessible from the top navigation.

---

# 83. HEALTH HUB

Health contains:

```text
My Medications
Prescriptions
Reminders
Consultations
Appointments
Health Documents
```

Do not scatter health-related functions across unrelated screens.

---

# 84. PHARMACY SIDEBAR

Use:

```text
Dashboard
Customers
Prescriptions
Consultations
Appointments
Orders
Products
Customer Demand
Insights
Notifications

Integrations

Settings
```

Keep the sidebar stable.

---

# 85. PRODUCT CATALOGUE RULE

The pharmacy product catalogue should expose customer-facing product information.

It should not attempt to replicate:

* stock ledger
* purchasing
* suppliers
* warehouses
* GRN
* accounting
* POS checkout

Availability can be synchronized from the external system.

---

# 86. DATA OWNERSHIP

External system:

Potential source of truth:

```text
product availability
purchase records
operational transaction records
```

DavidCare:

Source of truth for:

```text
customer engagement
consultations
follow-ups
appointments
reminders
customer preferences
customer communication
DavidCare orders
customer demand requests
audit activity within DavidCare
```

Define source-of-truth rules explicitly per integration.

---

# 87. IDEMPOTENCY

Critical operations should be idempotent.

Especially:

* payment callbacks
* order creation
* webhook handling
* sync jobs
* notifications

Example:

```text
external_transaction_id
```

must be unique where appropriate.

Do not create duplicate orders from repeated webhook calls.

---

# 88. WEBHOOKS

Prepare backend architecture for:

```text
/payment/webhook
/integrations/{provider}/webhook
```

Verify signatures.

Never trust webhook payloads without validation.

Log webhook processing.

Use idempotency keys.

---

# 89. SECURITY FOR HEALTH INFORMATION

Treat medication, prescription, consultation, appointment, and health-document information as sensitive.

Principles:

* minimum necessary access
* role-based access
* tenant isolation
* private storage
* audit access
* secure transport
* encryption where appropriate
* controlled sharing
* explicit family permissions

Do not display sensitive information in push/SMS previews unnecessarily.

---

# 90. PERFORMANCE

Target:

* fast initial app load
* paginated lists
* lazy-loaded details
* optimized images
* cached read data
* background sync
* queue-based notifications
* efficient PostgreSQL indexes

Important indexes:

```text
customer_pharmacy.pharmacy_id
prescriptions.pharmacy_id
prescriptions.customer_id
prescriptions.status
orders.pharmacy_id
orders.customer_id
orders.status
consultations.pharmacy_id
consultations.status
appointments.pharmacy_id
appointments.scheduled_at
products.pharmacy_id
notifications.user_id
audit_logs.pharmacy_id
```

Add indexes based on real query patterns.

---

# 91. OBSERVABILITY

Prepare:

* application logging
* queue monitoring
* API error tracking
* integration failure logging
* database monitoring
* audit logging

Differentiate:

```text
User-facing error
System error
Integration error
Validation error
Authorization error
```

---

# 92. ENVIRONMENT CONFIGURATION

Use:

```text
.env
.env.example
```

Variables may include:

```text
APP_ENV
APP_KEY
APP_URL

DB_CONNECTION
DB_HOST
DB_PORT
DB_DATABASE
DB_USERNAME
DB_PASSWORD

REDIS_HOST
REDIS_PORT

FILESYSTEM_DISK

MAIL_*
SMS_*
WHATSAPP_*

PAYMENT_*

FCM_*

INTEGRATION_*
```

Never commit real secrets.

---

# 93. SEED DATA

Create realistic demo seed data.

Pharmacy:

```text
DavidCare Pharmacy
Accra
Ghana
```

Customers:

```text
Ama Mensah
Kwame Asante
Akosua Boateng
Kofi Mensah
```

Demo staff:

```text
Pharm. David
Ama Mensah
Kofi Asante
```

Seed:

* medications
* products
* prescriptions
* consultations
* appointments
* orders
* follow-ups
* customer demand
* notifications
* audit events

The seeded data should make every Stitch screen look populated.

---

# 94. DEMO SCENARIOS

Create these scenarios:

## Scenario A

Customer uploads prescription.

## Scenario B

Pharmacist requests clarification.

## Scenario C

Prescription is approved.

## Scenario D

Prescription is partially available.

## Scenario E

Customer requests refill.

## Scenario F

Customer asks pharmacist a question.

## Scenario G

Customer requests unavailable product.

## Scenario H

Product becomes available.

## Scenario I

Customer places pickup order.

## Scenario J

Customer books appointment.

## Scenario K

Pharmacy connects external system.

## Scenario L

Integration sync fails.

## Scenario M

Manager invites staff.

These should be reproducible with seeded data.

---

# 95. MVP PRIORITY

The one-week MVP should NOT attempt to fully implement every future feature.

## P0 — Must work

Authentication

Customer profile

Pharmacy profile

Customer/pharmacy relationship

Medication records

Prescription upload

Prescription review

Prescription status

Consultations

Pharmacist responses

Orders

Product catalogue

Availability/watch

Notifications

Pharmacy dashboard

Customer 360

Staff roles

Basic audit logging

Basic integration framework

---

## P1 — Implement if time permits

Appointments

Refill engine

Family/dependents

Health documents

CSV import

Payment integration

WhatsApp integration

Advanced customer demand

Advanced insights

---

## P2 — Future

AI assistant

Prescription OCR

Medication interaction assistance

Advanced demand intelligence

Advanced analytics

Multiple pharmacy switching

Advanced integrations

Advanced automation

---

# 96. ONE-WEEK IMPLEMENTATION PLAN

## DAY 1 — FOUNDATION

Set up:

Flutter

Laravel

PostgreSQL

Authentication

Project architecture

Theme

Routing

API client

Database migrations

RBAC foundation

---

## DAY 2 — CUSTOMER CORE

Build:

Customer onboarding

Home

Shop

Products

Product detail

Orders

Profile

Health hub

---

## DAY 3 — MEDICATION + PRESCRIPTIONS

Build:

Medications

Medication timeline

Prescription upload

Prescription list

Prescription detail

Pharmacist review

Prescription status

Audit events

---

## DAY 4 — CONSULTATION + ORDERS

Build:

Ask Pharm. David

Consultation list

Consultation detail

Messages

Follow-ups

Order workflow

Order tracking

Notifications

---

## DAY 5 — PHARMACY DASHBOARD

Build:

Dashboard

Action Center

Customers

Customer 360

Customer timeline

Prescriptions

Consultations

Appointments

Customer demand

---

## DAY 6 — SETTINGS + INTEGRATIONS

Build:

Staff

Roles

Permissions

Pharmacy settings

Notifications

Privacy/security

Audit log

Integration framework

CSV import foundation

---

## DAY 7 — POLISH + TESTING

Complete:

Responsive behaviour

Empty states

Loading states

Error states

Validation

Security

Seed data

Critical workflows

API testing

Flutter testing

Bug fixing

Production build

---

# 97. DEFINITION OF DONE

A feature is not complete merely because its screen exists.

Each feature must have:

```text
UI
+
API
+
Database
+
Validation
+
Authorization
+
Loading state
+
Empty state
+
Error state
+
Success state
+
Auditability where appropriate
+
Test
```

---

# 98. CURSOR DEVELOPMENT RULES

When implementing this PRD:

1. Do not invent product functionality that conflicts with this document.

2. Do not turn DavidCare into a POS.

3. Do not duplicate pharmacy inventory management.

4. Do not build fake integrations that pretend to communicate with external systems.

5. If an integration provider is unavailable, create an adapter interface and mock implementation.

6. Never hard-code secrets.

7. Never bypass backend authorization.

8. Never expose tenant data across pharmacies.

9. Never automatically approve prescriptions.

10. Never diagnose customers.

11. Never make unsupported clinical claims.

12. Never put business logic exclusively inside Flutter.

13. Never put complex business logic inside Laravel controllers.

14. Keep database migrations explicit.

15. Use reusable services/actions.

16. Use API Resources.

17. Validate every request.

18. Paginate large collections.

19. Use queues for expensive/background operations.

20. Keep the frontend responsive.

21. Match the Google Stitch designs.

22. Prefer simple architecture over unnecessary abstraction.

23. Build P0 functionality before P1/P2.

24. Do not spend MVP time polishing future AI functionality.

25. Do not create placeholder screens that imply functionality that does not exist.

---

# 99. IMPLEMENTATION WORKFLOW IN CURSOR

For every feature:

```text
1. Read this PRD
2. Identify relevant Stitch screen
3. Inspect existing code
4. Identify database entities
5. Create/update migration
6. Create/update model
7. Create validation request
8. Create policy
9. Create service/action
10. Create controller
11. Create API resource
12. Add route
13. Add Flutter model
14. Add repository
15. Add Riverpod provider
16. Implement UI
17. Add loading/error/empty/success states
18. Add tests
19. Run formatter
20. Run static analysis
21. Run tests
22. Fix regressions
```

Do not jump directly from Stitch UI to frontend code without implementing the underlying domain logic.

---

# 100. DEVELOPMENT ORDER

Implement in this order:

```text
FOUNDATION
    ↓
AUTH
    ↓
MULTI-TENANCY
    ↓
RBAC
    ↓
CUSTOMERS
    ↓
MEDICATIONS
    ↓
PRESCRIPTIONS
    ↓
CONSULTATIONS
    ↓
ORDERS
    ↓
NOTIFICATIONS
    ↓
PHARMACY DASHBOARD
    ↓
CUSTOMER 360
    ↓
DEMAND
    ↓
APPOINTMENTS
    ↓
STAFF
    ↓
SETTINGS
    ↓
INTEGRATIONS
    ↓
AUDIT
    ↓
POLISH
```

---

# 101. PRODUCT NORTH STAR

DavidCare should ultimately become:

> The digital relationship layer between a pharmacy and its customers.

The pharmacy should use DavidCare to understand:

* who its customers are
* what they need
* what medications they manage
* what prescriptions require attention
* what customers are asking for
* who needs follow-up
* what consultations are active
* what customers are likely to return for
* what products customers are requesting

The customer should use DavidCare to:

* know their medicines
* manage prescriptions
* request refills
* remember medications
* ask their pharmacist
* communicate with their pharmacy
* order eligible products
* manage appointments
* keep relevant health documents
* stay connected to their pharmacy

---

# 102. FINAL ENGINEERING PRINCIPLE

Build DavidCare so that a developer can understand:

```text
WHY the product exists
WHAT each feature does
WHO can use it
WHAT data it needs
HOW the data moves
WHAT the backend owns
WHAT the external pharmacy system owns
WHAT the customer sees
WHAT the pharmacist sees
WHAT must be audited
WHAT must never happen
```

The resulting application should feel:

**Simple for customers.**

**Powerful for pharmacists.**

**Actionable for pharmacy managers.**

**Secure by design.**

**Integration-ready.**

**AI-ready without depending on AI.**

**Independent of POS systems.**

**Production-ready rather than a collection of mockups.**
