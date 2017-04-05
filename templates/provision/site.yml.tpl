# -*- mode: ansible -*-
# vi: set ft=ansible :

---
- name: gather facts
  hosts: DB_PROJECT, PROJECT
  roles:
    - dummy

- name: PROJECT DB provisioning
  hosts: db
  roles:
    - postgresql

- name: PROJECT provisioning
  hosts: PROJECT
  roles:
    - common
    - redmine

- name: PROJECT localhost provisioning
  hosts: localhost
  roles:
    - localhost
