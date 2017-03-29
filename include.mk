.if !defined(PROJECT)
PROJECT=redmine
.endif

.if !defined(DB_PROJECT)
DB_PROJECT=postgresql
.endif

.if !defined(DOMAIN)
DOMAIN=example.com
.endif

.if !defined(INVENTORY)
INVENTORY=localhost
.endif

.if !defined(STAGE)
STAGE=prod
.endif

.if !defined(UID)
UID=1001
.endif

.if !defined(GID)
GID=1001
.endif
