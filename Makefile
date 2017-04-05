.if exists(vars.mk)
.include <vars.mk>
.endif

.include <include.mk>


provision: up
	@sudo ansible-playbook -i provision/inventory/${INVENTORY} provision/site.yml

up: setup
	@sudo cbsd jcreate jconf=${PWD}/cbsd.conf || true
	@sudo sh -c 'sed -e "s:PWD:${PWD}:g" -e "s:PROJECT:${PROJECT}:g" templates/fstab.conf.${STAGE}.tpl >/cbsd/jails-fstab/fstab.${PROJECT}'
	@sudo chown ${UID}:${GID} cbsd.conf
	@sudo cbsd jstart ${PROJECT} || true

down: setup
	@sudo cbsd jstop ${PROJECT} || true
	@sudo ansible-playbook -i provision/inventory/${INVENTORY} provision/teardown.yml

destroy: down
	@rm -f provision/inventory/${INVENTORY} provision/site.yml provision/group_vars/all cbsd.conf vars.mk
	@sudo cbsd jremove ${PROJECT}

setup:
	@sed -e "s:PROJECT:${PROJECT}:g" -e "s:DOMAIN:${DOMAIN}:g" templates/cbsd.conf.${STAGE}.tpl >cbsd.conf
	@sed -e "s:PROJECT:${PROJECT}:g" -e "s:DOMAIN:${DOMAIN}:g" templates/provision/group_vars/all.tpl >provision/group_vars/all
	@sed -e "s:DB_PROJECT:${DB_PROJECT}:g" -e "s:PROJECT:${PROJECT}:g" templates/provision/site.yml.tpl >provision/site.yml
	@sed -e "s:DB_PROJECT:${DB_PROJECT}:g" -e "s:PROJECT:${PROJECT}:g" templates/provision/inventory/localhost.${STAGE}.tpl >provision/inventory/${INVENTORY}
	@sed -e "s:WEB_PROJECT:${WEB_PROJECT}:g" -e "s:PROJECT:${PROJECT}:g" templates/provision/web.yml.tpl >provision/web.yml
	@sed -e "s:WEB_PROJECT:${WEB_PROJECT}:g" -e "s:PROJECT:${PROJECT}:g" templates/provision/inventory/web.${STAGE}.tpl >provision/inventory/web

login:
	@sudo cbsd jlogin ${PROJECT}

exec:
	@sudo cbsd jexec jname=${PROJECT} ${command}

build:
	@echo -n "Exporting jail ... "
	@sudo cbsd jexport ${PROJECT}
	@sudo mv /cbsd/export/${PROJECT}.img .
	@sudo chown ${UID}:${GID} ${PROJECT}.img

web: setup
	@sudo ansible-playbook -i provision/inventory/web provision/web.yml
