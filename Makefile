# Development purposes

PID = /tmp/serving.pid

serve: start
	fswatch -or --event=Updated . | xargs -n1 -I {} make restart

kill:
	-kill `pstree -p \`cat $(PID)\` | tr "\n" " " |sed "s/[^0-9]/ /g" |sed "s/\s\s*/ /g"` 
	
before:
	@echo "STOPED" && printf '%*s\n' "40" '' | tr ' ' -

start:
	./scripts/dev.sh & echo $$! > $(PID)

restart: kill before start
	@echo "STARTED" && printf '%*s\n' "40" '' | tr ' ' -
	
.PHONY: serve restart kill before start 
 