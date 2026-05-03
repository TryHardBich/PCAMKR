
install:
	npm i
lint: 
	npm run lint
lint-fix:
	npm run lint:fix
database:
	docker exec -it my-postgresSQL psql -U postgres -d pc_components
