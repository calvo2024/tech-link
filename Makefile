build:
	@echo "Build"
	docker build -t tl-ubuntu tl-ubuntu
	docker build -t tl-vault tl-vault
	docker build -t tl-vault-hsm tl-vault-hsm