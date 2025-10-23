# Global wake on LAN for dorian from aelin

### 1. Login to `lorcan`
---
Connect to `lorcan` from `aelin` with command:

```
ssh lorcan-ssh.placeholder.domain.com
```

### 2. Send Wake Command
---
Login and then send command:

```
wakeonlan -i placeholder.dorian.local.ip placeholder:dorian:mac:adress
```
or in `~/`:
```
just wake
```