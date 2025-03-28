build:
	@echo "Build"
	docker build -t tl-ubuntu tl-ubuntu
	docker build -t tl-vault tl-vault
clean: 
	rm -r raft/
	mkdir -p raft/server1
	mkdir -p raft/server2
