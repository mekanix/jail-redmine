# -*- mode: ansible -*-
# vi: set ft=ansible :

---
- name: PROJECT provisioning
  hosts: PROJECT
  roles:
    - dummy

- name: WEB_PROJECT provisioning
  hosts: WEB_PROJECT
  roles:
    - web

- name: localhost provisioning
  hosts: localhost
  roles:
    - resolve_web
