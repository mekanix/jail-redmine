PROJECT ansible_connection=jail ansible_python_interpreter='"/usr/bin/env python"'
DB_PROJECT ansible_connection=jail ansible_python_interpreter='"/usr/bin/env python"'
localhost ansible_connection=local ansible_python_interpreter='"/usr/bin/env python"'

[STAGE]
PROJECT

[db]
DB_PROJECT
