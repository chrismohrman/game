test:
	docker build --quiet -t love-experiment . && \
	docker run love-experiment && \
	docker run --rm love-experiment sh -c "busted --lua=luajit . && luacov-coveralls -e usr/ -e lib/ -e .spec.lua --dryrun"
