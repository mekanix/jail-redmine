# -*- mode: ansible -*-
# vi: set ft=ansible :

---
- name: gather facts
  hosts: PROJECT
  roles:
    - dummy

- name: DB_PROJECT provisioning
  hosts: DB_PROJECT
  roles:
    - postgresql
