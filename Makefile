.PHONY: release
release: ## Issues a release
	@test -n "$(TAG)" || (echo "The TAG variable must be set" && exit 1)
	@echo "Releasing v$(TAG)"
	git checkout -b "release-$(TAG)"
	sed -i "s%[Version: .*]%[Version: $(TAG)]%" README.md
	sed -i "s%/Version-.*-]%/Version-$(TAG)-%" README.md
	sed -i "s%version: .*%version: $(TAG)%" Chart.yaml
	git add README.md
	git add Chart.yaml
	git commit -m "Release v$(TAG)"
	git tag -m "Release v$(TAG)" "v$(TAG)"
	git push origin "release-$(TAG)"
	git push origin "v$(TAG)"

